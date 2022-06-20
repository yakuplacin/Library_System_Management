import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_system/Book.dart';
import 'package:library_system/change_status.dart';
import 'package:library_system/ui/screens/cart/cart_screen.dart';
import 'package:library_system/ui/screens/sign_in/sign_in_screen.dart';
import 'package:library_system/updatebook_page.dart';
import 'package:http/http.dart' as http;

import 'addbook_page.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateBookList();
    setState(() {});
  }

  Future<dynamic> generateBookList() async {
    print('asa');
    // Give your sever URL of get_employees_details.php file
    var url = Uri.parse('http://10.0.2.2/login/book.php');
    final response =
        await http.get(Uri.parse('http://10.0.2.2/login/book.php'));
    var list = json.decode(response.body);
    List<Book> book =
        await list.map<Book>((json) => Book.fromJson(json)).toList();
    print(book[0].book_id);
    setState(() {
      books = book;
    });
    return book;
  }

  List<Book> books = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
                color: Color(0xFFF5CEB8),
                image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    image: NetworkImage(
                        'https://i.pinimg.com/736x/0b/15/fb/0b15fb145a8e9dc03468836f37968a84.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.2)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2BEA1).withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.menu_book_sharp,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to System',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      Text(
                        'Management',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 30),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13.5),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 17),
                                  blurRadius: 17,
                                  spreadRadius: -23,
                                  color: Colors.red,
                                )
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateBookPage()));
                              },
                              child: Column(
                                children: [
                                  Spacer(),
                                  Image.asset(
                                    'assets/images/update.png',
                                    width: 90,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Update Book',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        // MenuCard(
                        //     title: 'Update Books',
                        //     imagePath:
                        //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCjKLg5bpIQa_yCH3wCU_G90nPInE8W57-Ww&usqp=CAU'),

                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13.5),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 17),
                                  blurRadius: 17,
                                  spreadRadius: -23,
                                  color: Colors.red,
                                )
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartScreen(
                                        books: books, title: "Change Status"),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Spacer(),
                                  Image.asset('assets/images/status.png',
                                      height: 80),
                                  Spacer(),
                                  Text(
                                    'Change Status',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        //
                        // MenuCard(
                        //     title: 'Change Status',
                        //     imagePath:
                        //         'https://meaning-dictionary.com/wp-content/uploads/2021/06/11.jpg'),

                        // MenuCard(
                        //   title: 'Add/Remove a Book',
                        //   imagePath:
                        //       'https://www.shareicon.net/data/256x256/2016/06/27/623443_book_256x256.png',
                        // ),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13.5),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 17),
                                  blurRadius: 17,
                                  spreadRadius: -23,
                                  color: Colors.red,
                                )
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddBookPage()));
                              },
                              child: Column(
                                children: [
                                  Spacer(),
                                  Image.asset('assets/images/add.png',
                                      height: 80),
                                  Spacer(),
                                  Text(
                                    'Add a Book',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        MenuCard(
                          title: 'Log Out',
                          imagePath: 'assets/images/logout.png',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const MenuCard({Key? key, required this.imagePath, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: Colors.red,
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    'The book has been updated!',
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    SizedBox(width: 5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          fixedSize: const Size.fromWidth(100),
                          padding: const EdgeInsets.all(10)),
                      child: const Text("YES"),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                            (route) => false);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          fixedSize: const Size.fromWidth(100),
                          padding: const EdgeInsets.all(10)),
                      child: const Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 5),
                  ],
                );
              },
            );
          },
          child: Column(
            children: [
              Spacer(),
              Image.asset(imagePath, height: 80),
              Spacer(),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
