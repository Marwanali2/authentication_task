import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/buttons.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../Login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();

  String? userName;

  String? userEmail;

  String? userPassword;

  String usersCollectionReference = 'users';

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');


  @override
  Widget build(BuildContext context) {
    bool emptyArea = false;

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
///////////////////////////////////////////////////////////////////////////////////
          Padding(
            padding: const EdgeInsets.only(top: 50).r,
            child: SizedBox(
              width: 260.w,
              child: Column(
                children: [
                  Text(
                    "Register Now!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: mainFontSize.sp,
                      fontWeight: mainFontWeight,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Create an Account,Its free",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: commonTextSize.sp,
                      color: lightGreyReceiptBG,
                    ),
                  ),
                ],
              ),
            ),
          ),
///////////////////////////////////////////////////////////////////////////////////

          SizedBox(width: double.infinity.w, height: 40.h),
          Form(
            key: _formKey,
            child: Column(
              children: [
                ///////////////////////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(right: 20.0).r,
                  child: SizedBox(
                    width: 220.w,
                    height: 90.h,
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            displaySnackBar("enter your email");
                            emptyArea = true;
                            return "empty";
                          }
                          return null;
                        },
                        cursorColor: textBlack,
                        style: TextStyle(fontSize: subFontSize.sp),
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: textBlack),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: textBlack),
                          ),
                          icon: const Icon(
                            Icons.person,
                            color: textBlack,
                          ),
                          labelText: "User Name",
                          hintText: "Ahmed Mohamed",
                          labelStyle: TextStyle(
                              color: textBlack,
                              fontSize: mainFontSize.sp,
                              fontWeight: mainFontWeight),
                          hintStyle: TextStyle(
                              color: textBlack, fontSize: subFontSize.sp),
                        ),
                        onChanged: (enteredUserName) {
                          // TODO: add your code to add User Name in firestore
                          userName = enteredUserName;
                          usersCollection.add({'userName': userName});
                        }),
                  ),
                ),
///////////////////////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(right: 20.0).r,
                  child: SizedBox(
                    width: 220.w,
                    height: 90.h,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          displaySnackBar("enter your email");
                          emptyArea = true;
                          return "empty";
                        }
                        return null;
                      },
                      cursorColor: textBlack,
                      style: TextStyle(fontSize: subFontSize.sp),
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        icon: const Icon(
                          Icons.email_outlined,
                          color: textBlack,
                        ),
                        labelText: "Email",
                        hintText: "abc@gmail.com",
                        labelStyle: TextStyle(
                            color: textBlack,
                            fontSize: mainFontSize.sp,
                            fontWeight: mainFontWeight),
                        hintStyle: TextStyle(
                            color: textBlack, fontSize: subFontSize.sp),
                      ),
                      onChanged: (enteredEmail) {
                        userEmail = enteredEmail;
                        usersCollection.add({'userEmail': userEmail});
                      },
                    ),
                  ),
                ),
///////////////////////////////////////////////////////////////////////////////////

                Padding(
                  padding: const EdgeInsets.only(right: 20.0).r,
                  child: SizedBox(
                    width: 220.w,
                    height: 90.h,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          displaySnackBar("enter your email");
                          emptyArea = true;
                          return "empty";
                        }
                        return null;
                      },
                      cursorColor: textBlack,
                      style: TextStyle(fontSize: subFontSize.sp),
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textBlack),
                        ),
                        icon: const Icon(
                          Icons.password_outlined,
                          color: textBlack,
                        ),
                        labelText: "Password",
                        hintText: "******",
                        labelStyle: TextStyle(
                            color: textBlack,
                            fontSize: mainFontSize.sp,
                            fontWeight: mainFontWeight),
                        hintStyle: TextStyle(
                            color: textBlack, fontSize: subFontSize.sp),
                      ),
                      onChanged: (enteredPassword) {
                        userPassword = enteredPassword;
                        usersCollection.add({'userPassword': userPassword});
                      },
                    ),
                  ),
                ),
///////////////////////////////////////////////////////////////////////////////////
                SizedBox(height: 30.h, width: double.infinity.w),
                DefaultButton(
                    text: "Register",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        emptyArea = false;
                      }
                      if (!emptyArea) {
                        await displaySnackBar("loading");
                        // TODO: add your code to register by email & password and store the user data in firestore

                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: userEmail!,
                          password: userPassword!,
                        );

                        // Navigate to login page
                        Navigator.pushNamed(context, Login.routeName);

                        usersCollection.doc('users').set({
                          'userName': userName,
                          'userEmail': userEmail,
                          'userPassword': userPassword,
                        });
                      }
                    }),
///////////////////////////////////////////////////////////////////////////////////
                SizedBox(height: 20.h, width: double.infinity.w),
                Text(
                  "Already have an account ?",
                  style: (TextStyle(
                      color: textBlack, fontSize: commonTextSize.sp)),
                ),
///////////////////////////////////////////////////////////////////////////////////
                InkWell(
                  child: Text(
                    'Log in',
                    style: TextStyle(
                        color: textBlack,
                        fontSize: commonTextSize.sp,
                        fontWeight: commonTextWeight),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Login.routeName);
                  },
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
