import 'package:flutter/material.dart';
import 'package:interview/custom_widgets/avatar_widget.dart';
import 'package:interview/custom_widgets/display_text.dart';
import 'package:interview/data/user.dart';
import 'package:interview/data/mock_data.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late  TextEditingController searchController;
  late List<User?> users;
  late List<User?> listOfUserForFilter;


  @override
  void initState() {
    super.initState();
    users = User.fromJsonToList(allData());
    listOfUserForFilter = users;
    searchController = TextEditingController();
    searchController.addListener(()  {

      setState(() {
        users =  listOfFilteredUser(searchString : searchController.text.toString());
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<User?> listOfFilteredUser({required String searchString}) {

     List<User?> searchList = [];
    for (int i = 0; i < listOfUserForFilter.length; i++) {
      //
      if (listOfUserForFilter[i]!
              .firstName
              .toString()
              .toLowerCase()
              .contains(searchString.toLowerCase()) ||
          listOfUserForFilter[i]!
              .lastName
              .toString()
              .toLowerCase()
              .contains(searchString.toLowerCase()) ||
          listOfUserForFilter[i]!
              .email
              .toString()
              .toLowerCase()
              .contains(searchString.toLowerCase()) ||
          listOfUserForFilter[i]!
              .role
              .toString()
              .toLowerCase()
              .contains(searchString.toLowerCase())) {
        searchList.add(listOfUserForFilter[i]!);
      }
    }
    return searchList;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              reverse: true,
              itemCount: users.length,
              itemBuilder: (context, index) {
                User? item = users[index];
                return ListTile(
                  leading: CustomAvatarWidget(
                    networkImageUrl: '${item?.avatar}',
                  ),
                  title: DisplayText(label:'${item?.firstName} ${item?.lastName}'),
                  subtitle: DisplayText(label:'${item?.role}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var newUser = User(
              id: "1123444",
              avatar: '',
              firstName: "Khan",
              lastName: "Steven",
              email: "st123@gmail.com",
              role: "Flutter Developer");

          setState(() {
            users.add(newUser);
            listOfUserForFilter.add(newUser);
          });
        },
        label: Row(children: [Icon(Icons.add), SizedBox(width: 5,),DisplayText( label: 'User')],),
      ),
    );
  }
}
