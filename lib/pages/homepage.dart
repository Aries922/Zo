import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Friend> friends = new List();
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController work = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    friends.add(Friend("Sumit", "42.0", "Need help in Physic Concept"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Friends"),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      TextField(controller: name,decoration: InputDecoration(labelText: "Name",hintText: "Abcd"),),
                                      TextField(controller: age,decoration: InputDecoration(labelText: "Age",hintText: "54")),
                                      TextField(controller: work,decoration: InputDecoration(labelText: "Work",hintText: "Need for help in cleaning")),
                                      RaisedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            friends.add(new Friend(
                                                name.text, age.text, work.text));
                                          });
                                        },
                                        child: Text("Add"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ));
                }),
          ],
        ),
        body: Container(
          // color: Colors.red,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 40,
                ),
                title: Text(friends[index].name),
                subtitle: Text(friends[index].work),
              );
            },
            itemCount: friends.length,
          ),
        ));
  }
}

class Friend {
  String name;
  String age;
  String work;
  Friend(this.name, this.age, this.work);
}
