import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recept_app/main_widgets/main_home.dart';
import 'package:recept_app/main_widgets/recept_home.dart';
import '../screens/auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void showIOSEdit() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Name"),
                  controller: _controller,
                  onChanged: (value) {},
                ),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_controller.text != "") {
                          await user
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            "clientName": _controller.text
                          }).whenComplete(() {
                            Navigator.of(context).pop();
                            setState(() {
                              _controller.text = "";
                            });
                          });
                        }
                      },
                      child: Text("Save Changes"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    Future showAndroidEdit() => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Edit Name",
            ),
            content: SingleChildScrollView(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Name"),
                controller: _controller,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    if (_controller.text != "") {
                      await user
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        "clientName": _controller.text
                      }).whenComplete(() {
                        Navigator.of(context).pop();
                        setState(() {
                          _controller.text = "";
                        });
                      });
                    }
                  },
                  child: Text("Save Changes"))
            ],
          ),
        );

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: user.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                title: Text(data['clientName']),
                backgroundColor: Colors.yellow.shade900,
              ),
              backgroundColor: Colors.grey.shade300,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const ProfileHeaderLabel(headerLabel: "Account Info."),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            RepeatedListTile(
                              title: "Email Address",
                              icon: Icons.email,
                              subTitle: data['clientmail'] == ''
                                  ? "There is no email"
                                  : data['clientmail'],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const ProfileHeaderLabel(headerLabel: "Account Settings"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            RepeatedListTile(
                              title: "Edit Profile",
                              icon: Icons.edit,
                              onPressed: () {
                                Platform.isAndroid
                                    ? showAndroidEdit()
                                    : showIOSEdit();
                              },
                            ),
                            const YellowDivider(),
                            RepeatedListTile(
                              title: "Change Password",
                              icon: Icons.lock,
                              onPressed: () {
                                Platform.isAndroid
                                    ? showAndroidChangePassword()
                                    : showIOSChangePassword();
                              },
                            ),
                            const YellowDivider(),
                            RepeatedListTile(
                              title: "Log out",
                              subTitle: "",
                              icon: Icons.logout,
                              onPressed: () {
                                FirebaseAuth.instance.signOut().then((value) =>
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AuthScreen())));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purpleAccent,
            ),
          );
        },
      ),
    );
  }

  void showIOSChangePassword() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "New Password"),
                controller: _controller,
                onChanged: (value) {},
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_controller.text != "") {
                        await FirebaseAuth.instance.currentUser!
                            .updatePassword(_controller.text)
                            .then((value) {
                          debugPrint("Changed Password");
                          Navigator.of(context).pop();
                          setState(() {
                            _controller.text = "";
                          });
                        }).catchError((error) {
                          debugPrint(error.toString());
                        });
                      }
                    },
                    child: Text("Save Changes"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future showAndroidChangePassword() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Edit Password",
          ),
          content: SingleChildScrollView(
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "New Password"),
              controller: _controller,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () async {
                  if (_controller.text != "") {
                    await FirebaseAuth.instance.currentUser!
                        .updatePassword(_controller.text)
                        .then((value) {
                      debugPrint("Changed Password");
                      Navigator.of(context).pop();
                      setState(() {
                        _controller.text = "";
                      });
                    }).catchError((error) {
                      debugPrint(error.toString());
                    });
                  }
                },
                child: Text("Save Changes"))
          ],
        ),
      );
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const ProfileHeaderLabel({
    Key? key,
    required this.headerLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          headerLabel,
          style: TextStyle(fontSize: 25, color: Colors.black.withOpacity(.6)),
        ),
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ]),
    );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;
  const RepeatedListTile({
    Key? key,
    required this.title,
    this.subTitle = "",
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}
