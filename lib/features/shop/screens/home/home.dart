import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tareas/features/personalization/controllers/user_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Scaffold(
      body: SingleChildScrollView(child: Container(color: Colors.purple)),
    );
  }
}
