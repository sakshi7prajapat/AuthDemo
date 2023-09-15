import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
TextEditingController _forgotPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        centerTitle: true,
        title: Text("Forgot Password"),
      ),
      body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  TextFormField(
                    controller: _forgotPassword,
                    decoration: InputDecoration(
                      hintText: 'Your Email Address',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary:  Colors.grey.shade900,
                        minimumSize: Size(500, 50),
                        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
                      onPressed: 
                    (){
                              
                    }, child: Text("Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    )),
                  )
                ],
              ),
            ),
          ),


      ),
    );
  }
}