import 'package:final_project2/Screens/specific_category_screen.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Consumer<CategoryViewModel>(
        builder: (context, category, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            category.categoryList.length,
            (index) => CategoryCard(
              icon: category.categoryList[index].icon,
              text: category.categoryList[index].text,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SpecificCategory(
                              categorie: category.categoryList[index].text,
                            )));
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(60),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(icon),
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
