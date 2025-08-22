


//new color
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.amber.shade700,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade50, Colors.orange.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Departmental Store App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Our app offers a convenient platform for purchasing daily essentials like groceries, snacks, grooming, and skincare products.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 20),
              Text(
                '📦 Features:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              SizedBox(height: 6),
              Text('- User registration and login'),
              Text('- Product catalog with categories'),
              Text('- Shopping cart & bulk ordering'),
              Text('- Checkout with online payments'),
              Text('- Free home delivery & order tracking'),
              Text('- Push notifications for updates'),
              SizedBox(height: 20),
              Text(
                '🛠 Technologies Used:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              SizedBox(height: 6),
              Text('- Flutter & Dart for frontend'),
              Text('- Firebase / Node.js backend'),
              Text('- Stripe, Razorpay, or Google Pay for payments'),
              Text('- Firebase Cloud Messaging (FCM)'),
              SizedBox(height: 20),
              Text(
                '🎯 Goal:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              SizedBox(height: 6),
              Text(
                'Deliver a seamless and user-friendly shopping experience with fast delivery and secure payments.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'Developed by Ansh Infotech',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.brown,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  '📅 Project Deadline: 5th March 2025',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
