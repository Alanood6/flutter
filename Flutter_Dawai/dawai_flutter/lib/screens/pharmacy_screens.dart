import 'package:flutter/material.dart';

import '../core.dart';
import '../data.dart';
import 'medicine_screens.dart';

// ================= PHARMACIES SCREEN =================

class PharmaciesScreen extends StatelessWidget {
  const PharmaciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pharmacies = [
      {
        "name": "صيدلية الشفاء",
        "address": "المكلا - فوة",
        "distance": "1.2 كم",
        "phone": "777000001",
        "hours": "مفتوحة على مدار الساعة",
      },
      {
        "name": "صيدلية الحياة",
        "address": "المكلا - الديس",
        "distance": "2.5 كم",
        "phone": "777000002",
        "hours": "8 صباحًا - 12 مساءً",
      },
      {
        "name": "صيدلية النور",
        "address": "المكلا - الشرج",
        "distance": "3.1 كم",
        "phone": "777000003",
        "hours": "8 صباحًا - 11 مساءً",
      },
    ];

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
                  "الصيدليات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "اكتشف الصيدليات ومعلوماتها",
                  style: TextStyle(color: C.lavender),
                ),

                const SizedBox(height: 22),

                // بطاقة الموقع
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF7652A8),
                        Color(0xFF35204D),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        right: 20,
                        top: 20,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),

                      const Positioned(
                        left: 20,
                        bottom: 20,
                        child: Icon(
                          Icons.map_outlined,
                          color: Colors.white24,
                          size: 100,
                        ),
                      ),

                      const Positioned(
                        right: 20,
                        bottom: 25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الصيدليات القريبة",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "المكلا - حضرموت",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "الصيدليات المتاحة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                ...pharmacies.map((pharmacy) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: C.purple.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: const Icon(
                                  Icons.local_pharmacy,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),

                              const SizedBox(width: 13),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pharmacy["name"]!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      pharmacy["address"]!,
                                      style: const TextStyle(
                                        color: C.lavender,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Icon(
                                Icons.verified,
                                color: C.lavender,
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: C.lavender,
                                size: 19,
                              ),

                              const SizedBox(width: 6),

                              Text(
                                pharmacy["distance"]!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),

                              const SizedBox(width: 18),

                              const Icon(
                                Icons.access_time,
                                color: C.lavender,
                                size: 19,
                              ),

                              const SizedBox(width: 6),

                              Expanded(
                                child: Text(
                                  pharmacy["hours"]!,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "سيتم ربط الموقع بالخريطة لاحقًا",
                                        ),
                                      ),
                                    );
                                  },

                                  icon: const Icon(
                                    Icons.map_outlined,
                                    color: Colors.white,
                                  ),

                                  label: const Text(
                                    "الموقع",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),

                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: C.lavender,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "رقم الهاتف: ${pharmacy["phone"]}",
                                        ),
                                      ),
                                    );
                                  },

                                  icon: const Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),

                                  label: const Text(
                                    "اتصال",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),

                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: C.lavender,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ================= FAVORITES SCREEN =================

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
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
                  "الأدوية المفضلة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: favoriteMedicines.isEmpty
                      ? const Center(
                          child: Text(
                            "لم تضيفي أي دواء للمفضلة بعد 💜",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: C.lavender,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView(
                          children: favoriteMedicines.map((medicine) {
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
