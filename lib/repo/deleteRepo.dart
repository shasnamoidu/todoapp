// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';


class DeleteRepo{
  Future <bool> deletePage(String taskid)
  async
  {
    final CollectionReference deletedata = FirebaseFirestore.instance.collection('taskCollection');
    void delete(taskid){
      deletedata.doc(taskid).delete();
    }
    try{
      await deletedata.doc(taskid).delete();
      print('deleted task');
      return true;

    }
    catch(e){
      print('cannot deleted the task');
      throw Exception();    }
  }

}