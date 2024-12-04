import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Home2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Dio _dio = Dio();
  final String _endpoint = "https://mylab12.requestcatcher.com/signup";

  Future<void> _sendSignUpRequest(Map<String, dynamic> data) async {
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
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 20),
              _buildLoginField(),
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildSignUpButton(context),
              const SizedBox(height: 20),
              _buildBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginField() {
    return TextFormField(
      controller: _loginController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Login',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your login';
        }
        return null;
      },
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

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 7) {
          return 'Password must be at least 7 characters long';
        }
        return null;
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final data = {
            'login': _loginController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
          };
          _sendSignUpRequest(data);
          showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return const AlertDialog(
                title: Text('Message'),
                content: Text("Sign up request sent!"),
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
      child: const Text('Sign up'),
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
