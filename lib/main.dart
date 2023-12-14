import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/login.dart';
import 'package:todoapp/Screens/signup.dart';

void main()async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyBn__9PGdecEMbjynPhLW0CSkzgHCbuSug", 
    appId: "1:837921498726:android:a7be4d95b30f0b6373afa7", 
    messagingSenderId: "837921498726",
    projectId: "new-todo-app-46ec6");
     await Firebase.initializeApp(options: firebaseOptions);
  }
 

  catch(e){
         print('firebase initialization cannot be done');
  }
  
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // color: Colors.red,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 22, 17, 31)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

