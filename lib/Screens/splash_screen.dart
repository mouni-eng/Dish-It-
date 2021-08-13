import 'package:final_project2/Screens/sign_in_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/size_config.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/view_models/splash_view_model.dart';
import 'package:final_project2/widgets/custom_button.dart';
import 'package:final_project2/widgets/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static String id = "SplashScreen";
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> splashData = [
      {
        "text": "Welcome to DISH IT, Let’s shop!",
        "image": "assets/images/splash_1.png"
      },
      {
        "text": "We help people conect with stor",
        "image": "assets/images/splash_2.png"
      },
      {
        "text": "We show the easy way to shop. \nJust stay at home with us",
        "image": "assets/images/splash_3.png"
      },
    ];
    SizeConfig().init(context);
    return Consumer<SplashViewModel>(
      builder: (context, splash, child) => Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      splash.changeScreen(index);
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashPage(
                      text: splashData[index]["text"],
                      image: splashData[index]["image"],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            splashData.length,
                            (index) => AnimatedContainer(
                              duration: kAnimationDuration,
                              margin: const EdgeInsets.only(right: 5),
                              height: 6,
                              width: splash.currentPage == index ? 20 : 6,
                              decoration: BoxDecoration(
                                  color: splash.currentPage == index
                                      ? kPrimaryColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 3,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: "Continue",
                            size: getProportionateScreenWidth(18),
                            radius: 20,
                            onpressed: () {
                              Navigator.pushNamed(context, SignInScreen.id);
                            },
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
