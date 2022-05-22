import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:w3/core/constants/colors_constants.dart';
import 'package:w3/ui/custom_widgets/custom_widgets.dart';
import 'package:w3/core/constants/text_style.dart';
import 'package:w3/ui/screens/login/login_view_model.dart';
import 'package:w3/ui/screens/root_screen.dart';
import 'package:w3/ui/screens/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final _formKey = GlobalKey<FormState>();
  bool? value = false;

  @override
  Widget build(BuildContext context) {
    //
    final validationService = Provider.of<LoginValidation>(context);
    //

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  //top big picture
                  ClipPath(
                    child: Image(
                      height: 220.0.h,
                      fit: BoxFit.cover,
                      image: const AssetImage(
                        'assets/images/green-plants-loginscreen.jpg',
                      ),
                    ),
                    clipper: LoginScreenClipper(),
                  ),

                  //top back arrow icon Button
                  CircularBackButton(
                    onTapFuction: () {},
                  ),

                  //small leaves picture
                  SmallLeavesPicture(
                    positionFromTop: 260.h,
                  ),

                  //Welcome text + login to your account text
                  Positioned.fill(
                    top: 260.h,
                    bottom: null,
                    child: Column(
                      children: [
                        Text(
                          'Welcome back',
                          style: kH1TextStyle,
                        ),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        Text(
                          'Login to your account',
                          style: kH2TextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //text fields, forgot password, LogIn Button, SignUp Detector
              Padding(
                padding: EdgeInsets.fromLTRB(20.0.w, 120.0.h, 20.0.w, 10.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //full name text field
                    CustomTextField(
                      //onchange function
                      function: (String value) {
                        validationService.changeEmail(value);
                      },
                      errorText: validationService.email.error,
                      prefixIconData: Icons.person,
                      hintText: 'Full Name',
                      obscureText: false,
                      textInputType: TextInputType.name,
                    ),

                    //
                    SizedBox(
                      height: 15.0.h,
                    ),

                    //Password text field
                    CustomTextField(
                      //onchange function
                      function: (String value) {
                        validationService.changePassword(value);
                      },
                      errorText: validationService.password.error,
                      prefixIconData: Icons.lock,
                      hintText: '******',
                      obscureText: true,
                      textInputType: TextInputType.visiblePassword,
                    ),

                    //checkbox & forgot Password detector
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            splashRadius: 5,
                            tristate: false,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: value,
                            onChanged: (newValue) {
                              setState(() {
                                value = newValue;
                              });
                            },
                            activeColor: kDarkGreen,
                            checkColor: Colors.white,
                            shape: const CircleBorder(),
                          ),
                        ),
                        Text(
                          'Remember me',
                          style: k4TextStyleLogInScreen,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: kDarkGreen,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    //
                    SizedBox(
                      // height: 80.0.h,
                      height: 70.h,
                    ),

                    // Login Button
                    CustomElevatedButton(
                      function: () {
                        if (!validationService.isValid) {
                          null;
                        } else {
                          validationService.submitData;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RootScreen()));
                        }
                      },
                      buttonText: 'Login',
                    ),

                    //
                    SizedBox(
                      height: 10.0.h,
                    ),

                    //row of last text and SignUp
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: kH2TextStyle,
                        ),

                        //Sign Up detector
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignUpScreen();
                            }));
                          },
                          child: Text(
                            'Sign Up',
                            style: kH3TextStyleSignUpTextInLogInScreen,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
