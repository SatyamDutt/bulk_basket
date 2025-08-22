import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
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
                'How can we help you?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 20),
              _HelpQuestion(
                question: '1. How do I create an account?',
                answer:
                    'Go to the Sign Up screen and register using your email or phone number. You will receive a confirmation message.',
              ),
              _HelpQuestion(
                question: '2. How do I place an order?',
                answer:
                    'Browse through categories, tap on a product to view details, then tap "Add to Cart". Go to the cart and complete checkout.',
              ),
              _HelpQuestion(
                question: '3. How can I track my order?',
                answer:
                    'Navigate to "Order History" from your profile and select an order to see its status.',
              ),
              _HelpQuestion(
                question: '4. How do I get bulk discounts?',
                answer:
                    'Add a large quantity of a product to your cart. If eligible, the discount will be automatically applied at checkout.',
              ),
              _HelpQuestion(
                question: '5. What if I forget my password?',
                answer:
                    'Use the "Forgot Password" link on the login screen. You will receive a reset link via email or SMS.',
              ),
              _HelpQuestion(
                question: '6. How do I contact customer support?',
                answer:
                    'You can reach us via the "Contact Us" section in the app or email us at satyamdutt46@gmail.com.',
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'Thank you for using our app!',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.brown,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HelpQuestion extends StatelessWidget {
  final String question;
  final String answer;

  const _HelpQuestion({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
