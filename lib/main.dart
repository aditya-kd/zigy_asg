import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 27, 74, 194),
        title: const Text('Zigy'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: StadiumBorder(),
            
          ),
          child: const Text('GET Function',style: TextStyle(color: Colors.black),),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
          },
        ),

        ElevatedButton(
          child: const Text(style: TextStyle(color: Colors.black),'POST Function'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: StadiumBorder(),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostRequestPage()),
            );
          },
        )
        ]),
      ),
    );
  }
}




class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final url = "https://reqres.in/api/users?page=2";
  var result;
  var list = [];
  void fetchData() async {

    try{

    final response = await get(Uri.parse(url));
    final _jsonresult = response.body;

    setState(() {
      result = jsonDecode(_jsonresult);
      result = result["data"];
    });
    } catch(err){
      print("Network Error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    int len = result.length;
    return 
       Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 27, 74, 194),
          title: const Text("Zigy | Fetch ")),
        body: ListView.builder(
         itemCount: len,
          itemBuilder: (context, i){
            
            final item = result[i];
            return Text("${item["id"]}\n${item["first_name"]}\n ${item["email"]}\n\n");
          }),
      );
  
  }
}

class PostRequestPage extends StatefulWidget {
  const PostRequestPage({super.key});

  @override
  State<PostRequestPage> createState() => _PostRequestPageState();
}

class _PostRequestPageState extends State<PostRequestPage> {
  final url = "https://reqres.in/api/users";
  var display_data = "";
  var button_data = "Send Data";

  var name = "Morpheus";
  var job = "Leader";
  void postData() async {
    try{
    final response = await post(Uri.parse(url), 
    
    body: 
    {
      "name": name,
      "job" : job
    });

    print(response.body);

    setState(() {
      display_data = response.body;
      button_data = "Send data, again.";
    });
    }
    catch(err){
      print("POST Network Error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 74, 194),
        title: const Text("Zigy | Send")),
      body: Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 57, 56, 56)),
          onPressed: postData ,
          child:  Text(button_data),
        ), 
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center( child: Text(display_data),),
        )
        ])
    ,)),);
  }
}