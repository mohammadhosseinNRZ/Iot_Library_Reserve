import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:remotea_pplication/consts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:remotea_pplication/cubit/libraryscreen_cubit.dart';
import 'package:remotea_pplication/libraries_screen.dart';
import 'package:remotea_pplication/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: EasyLoading.init(),
        home: LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    try {
      // Perform the network request
      final response = await http.post(
        Uri.parse(Utils.loginApi),
        body: jsonEncode({"studentCode": data.name, "password": data.password}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(jsonDecode(response.body)['result']);
        Utils.userModel = User.fromJson(decodedToken);

        // Handle successful response
        // return null;
        return null;
      } else {
        // Handle server error and display appropriate message
        return response.body ?? 'An error occurred. Please try again later.';
      }
    } catch (e) {
      // Handle other errors, such as network issues
      // print('Error: $e');
      return 'An error occurred. Please try again later.';
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      // Perform the network request
      final response = await http.post(Uri.parse(Utils.registerApi),
          body:
              jsonEncode({"studentCode": data.name, "password": data.password}),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        // Handle successful response
        return null;
        // return "success";
      } else {
        // Handle server error and display appropriate message
        return response.body ?? 'An error occurred. Please try again later.';
      }
    } catch (e) {
      // Handle other errors, such as network issues
      // print('Error: $e');
      return 'An error occurred. Please try again later.';
    }
  }

  // Future<String> _recoverPassword(String name) {
  //   debugPrint('Name: $name');
  //   return Future.delayed(loginTime).then((_) {
  //     if (!users.containsKey(name)) {
  //       return 'User not exists';
  //     }
  //     return null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      userValidator: (value) {
        return null;
      },
      passwordValidator: (value) {
        return null;
      },
      userType: LoginUserType.name,
      // messages: LoginMessages(),
      hideForgotPasswordButton: true,
      onSignup: _signupUser,
      onLogin: _authUser,
      loginAfterSignUp: false,
      messages: LoginMessages(
          signUpSuccess:
              "You have successfully signed up. Now, please proceed to login."),
      // validateUserImmediately: true,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => LibraryscreenCubit(),
                  child: LibrariesScreen(),
                )));
      },
      onRecoverPassword: (p0) {},
    );
  }
}
