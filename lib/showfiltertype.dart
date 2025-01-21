import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:onlineapp_mike/productdetail.dart';
import 'package:intl/intl.dart';

class ShowFilterType extends StatefulWidget {
  final String category; // รับประเภทสินค้าที่ถูกส่งจากหน้าก่อน

  ShowFilterType({Key? key, required this.category}) : super(key: key);

  @override
  _ShowFilterTypeState createState() => _ShowFilterTypeState();
}

class _ShowFilterTypeState extends State<ShowFilterType> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('products');
  List<Map<String, dynamic>> filteredProducts = []; // เก็บสินค้าที่กรอง

  // ฟังก์ชันดึงข้อมูลสินค้าโดยกรองตามประเภท
  Future<void> fetchFilteredProducts() async {
    try {
      final snapshot = await dbRef.get();
      if (snapshot.exists) {
        List<Map<String, dynamic>> products = [];
        snapshot.children.forEach((child) {
          Map<String, dynamic> product = Map<String, dynamic>.from(child.value as Map);
          // ตรวจสอบว่าเป็นสินค้าประเภทเดียวกับที่กด
          if (product['category'] == widget.category) {
            products.add(product);
          }
        });
        setState(() {
          filteredProducts = products;
        });
      } else {
        print("ไม่พบข้อมูลสินค้าในฐานข้อมูล");
      }
    } catch (e) {
      print("Error loading filtered products: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFilteredProducts();
  }
String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd/MMMM/yyyy').format(parsedDate);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สินค้าในหมวดหมู่: ${widget.category}'),
        backgroundColor: Color.fromARGB(255, 4, 0, 255),
      ),
      body: filteredProducts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        product['name'] ?? 'ไม่มีชื่อสินค้า',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(children: [
                        Text('รายละเอียดสินค้า : ${product['description']}'),
                        Text(
                            'วันที่ผลิตสินค้า : ${formatDate(product['productionDate'])}'),
                        Text('จำนวน : ${(product['quantity'])}')
                      ]),
                      trailing: Text('ราคา : ${product['price']} บาท',style: TextStyle(
                            fontSize: 14),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetail(product: product),
                          ),
                        );
                        // เพิ่มการกระทำเมื่อกดที่สินค้า
                      },
                    ),
                  );
              },
            ),
    );
  }
}
