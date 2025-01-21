import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:onlineapp_mike/showfiltertype.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 164, 196),
        ),
        useMaterial3: true,
      ),
      home: showproducttype(),
    );
  }
}

class showproducttype extends StatefulWidget {
  @override
  State<showproducttype> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<showproducttype> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('products');
  List<String> categories = [];

  Future<void> fetchCategories() async {
    try {
      final snapshot = await dbRef.get();
      if (snapshot.exists) {
        Set<String> categorySet = Set();
        snapshot.children.forEach((child) {
          Map<String, dynamic> product = Map<String, dynamic>.from(child.value as Map);
          if (product.containsKey('category')) {
            categorySet.add(product['category']);
          }
        });
        setState(() {
          categories = categorySet.toList();
        });
      } else {
        print("ไม่พบข้อมูลสินค้าในฐานข้อมูล");
      }
    } catch (e) {
      print("Error loading categories: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  // ฟังก์ชันเพื่อโหลดรูปภาพที่ตรงกับประเภทสินค้า
  String getImageForCategory(String category) {
    switch (category) {
      case 'Electronics':
        return 'assets/electronics.png';
      case 'Clothing':
        return 'assets/clothing.jpg';
      case 'Food':
        return 'assets/food.png';
      case 'Books':
        return 'assets/books.png';
      default:
        return 'assets/default.png'; // กรณีไม่มีรูปที่ตรงกับประเภท
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ประเภทสินค้า',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: Color.fromARGB(255, 4, 0, 255),
      ),
      body: categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowFilterType(category: category),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 120,
                            height: 100,
                            child: Center(
                              child: Column(
                                children: [
                                  // แสดงชื่อประเภทสินค้า
                                  Text(
                                    category,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 10),
                                  // แสดงรูปภาพตามประเภทสินค้า
                                  Image.asset(
                                    getImageForCategory(category),
                                    width: 60,
                                    height: 60,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
