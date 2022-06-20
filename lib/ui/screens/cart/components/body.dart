import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../Book.dart';
import '../../../models/Cart.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  List<Book> books;
  String title;

  Body({Key? key, required this.books, required this.title}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Future deleteBook(String id) async {
      final response = await http
          .post(Uri.parse("http://10.0.2.2/login/deletebook.php"), body: {
        "book_id": id.toString(),
      });
      //var dataBook = json.decode(response.body);
    }

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: widget.books.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.books[index].book_id.toString()),
            direction: DismissDirection.endToStart,
            child: CartCard(cart: widget.books[index], title: widget.title),
            onDismissed: (_) async {
              await deleteBook(widget.books[index].book_id);
            },
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete the Book!"),
                      content: const Text("Are you sure you want to delete this Book?"),
                      actions: <Widget>[
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Delete")
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                      ],
                    );
                  },
                );
              }
          ),
        ),
      ),
    );
  }
}
