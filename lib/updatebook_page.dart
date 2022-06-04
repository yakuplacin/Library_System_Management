import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateBookPage extends StatefulWidget {
  const UpdateBookPage({Key? key}) : super(key: key);

  @override
  State<UpdateBookPage> createState() => _UpdateBookPageState();
}

class _UpdateBookPageState extends State<UpdateBookPage> {
  Future updatedata() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2/login/updatebook.php"), body: {
      "book_id": book_id.text,
      "publisher_id": publisher_id.text,
      "author_id": author_id.text,
      "book_title": book_title.text,
      "book_status": book_status.text,
      "book_genre": book_genre.text,
      "ISBN": ISBN.text,
    });
    //var dataBook = json.decode(response.body);
  }

  TextEditingController book_id = TextEditingController();
  TextEditingController publisher_id = TextEditingController();
  TextEditingController author_id = TextEditingController();
  TextEditingController book_title = TextEditingController();
  TextEditingController book_status = TextEditingController();
  TextEditingController book_genre = TextEditingController();
  TextEditingController ISBN = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Book ID',
              ),
              controller: book_id,
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Publisher ID',
              ),
              controller: publisher_id,
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Author ID',
              ),
              controller: author_id,
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Book Title',
              ),
              controller: book_title,
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Book Status',
              ),
              controller: book_status,
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Book Genre',
              ),
              controller: book_genre,
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'ISBN',
              ),
              controller: ISBN,
            ),
            ElevatedButton(
              child: Text('Update Book'),
              onPressed: () {
                updatedata();
              },
            ),
          ],
        ),
      ),
    );
  }
}
