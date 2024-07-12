import 'package:flutter/material.dart';

class ImageFullScreen extends StatelessWidget {
  const ImageFullScreen({
    super.key,
    required this.photo,
    required this.expenseTitle,
  });
  final String photo;
  final String expenseTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: Text(expenseTitle),
      ),
      body: Image.network(
        photo,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
