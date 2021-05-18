import 'package:final_project2/Screens/details_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/product_view_model.dart';
import 'package:final_project2/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, product, child) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SectionTitle(title: "Popular Products", press: () {}),
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  product.productlist.length,
                  (index) {
                    if (product.productlist[index].isPopular)
                      return Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(20)),
                        child: SizedBox(
                          width: getProportionateScreenWidth(140),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                          product:
                                              product.productlist[index])));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.02,
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        getProportionateScreenWidth(20)),
                                    decoration: BoxDecoration(
                                      color: kSecondaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Hero(
                                      tag: product.productlist[index].id
                                          .toString(),
                                      child: Image.network(product
                                          .productlist[index].images[0]),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  product.productlist[index].title,
                                  style: TextStyle(color: Colors.black),
                                  maxLines: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${product.productlist[index].price}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(18),
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            getProportionateScreenWidth(8)),
                                        height: getProportionateScreenWidth(28),
                                        width: getProportionateScreenWidth(28),
                                        decoration: BoxDecoration(
                                          color:
                                              kSecondaryColor.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/icons/Heart Icon_2.svg",
                                          color: Color(0xFFDBDEE4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );

                    return SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
