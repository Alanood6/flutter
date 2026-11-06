import 'package:flutter/material.dart';

import '../core.dart';
import '../data.dart';
import 'medicine_screens.dart';
import 'pharmacy_screens.dart';

// ================= HOME SCREEN =================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeContent(),
    MedicinesScreen(),
    PharmaciesScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: C.dark,
        body: screens[selectedIndex],
       bottomNavigationBar: BottomNavigationBar(
  backgroundColor: const Color(0xFF241632),
  currentIndex: selectedIndex,
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white70,
  type: BottomNavigationBarType.fixed,
  onTap: (index) {
    setState(() {
      selectedIndex = index;
    });
  },
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: "الرئيسية",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.medication_outlined),
      activeIcon: Icon(Icons.medication),
      label: "الأدوية",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_pharmacy_outlined),
      activeIcon: Icon(Icons.local_pharmacy),
      label: "الصيدليات",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      activeIcon: Icon(Icons.favorite),
      label: "المفضلة",
    ),
  ],
),
      )
    );
  }
}

// ================= HOME CONTENT =================

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController searchController =
      TextEditingController();

  List<Medicine> get searchResults {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) return [];

    return medicines.where((medicine) {
      return medicine.name.toLowerCase().startsWith(query) ||
          medicine.category.toLowerCase().startsWith(query) ||
          medicine.name.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const LuxuryBackground(),

        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "مرحباً بك في دوائي 💜",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "اعثر على دوائك بسهولة",
                  style: TextStyle(color: C.lavender),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: searchController,
                  style: const TextStyle(color: Colors.white),

                  onChanged: (_) {
                    setState(() {});
                  },

                  decoration: fieldDecoration(
                    "ابحث عن اسم الدواء",
                    Icons.search,
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),

                if (searchController.text.isNotEmpty) ...[
                  const SizedBox(height: 15),

                  const Text(
                    "نتائج البحث",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (searchResults.isEmpty)
                    const Text(
                      "لا توجد أدوية بهذا الاسم",
                      style: TextStyle(color: C.lavender),
                    ),

                  ...searchResults.map(
                    (medicine) => MedicineCard(
                      medicine: medicine,
                    ),
                  ),
                ],

                if (searchController.text.isEmpty) ...[
                  const SizedBox(height: 25),

                  glassCard(
                    child: const Column(
                      children: [
                        Icon(
                          Icons.health_and_safety,
                          color: C.lavender,
                          size: 55,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "دواؤك أقرب إليك",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "اكتشف الأدوية والصيدليات المتوفرة",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: C.lavender),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "الأدوية الأكثر بحثاً",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ...medicines.take(4).map(
                    (medicine) => MedicineCard(
                      medicine: medicine,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

