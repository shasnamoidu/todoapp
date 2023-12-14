import 'package:flutter/material.dart';
import 'package:todoapp/Screens/homePage.dart';
import 'package:todoapp/Screens/login.dart';
import 'package:todoapp/repo/SignupRepo.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userController = TextEditingController();
  TextEditingController emainController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  final _formfield = GlobalKey<FormState>();
   bool passToggle = true;
   String username = '';
   String email = '';
   String password = '';
   String repeatpass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
         key: _formfield,
        child: SingleChildScrollView(
          child: Container(
            height: 800,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/wal.jpg'),
                    fit: BoxFit.cover)),
            child: Center(
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(29),
              boxShadow: [BoxShadow(
                                color: const Color.fromARGB(255, 207, 205, 205),
                                blurRadius: 10,
                                spreadRadius: 15)]
              ),
              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create account',
                      style: TextStyle(fontSize: 35, color: Colors.black),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: userController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Enter your name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emainController,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(29))),
                                validator: (value){
                                  if(value!.isEmpty || !value.contains('@gmail.com')){
                                    return "enter your valid email";
                                  }
                                   else{
                                    return null;
                                   }
                                },
                                onSaved: (value){
                                  setState(() {
                                    username = value!;
                                  });
                                },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: IntlPhoneField(
                        focusNode: FocusNode(),
                        controller: phoneController,
                        style: TextStyle(fontSize: 16),
                        
                        flagsButtonPadding: const EdgeInsets.all(8),
                        dropdownIconPosition: IconPosition.trailing,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.solid),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                      // child: TextFormField(
                
                      //   controller: phoneController,
                      //   keyboardType: TextInputType.number,
                      //   maxLength: 10,
                      //   decoration: InputDecoration(
                      //     hintText: "phone number",
                      //     prefixIcon: Icon(Icons.phone),
                
                      //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(29))),
                      // ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        key: ValueKey('password'),
                        obscureText: passToggle,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29)),
                              suffixIcon: InkWell(onTap: () {
                                        setState(() {
                                          passToggle = !passToggle;
                                        });
                                        
                                      },
                                      child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                                      ),

                        ),
                        validator: (value){
                                        if(value!.length < 6){
                                          return "please enter password of min length 6";
                                        }
                                        else{
                                          return null;
                                        }
                                        
                                      },
                                      onSaved: (value){
                                        setState(() {
                                          password = value!;
                                        });
                                      },
                                     
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: repeatController,
                        decoration: InputDecoration(
                          hintText: 'Repeat password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 67, 97, 196)),
                        onPressed: () async {
                          await SignRepo().userPage(
                            userController.text,
                            emainController.text,
                            phoneController.text,
                            passwordController.text,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 20),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
