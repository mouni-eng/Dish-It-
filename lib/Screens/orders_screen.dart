import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/order_view_model.dart';
import 'package:final_project2/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(
      builder: (context, order, child) => Scaffold(
        body: order.orderList.length == 0
            ? Container()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "Your Orders",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "${order.orderList.length} items",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Column(
                          children: List.generate(
                              order.orderList.length,
                              (index) => Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    getProportionateScreenWidth(
                                                        10),
                                                horizontal:
                                                    getProportionateScreenWidth(
                                                        5),
                                              ),
                                              child: SizedBox(
                                                width: 88,
                                                child: AspectRatio(
                                                  aspectRatio: 0.88,
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                        getProportionateScreenWidth(
                                                            10)),
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFF5F6F9),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Image.network(order
                                                        .orderList[index]
                                                        .image),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(order
                                                    .orderList[index].prId),
                                                Text(
                                                    "${order.orderList[index].name} ${order.orderList[index].lastName}"),
                                                Text(order
                                                    .orderList[index].address),
                                                Text(order.orderList[index]
                                                    .phoneNumber),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
