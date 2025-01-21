import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onlineapp_mike/showproductgrid.dart';
import 'package:onlineapp_mike/showproducttype.dart';
import 'addproduct.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDHKYAu2m6fi-PVg1J2tSNJf8-2Q2MPlT4",
            authDomain: "onlinefirebase-a83c9.firebaseapp.com",
            databaseURL:
                "https://onlinefirebase-a83c9-default-rtdb.firebaseio.com",
            projectId: "onlinefirebase-a83c9",
            storageBucket: "onlinefirebase-a83c9.firebasestorage.app",
            messagingSenderId: "22256449870",
            appId: "1:22256449870:web:d51292b47474698e2c061f",
            measurementId: "G-6ZN68L9MDN"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 4, 0, 255)),
        useMaterial3: true,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Main> {
  // กำหนดขนาดของปุ่ม
  double buttonWidth = 300.0; // กำหนดความกว้างของปุ่ม
  double buttonHeight = 50.0; // กำหนดความสูงของปุ่ม

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
          'จัดการข้อมูลสินค้า',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: Color.fromARGB(255, 4, 0, 255),
      ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, 
                    crossAxisAlignment: CrossAxisAlignment.center, 
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0,
                            right: 50.0,
                            top: 20.0),
                        child: Image.asset(
                          'assets/m.jpg', 
                          width: 150, 
                          height: 150, 
                          fit: BoxFit.cover, 
                        ),
                      ),
                      SizedBox(height: 20),
                      // ปุ่ม "บันทึกข้อมูลสินค้า"
                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addproduct()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 4, 0, 255)), // เปลี่ยนสีปุ่ม
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white), // เปลี่ยนสีข้อความ
                            elevation: MaterialStateProperty.all(10), // เพิ่มเงา
                            shadowColor: MaterialStateProperty.all(Colors.black), // สีของเงา
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // ขอบมน
                              ),
                            ),
                          ),
                          child: Text('บันทึกข้อมูลสินค้า'),
                        ),
                      ),
                      SizedBox(height: 20),
                      // ปุ่ม "แสดงข้อมูลสินค้า"
                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => showproductgrid()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 4, 0, 255)), // เปลี่ยนสีปุ่ม
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white), // เปลี่ยนสีข้อความ
                            elevation: MaterialStateProperty.all(10), // เพิ่มเงา
                            shadowColor: MaterialStateProperty.all(Colors.black), // สีของเงา
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // ขอบมน
                              ),
                            ),
                          ),
                          child: Text('แสดงข้อมูลสินค้า'),
                        ),
                      ),
                      SizedBox(height: 20),
                      // ปุ่ม "ประเภทสินค้า"
                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => showproducttype()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 4, 0, 255)), // เปลี่ยนสีปุ่ม
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white), // เปลี่ยนสีข้อความ
                            elevation: MaterialStateProperty.all(10), // เพิ่มเงา
                            shadowColor: MaterialStateProperty.all(Colors.black), // สีของเงา
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // ขอบมน
                              ),
                            ),
                          ),
                          child: Text('ประเภทสินค้า'),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
        ));
  }
}
