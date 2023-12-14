import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('taskCollection');
      void delete(taskid){
      taskCollection.doc(taskid).delete();
    }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('tasks'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Task(),
              ));
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: StreamBuilder(
        stream: taskCollection.orderBy('task').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot taskSnap = snapshot.data!.docs[index];
                
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 80,
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
                                onPressed: (

                                ) {
                                  
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Update(),
                                      ));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                color: Colors.blue,
                                onPressed: () async {
                                  DeleteRepo().deletePage(taskSnap['taskid']);
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
