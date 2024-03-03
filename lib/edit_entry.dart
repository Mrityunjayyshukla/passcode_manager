import 'package:flutter/material.dart';

class EditEntry extends StatefulWidget {
  final Map<String, String> record;
  final Function(Map<String, String>) onUpdate;

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
    titleController = TextEditingController(text: widget.record['Title'] ?? '');
    emailController = TextEditingController(text: widget.record['Email'] ?? '');
    passwordController = TextEditingController(text: "");
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
          "Edit Entry",
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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, color: Colors.purple[400],),
                        const SizedBox(width: 8),
                        Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.purple[400],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
