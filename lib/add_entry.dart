import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddEntry extends StatefulWidget {
  final Function(Map<String, String>) onAdd;
  AddEntry({super.key, required this.onAdd});

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {

  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],

      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: const Text(
          "Add Entry",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: titleController,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Email or Username",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      // Get the details from the text controllers
                      Map<String, String> newRecord = {
                        'Title': titleController.text,
                        'Email': emailController.text,
                        'Password': passwordController.text,
                      };

                      // Trigger the callback to add the new
                      // record on the ListPage
                      widget.onAdd(newRecord);

                      // Navigate back to list page
                      Navigator.pop(context);
                    }, 
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, color: Colors.purple[400],),
                        const SizedBox(width: 8),
                        Text(
                          "Add Entry",
                          style: TextStyle(
                            color: Colors.purple[400],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       TextField(
      //         controller: titleController,
      //         decoration: const InputDecoration(labelText: 'Title'),
      //       ),
      //       TextField(
      //         controller: emailController,
      //         decoration: const InputDecoration(labelText: 'Email'),
      //       ),
      //       TextField(
      //         controller: passwordController,
      //         obscureText: true,
      //         decoration: const InputDecoration(labelText: 'Password'),
      //       ),
      //       const SizedBox(height: 16),
      //       ElevatedButton(
      //         onPressed: (){
      //           // Get the details from the text controllers
      //           Map<String, String> newRecord = {
      //             'Title': titleController.text,
      //             'Email': emailController.text,
      //             'Password': passwordController.text,
      //           };

      //           // Trigger the callback to add the new
      //           // record on the ListPage
      //           widget.onAdd(newRecord);

      //           // Navigate back to list page
      //           Navigator.pop(context);
      //         }, 
      //         child: const Text("Save"),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}