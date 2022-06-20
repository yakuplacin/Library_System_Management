import 'package:flutter/material.dart';
import 'package:library_system/ui/screens/details/details_screen.dart';

import '../../../../Book.dart';
import '../../../constants.dart';
import '../../../models/Cart.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cart,
    required this.title,
  }) : super(key: key);

  final Book cart;
  final String title;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {

  initState(){
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('asdasdasd');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(book: widget.cart, title: widget.title),
          ),
        );
        //////
      },
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset("assets/images/" +
                    widget.cart.book_genre.toString().toLowerCase() +
                    ".png"),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cart.book_title.length > 25
                    ? '${widget.cart.book_title.substring(0, 24)}  ...'
                    : widget.cart.book_title,
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "${widget.cart.book_genre}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: " ${widget.cart.book_status}",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
