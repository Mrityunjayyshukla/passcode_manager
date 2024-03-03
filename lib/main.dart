import 'package:flutter/material.dart';
import 'package:passcodemanager/add_entry.dart';
import 'package:passcodemanager/edit_entry.dart';
import 'package:passcodemanager/passkey.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // This is the list of all the records which are there.
  List<Map<String, String>> records = [];

  // This will initially show the list of the records
  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  // Load Records function will be used to fetch 
  // the results from the SharedPreferences
  _loadRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recordsList = prefs.getStringList('records') ?? [];
    setState(() {
      records=recordsList.map((recordString){
        List<String> parts = recordString.split(',');
        return {
          'Title': parts[0],
          'Email': parts[1],
          'Password': parts[2],
        };
      }).toList();
    });
  }

  // Function to add a new Record
  _addRecord(Map<String, String> newRecord){
    setState(() {
      records.add(newRecord);
    });

    // Save the Updated Records to sharedPreferences
    _saveRecords();
  }

  // Function to delete a record
  _deleteRecord(int index){
    setState(() {
      records.removeAt(index);
    });

    // Save updated records to SharedPreferences
    _saveRecords();
  }

  // Function to save records to sharedPreferences
  _saveRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recordsList = records.map((record) => '${record['Title']},${record['Email']},${record['Password']}').toList();
    prefs.setStringList('records', recordsList);
  }

  // Function to update a record
  _updateRecord(int index, Map<String, String> updatedRecord){
    setState(() {
      records[index]=updatedRecord;
    });

    // Save updated records to SharedPreferences
    _saveRecords();
  }

  // Function to navigate to the EditPage
  _navigateToEditPage(Map<String, String> record){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditEntry(
      record: record, 
      onUpdate: (updatedRecord){
        // Callback to handle the edited record
        _updateRecord(records.indexWhere((element) => element == record), updatedRecord);
      },
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],

      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: const Text(
          "Passcode Manager",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEntry(onAdd: _addRecord,)));
        },
        backgroundColor: Colors.purple[100],
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Passcode Manager is an app where you can store you passwords securely. This app is perfect for you if you always forget your passwords",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height-200,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: records.length,
                itemBuilder: (context, index){
                  final record=records[index];
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.purple[100],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${record['Title']}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){_navigateToEditPage(record);},
                                    child: const Icon(Icons.edit),
                                  ),
                                  const SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: (){_deleteRecord(index);},
                                    child: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Email or Username",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${record['Email']}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
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
                          const Text(
                            "********",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    onTap: (){
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        backgroundColor: Colors.purple[50],
                        isScrollControlled: true,
                        context: context, 
                        builder: (BuildContext context){
                          return PasskeyBuildSheet(index: index, records: records);
                        },
                      );
                    },
                  );
                }, 
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 16);
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}

