import 'package:flutter/material.dart';

void pushStatisticsPage(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(title: const Text('Apple')),
              body: null,
            )
          }
      )
  );
}