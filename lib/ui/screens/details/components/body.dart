import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_system/ui/screens/sign_in/components/sign_form.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Author.dart';
import '../../../../Book.dart';
import '../../../components/default_button.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final Book book;
  final String title;

  Body({Key? key, required this.book, required this.title}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future giveBook() async {
    print('${widget.book.book_id} asdasd');
    final response = await http
        .post(Uri.parse("http://10.0.2.2/login/changestatus.php"), body: {
      "book_id": widget.book.book_id as String,
      "book_status": widget.book.book_status,
    });
    //var dataBook = json.decode(response.body);
  }

  bool isDone = false;
  String formattedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  @override
  void initState() {
    generateAuthors();
  }

  late List<Author> authors = [];

  Future<dynamic> generateAuthors() async {
    print(widget.book.author_id);
    final response =
        await http.post(Uri.parse('http://10.0.2.2/login/authors.php'), body: {
      "author_id": widget.book.author_id.toString(),
    });
    var list = json.decode(response.body);
    List<Author> author =
        await list.map<Author>((json) => Author.fromJson(json)).toList();
    print(widget.book.author_id);
    setState(() {
      authors = author;
      isDone = true;
    });
    return author;
  }

  Future reserveBook() async {
    print(SignForm.datause[0]['id']);
    print(widget.book.book_id);
    print(formattedDate);
    final response = await http
        .post(Uri.parse("http://10.0.2.2/login/reservebook.php"), body: {
      "book_id": widget.book.book_id,
      "student_id": SignForm.datause[0]['id'],
      "date": formattedDate,
      "book_status": 'reserve',
    });
    //var dataBook = json.decode(response.body);
  }

  Future addWishlist() async {
    print(SignForm.datause[0]['id']);
    final response = await http
        .post(Uri.parse("http://10.0.2.2/login/addwishlist.php"), body: {
      "book_id": widget.book.book_id,
      "student_id": SignForm.datause[0]['id'],
    });
    //var dataBook = json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return isDone
        ? ListView(
            children: [
              Image.asset(
                "assets/images/${widget.book.book_genre.toString().toLowerCase()}.png",
                width: 250,
                height: 250,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenHeight(20)),
                child: Text(
                  widget.book.book_title,
                  style: TextStyle(
                      fontSize: 31,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Author: ${authors[0].author_name}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Genre: ${widget.book.book_genre}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Author ID: ${widget.book.author_id}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Publisher ID: ${widget.book.publisher_id}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "ISBN: ${widget.book.ISBN}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Status: ${widget.book.book_status}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Column(
                children: [
                  TopRoundedContainer(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.15,
                        right: SizeConfig.screenWidth * 0.15,
                      ),
                      child: widget.title == "Change Status"
                          ? Column(
                              children: [
                                DefaultButton(
                                  text: "Give book to Student",
                                  press: () {
                                    setState(() {
                                      widget.book.book_status = "given";
                                    });
                                    giveBook();
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: DefaultButton(
                                        text: "Student gave the Book",
                                        press: () {
                                          setState(() {
                                            widget.book.book_status = "exist";
                                          });
                                          giveBook();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                // FloatingActionButton(
                                //   onPressed: () {},
                                //   child: Icon(
                                //     Icons.add,
                                //   ),
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: DefaultButton(
                                        text: "WishList",
                                        press: () async {
                                          await addWishlist();
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                  'The book has been added to your Wishlist!!',
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: DefaultButton(
                                        text: "Reservation",
                                        press: () async {
                                          //      if (widget.book_status != 'reserve' && widget.book_status != 'given') {
                                          if (widget.book.book_status =='exist') {
                                           await reserveBook();
                                            setState(() {
                                              widget.book.book_status =
                                                  "reserve";
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                      'The book has been reserved!\n\nYou can take the book!!',
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  );
                                                },
                                              );
                                            });
//                          Navigator.pop(context);
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(
                                                    'The book has been reserved before!\n\nYou cannot reserve this book now!',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ],
          )
        : CircularProgressIndicator();
  }
}
