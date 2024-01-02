// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';


class DeleteRepo{
  Future <bool> deletePage(String id)
  async
  {
    final CollectionReference deletedata = FirebaseFirestore.instance.collection('taskCollection');
    
    try{
      await deletedata.doc(id).delete();
      print(id);
      print('deleted task');
      return true;

    }
    catch(e){
      print('cannot deleted the task');
      rethrow;   
      }
  }

}