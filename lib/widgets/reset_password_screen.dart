import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Home3 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final Dio _dio = Dio();
  final String _endpoint = "https://mylab12.requestcatcher.com/reset-password";

  Future<void> _sendResetPasswordRequest(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        _endpoint,
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      debugPrint('Response: ${response.data}');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildResetButton(context),
              const SizedBox(height: 20),
              _buildBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w\.\+]+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final data = {
            'email': _emailController.text,
          };
          _sendResetPasswordRequest(data);
          showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return const AlertDialog(
                title: Text('Message'),
                content: Text("Reset password request sent!"),
              );
            },
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Reset password'),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Back'),
    );
  }
}
