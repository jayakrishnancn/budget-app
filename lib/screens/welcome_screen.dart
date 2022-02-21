import 'package:budget/constants/app_info.dart';
import 'package:budget/constants/app_colors.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                AppInfo.name,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryTextColor),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppInfo.desciption,
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 14, color: AppColor.primaryTextColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
