import 'package:flutter/material.dart';
import 'package:todoapp/Screens/homePage.dart';
import 'package:todoapp/Screens/signup.dart';
import 'package:todoapp/repo/loginRepo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  
  final _formfield = GlobalKey<FormState>();
  String username = '';
  String password = '';
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passToggle = true;
  

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView();
    bool rememberMe = false;
    void _onRememberMeChanged(bool newValue) => setState(() {
          rememberMe = newValue;
          if (rememberMe) {
          } else {}
        });

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formfield,
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage('asset/images/wal.jpg'),
                  //         fit: BoxFit.cover)),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black),
                      boxShadow: [
                        BoxShadow(
                              color: const Color.fromARGB(255, 207, 205, 205),
                              blurRadius: 10,
                              spreadRadius: 15)
                      ]),
                      // height: 500,
                      // width: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          // CircleAvatar(
                          //   backgroundImage: AssetImage(
                          //     'asset/images/todo_logo.png',
                          //   ),
                          //   maxRadius: 35,
                          // ),
                          // Column(
              
                          //   // children: [
                          //   //   Container(color: Colors.black,
                          //   //       child: Image(
                          //   //     image: AssetImage(
                          //   //       'asset/images/todo.png',
                          //   //     ),
                          //   //     height: 200,
                          //   //     width: 200,
                          //   //   )),
                          //   // ],
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Let's get started",
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                           
                           Container(
                            // color: Colors.white,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // border: InputBorder.none),
              
                            width: 300,
                            child: TextFormField(
                              
                              keyboardType: TextInputType.emailAddress,
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'please enter your username';
                              //   }
                              //   return null;
                              // },
                              controller: userController,
              
                              // strutStyle: StrutStyle(),
                              decoration: InputDecoration(
                                hintText: 'user name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(29)),
                                prefixIcon: Icon(Icons.person),
                                
                              ),
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
                          Container(
                            width: 300,
                            child: TextFormField(
                              key: ValueKey('password'),
                              controller: passwordController,
                              obscureText: passToggle,
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'please enter your password';
                              //   }
                              //   return null;
                              // },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: 'password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(29)),
                                      suffixIcon: InkWell(onTap: () {
                                        setState(() {
                                          passToggle = !passToggle;
                                        });
                                        
                                      },
                                      child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                                      )
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  rememberMe;
                                },
                              ),
                              Text('I agree to the terms and conditions')
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if(_formfield.currentState!.validate()){
                                    _formfield.currentState!.save();
                                    
                                    // print("success");
                                    // userController.clear();
                                    // passwordController.clear();
                                  }
                                  await LoginRepo().loginPage(
                                    userController.text,
                                    passwordController.text,
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ));
                                  
                                    
                                },
                                child: Text(
                                  'Log in',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 56, 97, 231))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'or sign in with',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'asset/images/facebook.png',
                                    ),
                                    maxRadius: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'asset/images/google.png',
                                    ),
                                    maxRadius: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'asset/images/mac.png',
                                    ),
                                    maxRadius: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUp(),
                                        ));
                                  },
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(fontSize: 18),
                                  )),
              
                              // TextButton(
                              //     onPressed: () {},
                              //     child: Text(
                              //       'forgot Password?',
                              //       style: TextStyle(color: Colors.black),
                              //     )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
  void checkLogin(){
   final usernamr = userController.text;
   final password = passwordController.text; 
    
   }
}
