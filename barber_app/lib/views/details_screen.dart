import 'package:barber_app_with_admin_panel/provider/app_provider.dart';
import 'package:barber_app_with_admin_panel/resorces/app_colors/app_colors.dart';
import 'package:barber_app_with_admin_panel/resorces/extension/extension.dart';
import 'package:barber_app_with_admin_panel/resorces/text_styles.dart/app_text_style.dart';
import 'package:barber_app_with_admin_panel/resorces/widgets/roundbutton.dart';
import 'package:barber_app_with_admin_panel/services/firebase/firebase_helper/firebase_firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../resorces/widgets/spin_kit.dart';

class DetailsScreen extends StatefulWidget {
  final String services;
  const DetailsScreen({super.key, required this.services});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  bool isloading=false;
  @override
  Widget build(BuildContext context) {
    final appprovider = Provider.of<AppProviderClass>(context);
    return Scaffold(
      backgroundColor: AppColors.secondGradientColor,
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        progressIndicator: const SpinKitFlutter(),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(
                color: AppColors.whiteColor,
              ),
              10.sH,
              RichText(
                text: TextSpan(
                  text: 'Let\'s the',
                  style: AppTextStyle.services.copyWith(fontSize: 25.0),
                  children: <TextSpan>[
                    TextSpan(
                        text: '\nJourney Begin',
                        style: AppTextStyle.defaulttextsize.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                        )),
                  ],
                ),
              ),
              15.sH,
              Container(
                height: 200.0,
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    "assets/images/discount.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              10.sH,
              Text(
                widget.services.toString(),
                style: AppTextStyle.services.copyWith(fontSize: 30.0),
              ),
              10.sH,
              GestureDetector(
                onTap: () => appprovider.selectedDateFunction(context),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.amber.shade700,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text("Set a Date",
                            style: AppTextStyle.services
                                .copyWith(color: Colors.black)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 40.0,
                              color: Colors.white,
                            ),
                            Text(
                                "${appprovider.selectedDate.day}/${appprovider.selectedDate.month}/${appprovider.selectedDate.year}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36.0,
                                    color: Colors.white)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              20.0.sH,
              GestureDetector(
                onTap: () => appprovider.selectedTimeFunction(context),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.amber.shade700,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text("Set a Time",
                            style: AppTextStyle.services
                                .copyWith(color: Colors.black)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.alarm,
                              size: 40.0,
                              color: Colors.white,
                            ),
                            Text(
                                appprovider.selectedTime
                                    .format(context)
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36.0,
                                    color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              50.sH,
              Button(
                  bgcolor: Colors.amber.shade50,
                  title: "Book Now",
                  ontap: () async{
                    setState(() {
                      isloading=true;
                    });
                       await FirebaseFirestoreHelper.instace.saveBooking(
                           appprovider.selectedDate,
                           appprovider.selectedTime,
                           widget.services,
                           context);

                    setState(() {
                      isloading=false;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
