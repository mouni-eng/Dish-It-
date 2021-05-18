import 'package:final_project2/constants.dart';
import 'package:final_project2/view_models/control_view_model.dart';
import 'package:final_project2/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ControlViewModel>(
        builder: (context, nav, child) => BottomNavigationBar(
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    fit: BoxFit.fill,
                    color: Color(0xFFB6B6B6),
                  ),
                  label: '',
                  activeIcon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    fit: BoxFit.fill,
                    color: kPrimaryColor,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Heart Icon.svg",
                    fit: BoxFit.fill,
                    color: Color(0xFFB6B6B6),
                  ),
                  label: '',
                  activeIcon: SvgPicture.asset(
                    "assets/icons/Heart Icon.svg",
                    fit: BoxFit.fill,
                    color: kPrimaryColor,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Chat bubble Icon.svg",
                    fit: BoxFit.fill,
                    color: Color(0xFFB6B6B6),
                  ),
                  label: '',
                  activeIcon: SvgPicture.asset(
                    "assets/icons/Chat bubble Icon.svg",
                    fit: BoxFit.fill,
                    color: kPrimaryColor,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/User Icon.svg",
                    fit: BoxFit.fill,
                    color: Color(0xFFB6B6B6),
                  ),
                  label: '',
                  activeIcon: SvgPicture.asset(
                    "assets/icons/User Icon.svg",
                    fit: BoxFit.fill,
                    color: kPrimaryColor,
                  ),
                ),
              ],
              currentIndex: nav.navigatorValue,
              onTap: (index) {
                nav.changeSelectedValue(index);
              },
            ));
  }
}
