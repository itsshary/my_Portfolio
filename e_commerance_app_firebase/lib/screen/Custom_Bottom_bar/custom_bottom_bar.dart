import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:project_app/screen/AccountScreen/accountscreen.dart';
import 'package:project_app/screen/HomeScreen.dart';
import 'package:project_app/screen/OrderScreen/order_screen_agin.dart';
import 'package:project_app/screen/cartscreen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({final Key? key}) : super(key: key);

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<CustomBottomBar> {
  PersistentTabController _controller = PersistentTabController();
  bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        const HomeScreen(),
        const CartScreen(),
        const OrderScreen(),
        const AccountScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            inactiveIcon: const Icon(Icons.home_outlined),
            title: "Home",
            activeColorPrimary: Colors.white,
            inactiveColorPrimary: Colors.white,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_cart),
          inactiveIcon: const Icon(Icons.shopping_cart_outlined),
          title: "Cart",
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.circle),
          inactiveIcon: const Icon(Icons.circle_outlined),
          title: "Order",
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          title: "Account",
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,

          backgroundColor: Colors.red,
          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.bounceIn,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle:
              NavBarStyle.style1, // Choose the nav bar style with this property
        ),
      );
}
