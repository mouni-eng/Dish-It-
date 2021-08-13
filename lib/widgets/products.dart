import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project2/Models/product_model.dart';
import 'package:final_project2/Models/vendor_model.dart';
import 'package:final_project2/Screens/allproducts_screen.dart';
import 'package:final_project2/Screens/details_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/services/home_service.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/favourite_view_model.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  final VendorModel vendorModel;
  PopularProducts({this.vendorModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
            title: "Popular Products",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllProductsScreen(
                            vendor: vendorModel,
                          )));
            }),
        SizedBox(height: getProportionateScreenWidth(40)),
        Container(
          height: 300,
          child: StreamBuilder<QuerySnapshot>(
              stream: HomeService().getPopularProduct(vendorModel.name),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                      child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ));
                final products = snapshot.data.docs;
                List<Product> productsList = [];
                for (var product in products) {
                  final productModel = Product.fromJason(product.data());
                  productModel.isFavourite = false;
                  productsList.add(productModel);
                }
                return productsList.length == 0
                    ? Container(
                        child: Center(
                          child: CustomText(
                            text:
                                "There is no popular products for ${vendorModel.name}",
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productsList.length,
                        itemBuilder: (context, index) => ProductsCard(
                          productmodel: productsList[index],
                          vendorModel: vendorModel,
                          index: index,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                          product: Product(
                                              id: productsList[index].id,
                                              description: productsList[index]
                                                  .description,
                                              title: productsList[index].title,
                                              vendor: vendorModel.name,
                                              deleivery: vendorModel.delivery,
                                              deleiveryTime:
                                                  vendorModel.deliveryTime,
                                              logo: vendorModel.logo,
                                              rating:
                                                  productsList[index].rating,
                                              price: productsList[index].price,
                                              images:
                                                  productsList[index].images),
                                        )));
                          },
                        ),
                      );
              }),
        ),
      ],
    );
  }
}

class ProductsCard extends StatelessWidget {
  final Product productmodel;
  final int index;
  final VendorModel vendorModel;
  final Function onPressed;

  ProductsCard(
      {this.productmodel, this.vendorModel, this.index, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
        child: SizedBox(
          width: getProportionateScreenWidth(140),
          child: GestureDetector(
            onTap: onPressed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Hero(
                      tag: productmodel.id.toString(),
                      child: Image.network(productmodel.images[0]),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  productmodel.title,
                  style: TextStyle(color: Colors.black),
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${productmodel.price}",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () async {
                        await Provider.of<FavouriteViewModel>(context,
                                listen: false)
                            .addProducts(productmodel, vendorModel, context);
                      },
                      onLongPress: () async {
                        await Provider.of<FavouriteViewModel>(context,
                                listen: false)
                            .dismissible(productmodel, index);
                        Fluttertoast.showToast(
                            msg: "Product removed from Favourites",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kPrimaryColor,
                            textColor: Colors.white,
                            fontSize: getProportionateScreenWidth(16));
                      },
                      child: Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                        height: getProportionateScreenWidth(28),
                        width: getProportionateScreenWidth(28),
                        decoration: BoxDecoration(
                          color: kSecondaryColor.withOpacity(0.1),
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
      ),
    );
  }
}

/* Padding(
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
                                      child: Image.network(
                                          product.productlist[index].images[0]),
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

                    return Container(
                      child: Center(
                        child: CustomText(
                          text:
                              "there is no popular products to this Resturant",
                          size: getProportionateScreenWidth(20),
                        ),
                      ),
                    );*/