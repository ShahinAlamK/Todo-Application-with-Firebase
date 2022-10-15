import 'package:flutter/material.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Verification"),
      ),
      body: Column(
        children: const [
          Text("Please Check your MailBox"),
        ],
      ),
    );
  }
}
