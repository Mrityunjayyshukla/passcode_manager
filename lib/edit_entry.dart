import 'package:flutter/material.dart';

class EditEntry extends StatefulWidget {
  final Map<String, String> record;
  final Function(Map<String,String>) onUpdate;

  const EditEntry({super.key, required this.record, required this.onUpdate});

  @override
  State<EditEntry> createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  late TextEditingController titleController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    titleController=TextEditingController(text: widget.record['Title']??'');
    emailController=TextEditingController(text: widget.record['Email']??'');
    passwordController=TextEditingController(text: "");
    super.initState();
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: (){
                //Get the updated details from text controllers
                Map<String, String> updatedRecord = {
                  'Title': titleController.text,
                  'Email': emailController.text,
                  'Password': passwordController.text,
                };

                // Trigger the callback to update record
                // on the List Page
                widget.onUpdate(updatedRecord);

                // Navigate back to ListPage
                Navigator.pop(context);
              }, 
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}