import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/repo/taskRepo.dart';
import 'package:todoapp/repo/updateRepo.dart';

class Update extends StatefulWidget {
  final String id;

  const Update({Key? key, required this.id}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late CollectionReference _todoRef;

  @override
  void initState() {
    super.initState();
    _todoRef = _firestore.collection('taskCollection');

    // Call a method to fetch the document data
    _fetchDocumentData();
  }

  // Method to fetch document data
  Future<void> _fetchDocumentData() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _todoRef.doc(widget.id).get();

      // Update controllers with the data from the document
      taskController.text = documentSnapshot.get('task') ?? '';
      descriptionController.text = documentSnapshot.get('description') ?? '';
    } catch (e) {
      print('Error fetching document data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update tasks'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.task),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: Colors.blue,
                    labelText: 'Task name',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.all(8),
                    hintStyle: TextStyle(color: Colors.blue[800]),
                    labelText: 'Description',
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  UpdateRepo().updatetask(
                    widget.id,
                    taskController.text,
                    descriptionController.text,
                  );
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Text(
                  'Update!',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
