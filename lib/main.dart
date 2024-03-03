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

      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index){
          final record=records[index];
          return ListTile(
            title: Text('Title: ${record['Title']}'),
            subtitle: Column(
              children: [
                Text('Email: ${record['Email']}'),
                Text('Password: ${record['Password']}')
              ],
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
            //   // Navigate to RecordetailsPage when a record is tapped
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordDetailsPage(record:record)));
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _navigateToEditPage(record);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteRecord(index);
                  },
                ),
              ],
            )
          );
        },
      )
    );
  }
}

