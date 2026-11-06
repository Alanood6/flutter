import 'package:flutter/material.dart';

// ================= MEDICINE MODEL =================

class Medicine {
  final String name;
  final String description;
  final String category;
  final String price;
  final String image;
  final List<String> pharmacies;

  const Medicine({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.image,
    required this.pharmacies,
  });
}

final List<Medicine> medicines = [
  Medicine(
    name: "Panadol",
    description: "مسكن للألم وخافض للحرارة.",
    category: "مسكنات",
    price: "500 ريال",
    image: "assets/images/Panadol.jpg",
    pharmacies: ["صيدلية الشفاء", "صيدلية الحياة"],
  ),
  Medicine(
    name: "Brufen",
    description: "دواء مسكن ومضاد للالتهاب.",
    category: "مسكنات",
    price: "800 ريال",
    image: "assets/images/Brufen.jpg",
    pharmacies: ["صيدلية النور", "صيدلية الحياة"],
  ),
  Medicine(
    name: "Vitamin C",
    description: "مكمل غذائي يحتوي على فيتامين C.",
    category: "فيتامينات",
    price: "1200 ريال",
    image: "assets/images/Vitamin C.jpg",
    pharmacies: ["صيدلية النور", "صيدلية الشفاء"],
  ),
  Medicine(
    name: "Omega 3",
    description: "مكمل غذائي يحتوي على أحماض أوميغا 3.",
    category: "فيتامينات",
    price: "2500 ريال",
    image: "assets/images/Omega3.jpg",
    pharmacies: ["صيدلية الحياة"],
  ),
  Medicine(
    name: "Zinc",
    description: "مكمل غذائي يحتوي على الزنك.",
    category: "فيتامينات",
    price: "1500 ريال",
    image: "assets/images/Zinc.jpg",
    pharmacies: ["صيدلية الشفاء"],
  ),
  Medicine(
    name: "Amoxicillin",
    description: "مضاد حيوي يُستخدم لعلاج بعض الالتهابات البكتيرية.",
    category: "مضادات حيوية",
    price: "2000 ريال",
    image: "assets/images/Amoxicillin.jpg",
    pharmacies: ["صيدلية النور"],
  ),
  Medicine(
    name: "Cetirizine",
    description: "دواء مضاد للحساسية.",
    category: "الحساسية",
    price: "1000 ريال",
    image: "assets/images/Cetirizine.jpg",
    pharmacies: ["صيدلية الحياة", "صيدلية الشفاء"],
  ),
  Medicine(
    name: "Cough Syrup",
    description: "شراب لتخفيف السعال.",
    category: "أدوية أخرى",
    price: "1500 ريال",
    image: "assets/images/Cough Syrup.jpg",
    pharmacies: ["صيدلية النور"],
  ),
  Medicine(
    name: "ORS",
    description: "محلول أملاح الإماهة الفموية.",
    category: "أدوية أخرى",
    price: "500 ريال",
    image: "assets/images/ORS sales melt in March.jpg",
    pharmacies: ["صيدلية الشفاء"],
  ),
  Medicine(
    name: "Iron",
    description: "مكمل غذائي يحتوي على الحديد.",
    category: "فيتامينات",
    price: "1800 ريال",
    image: "assets/images/Iron.jpg",
    pharmacies: ["صيدلية الحياة"],
  ),
];

final List<Medicine> favoriteMedicines = [];

