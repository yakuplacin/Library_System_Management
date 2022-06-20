import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_system/reservebook_page.dart';
import 'package:library_system/student_main_page.dart';
import 'package:library_system/ui/constants.dart';
import 'package:library_system/ui/screens/details/details_screen.dart';
import 'package:library_system/ui/screens/sign_in/components/sign_form.dart';
import 'package:library_system/wishlistBookId.dart';

import 'Book.dart';
import 'admin_main_page.dart';

class Wishlist extends StatefulWidget {
  var datause;

  Wishlist(this.datause, {Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  void initState() {
    // print('Init is started here');
    generateWishlistIds();
    setState(() {});
  }

  late List<Book> bookss = [];

  Future<dynamic> generateWishlistIds() async {
    print('asda');
    final response = await http
        .post(Uri.parse('http://10.0.2.2/login/findwishlist.php'), body: {
      "student_id": SignForm.datause[0]['id'],
    });
    var list = json.decode(response.body);
    List<Book> book =
        await list.map<Book>((json) => Book.fromJson(json)).toList();
    print(book[0].book_id);
    setState(() {
      bookss = book;
    });
    return book;
  }

  //datause[0]['id']
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WishList',
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: bookss.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200]!,
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: const Offset(3, 4))
                ],
              ),
              child: ListTile(
                onTap: () {
                  // print(books[index].book_id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(book: bookss[index], title: "Wishlist"),
                    ),
                  );
                },
                leading: Image.asset(
                    'assets/images/${bookss[index].book_genre.toLowerCase()}.png'),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${bookss[index].book_genre} ',
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${bookss[index].book_title} ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text('Book Status:'),
                        Text(
                          ' ${bookss[index].book_status} ',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.purpleAccent
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
