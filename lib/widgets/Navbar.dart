import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cryptostats/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:cryptostats/models/user_model.dart';
import '../pages/Login.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
    Provider.of<ThemeProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [

          const SizedBox(
            height: 60.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  height: 60,


                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                  )),
              IconButton(
                onPressed: () {
                  themeProvider.toggleTheme();
                },

                icon: (themeProvider.themeMode == ThemeMode.light)
                    ? const Icon(Icons.dark_mode_sharp)
                    : const Icon(Icons.light_mode_sharp),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_rounded),
            title: loggedInUser.firstName != null && loggedInUser.secondName != null
                ? Text("${loggedInUser.firstName} ${loggedInUser.secondName}".toUpperCase())
                : Text("User User"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.mail),
            title: loggedInUser.email != null
                ? Text("${loggedInUser.email}")
                : Text("user1@gmail.com"),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),

          InkWell(
            onTap: () {
              // Use PushNamed Function of Navigator class to push the named route
              Navigator.pushNamed(context, 'login');
            },
            child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: ()
                {
                  logout(context);
                }),

          ),
          ListTile(

            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 400,),
        ],
      ),
    );

  }
}
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()));
}