import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignRepo{
  
  Future <void> userPage(
    String username,
    String mail,
    String phone,
    String password,
    
    
  )
  async
  {
    final auth = FirebaseAuth.instance;
    final CollectionReference signupRefer = FirebaseFirestore.instance.collection('SignUpCollection');
    
    try{
      final SignupDetails = await auth.createUserWithEmailAndPassword(email: mail, password: password);
      await signupRefer.doc(SignupDetails.user!.uid).set({
        'userid':auth.currentUser!.uid,
        'username':username,
        'mail': mail,
        'phone': phone,
        'password':password,
        
      });
    }
    on FirebaseAuthException
    catch(e){
      print(e);
      throw Exception(
        "signup failed"
      );
    }
  }
}