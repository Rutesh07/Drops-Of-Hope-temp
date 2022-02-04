import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/screen/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter1/screen/HomePage.dart';

// import 'package:flutter1/screen/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({ Key? key }) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _auth = FirebaseAuth.instance;
  
  // string for displaying the error Message
  String? errorMessage;

  //our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final FirstNameEditingController = new TextEditingController();
  final LastNameEditingController = new TextEditingController();
  final EmailEditingController = new TextEditingController();
  final PasswordEditingController = new TextEditingController();
  final ConfirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

  //first name field
  final FirstNameField = TextFormField(
    autofocus: false,
    controller: FirstNameEditingController,
    keyboardType: TextInputType.name,

    validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
      },
    onSaved: (Value) {
      var value;
      FirstNameEditingController.text = value!;
    },
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.account_circle),
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: "First Name",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      )
    )
  );

   //Last name field
  final LastNameField = TextFormField(
    autofocus: false,
    controller: LastNameEditingController,
    keyboardType: TextInputType.name,

     validator: (value) {
          if (value!.isEmpty) {
            return ("Last name cannot be Empty");
          }
          return null;
      },
    onSaved: (Value) {
      var value;
      LastNameEditingController.text = value!;
    },
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.account_circle),
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: "Last Name",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      )
    )
  );

   //Email field
  final EmailField = TextFormField(
    autofocus: false,
    controller: EmailEditingController,
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
    onSaved: (Value) {
      var value;
      EmailEditingController.text = value!;
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
  final PasswordField = TextFormField(
    autofocus: false,
    controller: PasswordEditingController,
    obscureText: true,

     validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is reqiured for Login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 6 Character)");
          }
          // return null;
      },
    onSaved: (Value) {
      var value;
      PasswordEditingController.text = value!;
    },
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.vpn_key),
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: "Password",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      )
    )
  );

   //Confirm Password field
  final ConfirmPasswordField = TextFormField(
    autofocus: false,
    controller: ConfirmPasswordEditingController,
    obscureText: true,

    validator: (value)
    {
      if(ConfirmPasswordEditingController.text != PasswordEditingController.text){
        return "Password Don't match";
      }
      return null;
    }, 
    onSaved: (Value) {
      var value;
      ConfirmPasswordEditingController.text = value!;
    },
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.vpn_key),
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: "Confirm Password",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      )
    )
  );

  // Sign up button
  final SignupButton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.redAccent,
    child: MaterialButton(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () {
        signUp(EmailEditingController.text, PasswordEditingController.text);
      },
      child: Text(
        "Sign Up",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
        ),
      ),
    ),
  );


  
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.red),
        onPressed: () {
          //passing this to our roo
          Navigator.of(context).pop();
        },
    ),
    ),
    body: Center(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
                key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 180,
                  child: Image.asset("assets/images/LOGO.jpg", fit: BoxFit.contain,)
                ),
                SizedBox(height: 35),
                FirstNameField,
                SizedBox(height: 20),
                LastNameField,
                SizedBox(height: 20),
                EmailField,
                SizedBox(height: 20),
                PasswordField,
                SizedBox(height: 20),
                ConfirmPasswordField,
                SizedBox(height: 15),
                SignupButton,
                SizedBox(height: 15),
              ]
              ,
            ),
          ),
        ),
      ),
    ),
   )
  );
  }

  
    void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
       try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()
            })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.Email = user!.email;
    userModel.Uid = user.uid;
    userModel.FirstName = FirstNameEditingController.text;
    userModel.LastName = LastNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Home()),
        (route) => false);
  }
}