import 'package:flutter/material.dart';
import 'package:todoapp/repo/taskRepo.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a Tasks',),backgroundColor: Colors.blue,),
      body: Center(
        child: SingleChildScrollView(
          child: Container(color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset('asset/images/home_wal.webp',fit: BoxFit.cover,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.task),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(29)),
                        
                        fillColor: Colors.blue,
                        labelText: 'Task name'),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(
                          
                            borderRadius: BorderRadius.circular(29)),
                            contentPadding: EdgeInsets.all(8),
                        hintStyle: TextStyle(color: Colors.blue[800]),
                        labelText: 'description'),
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                  TaskRepo().taskPage(taskController.text, 
                  descriptionController.text);
                },
                style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(200, 50)),backgroundColor: MaterialStateProperty.all(Colors.blue)),
                
                 child: Text('Add task!',style: TextStyle(color: Colors.white,fontSize: 15),),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}