import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';


class TaskRepo {
final CollectionReference taskReference = FirebaseFirestore.instance.collection('taskCollection');

    
  Future <void> taskPage(
    String taskname,
    String description,
  )  {
    final currentDate = DateTime.now();
    final dateStr = '${currentDate.day} - ${currentDate.month} - ${currentDate.year}';
    const taskid = Uuid();
    final todoid = taskid.v4();
    
    
      return  taskReference.add({
          'taskid': todoid,
          // 'userid': auth.currentUser!.uid,
          'task': taskname,
          'description': description,
          'date': dateStr,

        }
        ).then((value) => print('value added')).catchError((Error) => print('failed to add'));
        
    
    
  }
}
