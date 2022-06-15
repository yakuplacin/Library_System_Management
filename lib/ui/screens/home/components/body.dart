import 'dart:math';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Book.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void initState() {
    // print('Init is started here');
    // setState(() {});
    generateBookList();
  }

  String formattedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  late List<Book> books = [];

  Future<dynamic> generateBookList() async {
    print('asa');
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner(
              books: books,
            ),
            Categories(
              books: books,
            ),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(books: books),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
