import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:todoapp_brainmentors/modules/dashboard/views/dashboard.dart';
import 'package:todoapp_brainmentors/modules/user/cubit/user_cubit.dart';
import 'package:todoapp_brainmentors/modules/user/cubit/user_state.dart';

import '../../../i18n/locale_keys.g.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  _login(context) {
    BlocProvider.of<UserCubit>(context).login();
  }

  _moveToNextScreen(ctx) {
    Timer(Duration(seconds: 3), () {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => DashBoard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserCubit, UserState>(builder: (_, userState) {
              print("Inside Builder ");
              print(userState.image.length);
              if (userState.email.length > 0) {
                _moveToNextScreen(context);
              }

              return Column(
                children: [
                  Text(
                    'Login SuccessFully ... ',
                    style: GoogleFonts.roboto(fontSize: 30),
                  ),
                  Image.network(userState.image.length == 0
                      ? 'https://cdn1.iconfinder.com/data/icons/user-pictures/100/male3-512.png'
                      : userState.image),
                  Text(
                    userState.name + " " + userState.email,
                    style: GoogleFonts.pacifico(fontSize: 20),
                  ),
                ],
              );
            }),
            SignInButton(
              Buttons.googleDark,
              onPressed: () {
                _login(context);
              },
              text: LocaleKeys.logingooglebutton.tr(),
            ),
            SignInButton(
              Buttons.facebook,
              onPressed: () {},
              text: LocaleKeys.loginfacebookbutton.tr(),
            )
          ],
        ),
      ),
    );
  }
}
