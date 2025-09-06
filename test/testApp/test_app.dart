import 'package:athkari/app/core/methods/success_snackbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       MaterialApp(
        title: 'Toast Notification Test',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Toast Notification Test'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                successToastMessage(context, 'This is a success message!');
              },
              child: const Text('Show Toast'),
            ),
          ),
        ));
      
    
  }
}


