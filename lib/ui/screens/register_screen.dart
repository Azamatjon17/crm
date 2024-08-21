import 'package:crm/bloc/auth_bloc/auth_bloc.dart';
import 'package:crm/bloc/auth_bloc/auth_event.dart';
import 'package:crm/bloc/auth_bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  String _password = '';
  String _passwordConfirmation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: CircularProgressIndicator(),
              ),
            );
          } else if (state is Authenticated) {
            Navigator.pop(context); // close the dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is AuthError) {
            Navigator.pop(context); // close the dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 55, left: 15, right: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Your existing UI code here
                // Replace the onTap for sign up with:
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<AuthBloc>().add(SignUpEvent(
                            _name,
                            _phone,
                            _password,
                            _passwordConfirmation,
                          ));
                    }
                  },
                  // existing code
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
