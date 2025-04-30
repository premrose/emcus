import 'package:emcus/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/widgets/common_textfield.dart';
import '../../dashboard/dashboard_screen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF2C2154),
      appBar: AppBar(
        backgroundColor: const Color(0XFF2C2154),
        centerTitle: true,
        elevation: 0,
        title: SizedBox(
          height: 31,
          child: Image.asset("assets/emcus_logo.png"),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(21),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration successful!')),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen(),
                    ),
                  );
                } else if (state is SignUpFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18),
                      CommonTextfield(
                        controller: _nameController,
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? 'Enter your name'
                                    : null,
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: _companyController,
                        labelText: 'Company Name',
                        hintText: 'Enter your company name',
                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? 'Enter your company name'
                                    : null,
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: _emailController,
                        labelText: 'Email Address',
                        hintText: 'Enter your email address',
                        validator:
                            (v) =>
                                v == null || !v.contains('@')
                                    ? 'Enter a valid email'
                                    : null,
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: _passwordController,
                        obscureText: true,
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        validator:
                            (v) =>
                                v == null || v.length < 6
                                    ? 'Password must be at least 6 characters'
                                    : null,
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        labelText: 'Confirm Password',
                        hintText: 'Enter your password',
                        validator:
                            (v) =>
                                v != _passwordController.text
                                    ? 'Passwords do not match'
                                    : null,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            width: 27,
                            child: Checkbox(
                              value: _agreed,
                              onChanged:
                                  (v) => setState(() => _agreed = v ?? false),
                            ),
                          ),
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                text:
                                    'By signing up you are agreeing with the FFE ',
                                children: [
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 42,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 42,
                                  vertical: 14,
                                ),
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27),
                                )
                              ),
                              onPressed:
                                  state is SignUpLoading
                                      ? null
                                      : () {
                                        if (_formKey.currentState!.validate() &&
                                            _agreed &&
                                            _passwordController.text ==
                                                _confirmPasswordController
                                                    .text) {
                                          context.read<AuthBloc>().add(
                                            SignUpSubmitted(
                                              user: UserModel(
                                                userName: _nameController.text,
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                              child:
                                  state is SignUpLoading
                                      ? const SizedBox(
                                        height: 16,
                                        width: 42,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                      : const Text('Register'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have account?'),
                          TextButton(
                            onPressed:
                                () => {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const SignInScreen(),
                                    ),
                                  ),
                                },
                            child: const Text(
                              'Sign in here.',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
