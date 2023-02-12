import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List users = [];
  getData() async {
    CollectionReference usersref =
        FirebaseFirestore.instance.collection("users");
    await usersref.orderBy('age', descending: true).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          users.add(element.data());
          print(users);
        });
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
       
          ListView.builder(
            
            shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, i) {
                return Expanded(
                  child:  Container(
                      alignment: Alignment.center,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0,3)
                        )]
                      ),
                      
                      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      child: ListTile(
                        title: Text(
                          "${users[i]['username']}",
                          style: TextStyle(fontSize: 40),
                        ),
                        subtitle: Text(
                          "${users[i]['email']}",
                          style: TextStyle(color: Colors.red),
                        ),
                        trailing: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("${users[i]['img']}")),
                      ),
                    ),
                  
                );
              }),
        ],
      ),
    );
  }
}
