import 'package:flutter/material.dart';
import 'package:interview/avatar_widget.dart';
import 'package:interview/data/user.dart';
import 'package:interview/data/mock_data.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   late TextEditingController searchController;
  late List<User?> users;
  late List<User?> filteredUsers;

  @override
  void initState() {
    super.initState();
    users = User.fromJsonToList(allData());
    filteredUsers = users;
    searchController = TextEditingController();
    searchController.addListener(() {
      setState(() {
        users = _filterList(searchController.text.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  List<User> _filterList(String value) {
    List<User> searchList = [];
    for (int i = 0; i < filteredUsers.length; i++) {
      if (filteredUsers[i]!
          .firstName
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase()) ||
          filteredUsers[i]!
              .lastName
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()) ||
          filteredUsers[i]!
              .email
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()) ||
          filteredUsers[i]!
              .role
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        searchList.add(filteredUsers[i]!);
      }
    }
    return searchList;
  }



  @override
  Widget build(BuildContext context) {
     users = User.fromJsonToList(allData());

    _getUserAvatar(url) {
      return CircleAvatar(backgroundImage: NetworkImage(url));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User? item = users[index];
                return ListTile(
                  leading: CustomAvatarWidget(networkImageUrl: '${item?.avatar}',),
                  title: Text('${item?.firstName} ${item?.lastName}'),
                  subtitle: Text('${item?.role}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            var newUser = User(id: "b32ec56c-21bb-4b7b-a3a0-635b8bca1f9d", avatar: null, firstName: "James", lastName: "May", email: "ssaull1c@tripod.com", role: "Developer");
        },
        tooltip: 'Add new',
        child: Icon(Icons.add),
      ),
    );
  }
}
