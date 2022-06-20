import 'package:flutter/material.dart';
import 'package:library_system/ui/screens/sign_in/components/sign_form.dart';

import '../../../../wishlist.dart';
import '../../../size_config.dart';
import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("HomeBook📚", style: TextStyle(fontSize: 32)),
          Row(
            children: [
              IconBtnWithCounter(
                svgSrc: "assets/icons/Gift Icon.svg",
                //numOfitem: 3,
                press: () {
                  print('asdasdasd');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Wishlist(SignForm.datause),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
