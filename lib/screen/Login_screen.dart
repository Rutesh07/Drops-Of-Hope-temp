import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/screen/Signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter1/screen/HomePage.dart';
// import 'package:flutter1/screen/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

   //form key
  final _formkey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController Emailcontroller = new TextEditingController();
  final TextEditingController Passwordcontroller = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  //string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {

    //email field
    final Emailfield = TextFormField(
      autofocus: false,
      controller: Emailcontroller,
      keyboardType: TextInputType.emailAddress,

      validator: (value){
        if(value!.isEmpty)
        {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        
      },
      onSaved: (value)
      {
        Emailcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
      prefixIcon: Icon(Icons.mail),
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: "Email",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      )
    )
    );

    //Password field
    final Passwordfield = TextFormField(
      autofocus: false,
      controller: Passwordcontroller,
      obscureText: true,

      validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
      },
      onSaved: (value)
      {
        Passwordcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
      prefixIcon: Icon(Icons.vpn_key),
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: "Password",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      )
    )
    );

    final LoginButton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.redAccent,
    child: MaterialButton(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () {
        signIn(Emailcontroller.text, Passwordcontroller.text);
      },
      child: Text(
        "Login",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
        ),
      ),
    ),
  );

  
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
            key: _formkey, 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 180,
                  child: Image.asset("assets/images/LOGO.jpg", fit: BoxFit.contain,)
                ),
                
                SizedBox(height: 45),
                Emailfield,
                SizedBox(height: 25),
                Passwordfield,
                SizedBox(height: 35),
                LoginButton,
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an Account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                      },
                      child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15,color: Colors.redAccent),
                      ),
                    )
                  ],
                )
              ]
            ),
          ),
        ),
      ),
    ),
    ),
  );
  }
}

// login function
  void signIn(String email, String password) async {
    var _formKey;
    if (_formKey.currentState!.validate()) {
      try{
    
          var _auth;
          await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
              Fluttertoast.showToast(msg: "Login Successful"),
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home())),
             
           });
    }
    on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            var errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            var errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            var errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            var errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            var errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            var errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            var errorMessage = "An undefined Error happened.";
        }
        
        var errorMessage;
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
   
  
