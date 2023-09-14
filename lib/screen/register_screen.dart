import 'package:auth_demo/bloc/login_bloc.dart';
import 'package:auth_demo/screen/home_screen.dart';
import 'package:auth_demo/screen/login_scren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  LoginBloc _bloc = LoginBloc();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cmrfPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
 

  _register() {

    if(passwordController.text != cmrfPasswordController.text){
    print("password do not match");
    }else{
      _bloc.add(RegisterEvent(
      email: emailController.text,
      password: passwordController.text,
    ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        title: Text("Register Page"),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        bloc: _bloc,
        listener: (context, state) {
         if(state is LoginLoading){
           Center(child: CircularProgressIndicator());
         }
         else if(state is LoginSuccess){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => LoginBloc(),
                      child: LoginSceen(),)));
          // Navigator.push(context,  MaterialPageRoute(builder:(context) => HomeScreen() ));
         }
         else if(state is LoginError){
          
          print(state.error);

         }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: _bloc,
          builder: (context, state) {
            return Container(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _emailField(),
                          _passwordField(),
                          _cmrfPassword(),
                          _sumbitButton(),
                         // _forgotPassword()
                        ],
                      ),
                    ),
                  ),
                );
          },
        ),
      )
    );
  }

  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              // border: OutlineInputBorder()
              hintText: 'email'

              ),
              validator: (value){
          if (value == null || value.isEmpty) {
            return "Email is required.";
          }
        }
              ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              // border: OutlineInputBorder()
              hintText: 'password'

              ),
              validator: (value){
          if (value == null || value.isEmpty) {
            return "Password is required.";
          }
        }
              ),
    );
  }

  Widget _cmrfPassword() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: cmrfPasswordController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'confirm Password'
              // border: OutlineInputBorder()

              ),
               validator: (value){
          if (value == null || value.isEmpty) {
            return "Confirm Password is required.";
          }
        }
              ),
    );
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
            _register();
          }
        },
        child: Text(
          "Register",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ));
  }
  
  Widget _forgotPassword() {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(onPressed: (){
    
      }, child: Text('Forgot Password')),
    );
  }
}
