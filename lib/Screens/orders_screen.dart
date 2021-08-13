import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project2/Models/order_model.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/services/last_order_service.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/widgets/bottom_nav_bar.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static String id = "OrderScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: "Last Orders",
          size: getProportionateScreenWidth(20),
        ),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: LastOrders().getLastOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          final orders = snapshot.data.docs;
          final List<LastOrderCards> orderslist = [];
          for (var order in orders) {
            final orderModel = OrderModel.fromjson(order.data());
            final orderCard = LastOrderCards(
              vendor: orderModel.vendor,
              logo: orderModel.logo,
              deleiveryTime: orderModel.deleiveryTime,
              status: orderModel.status,
              totalPrice: orderModel.totalPrice,
            );
            orderslist.add(orderCard);
          }
          return orderslist.length == 0
              ? Container(
                  child: Center(
                    child: CustomText(
                      text: "There is no Last orders",
                    ),
                  ),
                )
              : ListView(
                  children: orderslist,
                );
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class LastOrderCards extends StatelessWidget {
  final String vendor, status, deleiveryTime, logo, totalPrice;

  LastOrderCards(
      {this.deleiveryTime,
      this.logo,
      this.status,
      this.vendor,
      this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        width: double.infinity,
        height: getProportionateScreenHeight(150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: kSecondaryColor,
            width: getProportionateScreenWidth(2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: "Status : ",
                  color: Colors.black,
                  size: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: status == null ? "pending" : status,
                  color: kPrimaryColor,
                  size: getProportionateScreenWidth(20),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: getProportionateScreenWidth(80),
                  height: getProportionateScreenHeight(80),
                  child: Image.network(
                    logo,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "vendor : $vendor",
                      size: getProportionateScreenWidth(18),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    CustomText(
                      text: "Delievry Time : $deleiveryTime mins",
                      size: getProportionateScreenWidth(16),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    CustomText(
                      text: "Total Price : $totalPrice",
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}











/*Consumer<OrderViewModel>(
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
    ); */