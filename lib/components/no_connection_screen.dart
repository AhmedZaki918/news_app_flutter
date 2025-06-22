import 'package:flutter/material.dart';

import '../res/colors.dart';

Widget displayNoConnection(VoidCallback onRetry) {
  return Scaffold(
    backgroundColor: background,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.0),
          Image.asset(
            'images/no_connection.png',
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {
              onRetry.call();
            },
            child: Column(
              children: [
                Text(
                  'No Connection',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                SizedBox(height: 8.0),
                Text('Try Again', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
