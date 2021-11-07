import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 06-11-2021 06:54 PM
///
class ProfileMySavesPage extends StatefulWidget {
  static const routeName = "/ProfileMySavesPage";

  const ProfileMySavesPage({Key? key}) : super(key: key);

  @override
  _ProfileMySavesPageState createState() => _ProfileMySavesPageState();
}

class _ProfileMySavesPageState extends State<ProfileMySavesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Saves"),
      ),
    );
  }
}
