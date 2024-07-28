import 'package:barber_app_with_admin_panel/resorces/app_colors/app_colors.dart';
import 'package:barber_app_with_admin_panel/resorces/extension/extension.dart';
import 'package:barber_app_with_admin_panel/resorces/text_styles.dart/app_text_style.dart';
import 'package:barber_app_with_admin_panel/resorces/widgets/drawer_widget.dart';
import 'package:barber_app_with_admin_panel/utils/routes/routes_name.dart';
import 'package:barber_app_with_admin_panel/view_model/auth_view_model.dart';
import 'package:barber_app_with_admin_panel/view_model/firestore_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

List<String> images = [
  'assets/images/beard.png',
  'assets/images/cutting.png',
  'assets/images/facials.png',
  'assets/images/hair.png',
  'assets/images/kids.png',
  'assets/images/shaving.png'
];

List<String> servics = [
  'Beared Cutting',
  'Men Cutting',
  'Facials',
  'Hair Washing',
  'Kids Cutting',
  'Classic Shaving',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    FirestoreViewModel firestoreViewModel =
        Provider.of<FirestoreViewModel>(context);

    return Scaffold(
      endDrawer: FutureBuilder(
        future: firestoreViewModel.getuserInformation(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Drawer(
              child: SpinKitDancingSquare(
                color: AppColors.secondGradientColor,
              ),
            );
          }
          if (snapshot.hasError) {
            return const Drawer(
              child: Text('Error fetching user data'),
            );
          }

          return DrawerWidget(
            name: snapshot.data!.name.toString(),
            email: snapshot.data!.email.toString(),
            imageurl: snapshot.data!.image.toString(),
          );
        },
      ),
      backgroundColor: AppColors.secondGradientColor,
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: firestoreViewModel.getuserInformation(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SpinKitDualRing(color: AppColors.whiteColor);
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello!", style: AppTextStyle.defaulttextsize),
                        Text(snapshot.data!.name.toString(),
                            style: AppTextStyle.namesize)
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 35.0,
                        ))
                  ],
                );
              },
            ),
            10.sH,
            Divider(
              color: Colors.white.withOpacity(0.4),
            ),
            10.sH,
            Text("Services", style: AppTextStyle.namesize),
            Expanded(
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routesname.detailscreen,
                          arguments: servics[index]);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.amber.shade800,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              images[index],
                              height: 100.0,
                              width: 100.0,
                            ),
                            Text(
                              servics[index],
                              style: AppTextStyle.services,
                            )
                          ],
                        )),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
