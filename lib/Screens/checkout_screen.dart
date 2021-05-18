import 'package:final_project2/Models/cart_model.dart';
import 'package:final_project2/Models/lastOrders_model.dart';
import 'package:final_project2/Models/user_model.dart';
import 'package:final_project2/Screens/order_success_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/order_view_model.dart';
import 'package:final_project2/view_models/profile_view_model.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  static String id = "CheckoutScreen";
  final List<CartModel> product;
  final double totalPrice;
  CheckoutScreen({this.product, this.totalPrice});
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<ProfileViewModel>(context).userModel;
    List<dynamic> prId =
        List.generate(product.length, (index) => product[index].id);
    List<dynamic> image =
        List.generate(product.length, (index) => product[index].pic);
    List<dynamic> title =
        List.generate(product.length, (index) => product[index].name);
    List<dynamic> price =
        List.generate(product.length, (index) => product[index].price);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Check Out",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${product.length} items",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(18),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(14),
            ),
            Column(
              children: [
                SectionTitle(title: "Your Chart", press: () {}),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(14),
            ),
            Row(
              children: List.generate(
                product.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenWidth(10),
                    horizontal: getProportionateScreenWidth(5),
                  ),
                  child: SizedBox(
                    width: 88,
                    child: AspectRatio(
                      aspectRatio: 0.88,
                      child: Container(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(10)),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.network(product[index].pic),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: "Your Address", press: () {}),
                SizedBox(
                  height: getProportionateScreenHeight(12),
                ),
                CustomText(
                  text: "${user.name} ${user.lastName}, ${user.phoneNumber}",
                  height: 1.5,
                ),
                CustomText(
                  text: "${user.address} (${user.name} Home)",
                  height: 1.5,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Text("Add voucher code"),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "\$${totalPrice.toString()}",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: CustomButton(
                      text: "Confirm Order!",
                      onpressed: () async {
                        await Provider.of<OrderViewModel>(context,
                                listen: false)
                            .addOrder(
                          prId,
                          totalPrice.toString(),
                          user.name,
                          user.lastName,
                          user.phoneNumber,
                          user.address,
                          price,
                          user.email,
                          image,
                          title,
                        );

                        await Provider.of<OrderViewModel>(context,
                                listen: false)
                            .addOrders(LastOrderModel(
                          prId: prId.toString(),
                          name: user.name,
                          lastName: user.lastName,
                          address: user.address,
                          phoneNumber: user.phoneNumber,
                          image: image[0],
                          totalPrice: totalPrice.toString(),
                        ));

                        Navigator.pushNamed(context, OrderSuccess.id);
                      },
                      size: getProportionateScreenWidth(18),
                      radius: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
