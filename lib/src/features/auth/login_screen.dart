import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/const/static_class.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_textform_filed.dart';
import 'package:whole_selle_x_application/src/common/widgets/validations.dart';
import 'package:whole_selle_x_application/src/features/auth/model/usermodel.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void login() async {
    if (_formKey.currentState!.validate()) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("customers")
          .where("email", isEqualTo: emailController.text.trim())
          .where('password', isEqualTo: passwordController.text.trim())
          .get();

      if (snapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "User Not Found! 🤨",
            style: txtTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).primary),
          ),
        ));
      } else {
        Usermodel model =
            Usermodel.fromMap(snapshot.docs[0].data() as Map<String, dynamic>);
        StaticData.model = model;

        Future.delayed(Duration(seconds: 1), () {
          context.pushNamed(AppRoute.bottom);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Login successful! 🎉",
              style: txtTheme(context).headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).primary),
            ),
          ));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 242, 242),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text("Login",
                    style: txtTheme(context).displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface)),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email",
                            style: txtTheme(context)
                                .headlineMedium
                                ?.copyWith(color: Colors.black)),
                        SizedBox(height: 5),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomTextFormField(
                            hint: "Enter Your Email",
                            controller: emailController,
                            validator: FormValidators.validateEmail,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                /// **Password Field**
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Password",
                            style: txtTheme(context)
                                .headlineMedium
                                ?.copyWith(color: Colors.black)),
                        SizedBox(height: 5),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CustomTextFormField(
                            hint: "Enter Your Password",
                            obscureText: true,
                            controller: passwordController,
                            validator: FormValidators.validatePassword,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoute.forgot);
                      },
                      child: Text(
                        "Forgot your password?",
                        style: txtTheme(context).bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme(context).surface),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      color: colorScheme(context).primary,
                      size: 18,
                    )
                  ],
                ),
                SizedBox(height: 10),
                CustomGradientButton(onPressed: login, buttonText: "LOGIN"),

                SizedBox(height: 90),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Or sign up with social account",
                    style: txtTheme(context).headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                            color: colorScheme(context).onPrimary,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(AppImages.google))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                            color: colorScheme(context).onPrimary,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(AppImages.facebook))),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
