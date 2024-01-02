import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/login.dart';
import 'package:todoapp/Screens/profile.dart';
import 'package:todoapp/Screens/task.dart';
import 'package:todoapp/Screens/update.dart';
import 'package:todoapp/repo/deleteRepo.dart';
import 'package:todoapp/repo/taskRepo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('taskCollection');
  void delete(taskid) {
    taskCollection.doc(taskid).delete();
  }

  late Size mediaSize;

  final FirebaseAuth auth = FirebaseAuth.instance;
  
  logOut()async{
    await auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginPage() ,));
  }

  @override
  Widget build(BuildContext context) {
    Widget MyDrawerList() {
      return Container();
    }

    

    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('tasks'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            
            ProfilePage(),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                  logOut();
                }, child: Text('LogOut')),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => Container(
                  width: 500,
                  color: const Color.fromARGB(255, 164, 199, 228),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add task",
                                style: TextStyle(fontSize: 20),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Icon(Icons.close),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 1.2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: taskController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(color: Colors.blue)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Enter task',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: descriptionController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'description',
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              TaskRepo().taskPage(taskController.text,
                                  descriptionController.text);
                            },
                            style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(500, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            child: Text(
                              'Add task!',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
      ),
      body: StreamBuilder(
        stream: taskCollection.orderBy('task').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // final List<DocumentSnapshot>documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot taskSnap = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 207, 205, 205),
                              blurRadius: 10,
                              spreadRadius: 15)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 25,
                              child: Icon(Icons.person),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              taskSnap['task'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              taskSnap['description'],
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              taskSnap['date'],
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Update(id: taskSnap.id),
                                      ));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                color: Colors.blue,
                                onPressed: () async {
                                  DeleteRepo().deletePage(taskSnap.id);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
