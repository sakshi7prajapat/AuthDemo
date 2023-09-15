import 'package:auth_demo/bloc/login_bloc.dart';
import 'package:auth_demo/screen/forgot_password.dart';
import 'package:auth_demo/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

class LoginSceen extends StatefulWidget {
  const LoginSceen({super.key});

  @override
  State<LoginSceen> createState() => _LoginSceenState();
}

class _LoginSceenState extends State<LoginSceen> {
  bool isLoading = false;
  LoginBloc _bloc = LoginBloc();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // String? email;
  // String? password;

  _Login() {
    _bloc.add(PerformLogin(
        email: emailController.text, password: passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade400,
        title: Text("Login Page"),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
            print("loading state");
            Center(child: CircularProgressIndicator());
          } else if (state is LoginSuccess) {
            isLoading = false;
            print("login");
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => LoginBloc(),
                      child: HomeScreen(),
                    )));
          } else if (state is LoginError) {
            isLoading = true;
            print(state.error);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: _bloc,
          builder: (context, state) {
            return Center(
              child: Form(
                key: _formKey,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _emailField(),
                        _passwordField(),
                        _row(),
                        SizedBox(
                          height: 20,
                        ),
                        _sumbitButton(),
                        SizedBox(
                          height: 30,
                        ),
                        _registerPage()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
        controller: emailController,
        decoration:
            InputDecoration(hintText: "Email", prefixIcon: Icon(Icons.email)),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Email is required.";
          }
        });
  }

  Widget _passwordField() {
    return TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
            hintText: "Password", prefixIcon: Icon(Icons.shield_moon_outlined)),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password is required.";
          }
        });
  }

  Widget _sumbitButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.grey.shade900,
            minimumSize: Size(500, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _Login();
          }
        },
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ));
  }

  Widget _row() {
    return Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPassword()),
              );
            },
            child: Text("Forgot Password?")));
  }

  Widget _registerPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?"),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ));
            },
            child: Text("Sing Up"))
      ],
    );
  }
}
