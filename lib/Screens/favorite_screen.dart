import 'package:final_project2/Models/product_model.dart';
import 'package:final_project2/Screens/details_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/favourite_view_model.dart';
import 'package:final_project2/widgets/bottom_nav_bar.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:final_project2/widgets/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteViewModel>(
      builder: (context, fav, child) => Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              CustomText(
                text: "Your Favourites",
              ),
              SizedBox(
                height: getProportionateScreenHeight(7),
              ),
              CustomText(
                text: "(${fav.favProductList.length.toString()})",
              ),
            ],
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: fav.favProductList.length == 0
            ? Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CustomText(
                        text: "There is no Avalible Favourites right now",
                      ),
                    )
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  children: List.generate(
                      fav.favProductList.length,
                      (index) => ProductsCard(
                            productmodel: fav.favProductList[index],
                            index: index,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                            product: Product(
                                                id: fav
                                                    .favProductList[index].id,
                                                description: fav
                                                    .favProductList[index]
                                                    .description,
                                                title: fav.favProductList[index]
                                                    .title,
                                                vendor: fav
                                                    .favProductList[index]
                                                    .vendor,
                                                deleivery: fav
                                                    .favProductList[index]
                                                    .deleivery,
                                                deleiveryTime: fav
                                                    .favProductList[index]
                                                    .deleiveryTime,
                                                logo: fav
                                                    .favProductList[index].logo,
                                                rating: fav
                                                    .favProductList[index]
                                                    .rating,
                                                price: fav.favProductList[index]
                                                    .price,
                                                images: fav
                                                    .favProductList[index]
                                                    .images),
                                          )));
                            },
                          )),
                ),
              ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
