import 'package:final_project2/Models/cart_model.dart';
import 'package:final_project2/Screens/details_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.cart,
    @required this.index,
  }) : super(key: key);

  final CartModel cart;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              child: Image.network(cart.pic),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: getProportionateScreenWidth(50),
              child: Text(
                cart.name,
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${cart.quantity}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        ),
        Spacer(),
        ColorDots(
          product: cart,
          index: index,
        ),
      ],
    );
  }
}

class ColorDots extends StatelessWidget {
  const ColorDots({
    Key key,
    @required this.product,
    @required this.index,
  }) : super(key: key);

  final CartModel product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cart, child) => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          children: [
            RoundedIconBtn(
              icon: Icons.remove,
              showShadow: true,
              press: () {
                cart.decreaseQuantity(index);
              },
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            RoundedIconBtn(
              icon: Icons.add,
              showShadow: true,
              press: () {
                cart.increaseQuantity(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
