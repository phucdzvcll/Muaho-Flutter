import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void showSnackBar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 60),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0x85444444),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                Icons.error_outline_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                content,
                style: Theme.of(this)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void pop() {
    Navigator.pop(this);
  }

  void popUtil(String routerName) {
    Navigator.popUntil(
      this,
      ModalRoute.withName(routerName),
    );
  }
}
