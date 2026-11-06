import 'package:flutter/material.dart';

import '../core.dart';
import '../data.dart';

// ================= MEDICINES SCREEN =================

class MedicinesScreen extends StatefulWidget {
  final String searchText;

  const MedicinesScreen({
    super.key,
    this.searchText = "",
  });

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  String search = "";

  @override
  void initState() {
    super.initState();
    search = widget.searchText;
  }

  @override
  Widget build(BuildContext context) {
    final filteredMedicines = medicines.where((medicine) {
      return medicine.name.toLowerCase().contains(search.toLowerCase()) ||
          medicine.category.contains(search);
    }).toList();

    return Stack(
      children: [
        const LuxuryBackground(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "قائمة الأدوية",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                  decoration: fieldDecoration(
                    "ابحث عن دواء",
                    Icons.search,
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView(
                    children: filteredMedicines.isEmpty
                        ? const [
                            Text(
                              "لا توجد أدوية مطابقة",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ]
                        : filteredMedicines.map((medicine) {
                            return MedicineCard(
                              medicine: medicine,
                            );
                          }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ================= MEDICINE CARD =================

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  const MedicineCard({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MedicineDetailsScreen(
                medicine: medicine,
              ),
            ),
          );
        },
        child: glassCard(
          child: Row(
            children: [
              ClipRRect(
  borderRadius: BorderRadius.circular(14),
  child: Image.asset(
    medicine.image,
    width: 85,
    height: 85,
    fit: BoxFit.contain,
  ),
),
              
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      medicine.category,
                      style: const TextStyle(
                        color: C.lavender,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      medicine.price,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: C.lavender,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= MEDICINE DETAILS =================

class MedicineDetailsScreen extends StatefulWidget {
  final Medicine medicine;

  const MedicineDetailsScreen({
    super.key,
    required this.medicine,
  });

  @override
  State<MedicineDetailsScreen> createState() =>
      _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState
    extends State<MedicineDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final medicine = widget.medicine;

    final isFavorite = favoriteMedicines.contains(medicine);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            const LuxuryBackground(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    glassCard(
                      child: Column(
                        children: [
                          ClipRRect(
  borderRadius: BorderRadius.circular(14),
  child: Image.asset(
    medicine.image,
    width: 85,
    height: 85,
    fit: BoxFit.contain,
  ),
),
                          const SizedBox(height: 15),
                          Text(
                            medicine.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            medicine.category,
                            style: const TextStyle(
                              color: C.lavender,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            medicine.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            medicine.price,
                            style: const TextStyle(
                              color: C.lavender,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "الصيدليات المتوفر فيها",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    ...medicine.pharmacies.map(
                      (pharmacy) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: glassCard(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.local_pharmacy,
                                color: C.lavender,
                                size: 30,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  pharmacy,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    gradientButton(
                      text: isFavorite
                          ? "إزالة من المفضلة"
                          : "إضافة إلى المفضلة",
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoriteMedicines.remove(medicine);
                          } else {
                            favoriteMedicines.add(medicine);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

