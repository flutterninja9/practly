import 'package:flutter/material.dart';
import 'package:practly/features/auth/buisness_logic/auth_state.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static String get route => "/sign-in";

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<ShadFormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignIn = true;
  final _authState = AuthState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _authState,
        builder: (context, _) {
          return Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: ShadForm(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _isSignIn ? 'Welcome Back' : 'Create Account',
                            textAlign: TextAlign.center,
                            style: ShadTheme.of(context).textTheme.h3,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isSignIn
                                ? 'Sign in to your account'
                                : 'Sign up for a new account',
                            textAlign: TextAlign.center,
                            style: ShadTheme.of(context).textTheme.small,
                          ),
                          const SizedBox(height: 32),
                          ShadInputFormField(
                            controller: _emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            placeholder: const Text('Email'),
                            keyboardType: TextInputType.emailAddress,
                            prefix: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child:
                                  ShadImage.square(size: 16, LucideIcons.mail),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ShadInputFormField(
                            controller: _passwordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: _authState.obscure,
                            placeholder: const Text('Password'),
                            prefix: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child:
                                  ShadImage.square(size: 16, LucideIcons.lock),
                            ),
                            suffix: ShadButton(
                              width: 24,
                              height: 24,
                              padding: EdgeInsets.zero,
                              decoration: const ShadDecoration(
                                secondaryBorder: ShadBorder.none,
                                secondaryFocusedBorder: ShadBorder.none,
                              ),
                              icon: ShadImage.square(
                                size: 16,
                                _authState.obscure
                                    ? LucideIcons.eyeOff
                                    : LucideIcons.eye,
                              ),
                              onPressed: () {
                                _authState.setObscure(!_authState.obscure);
                              },
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          ShadButton(
                            onPressed: _authState.isLoading
                                ? null
                                : _handleEmailPasswordAuth,
                            child: Text(_isSignIn ? 'Sign In' : 'Sign Up'),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'OR',
                                  style: ShadTheme.of(context).textTheme.muted,
                                ),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ShadButton.outline(
                            onPressed: _authState.isLoading
                                ? null
                                : _authState.signInWithGoogle,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(LucideIcons.lock),
                                SizedBox(width: 8),
                                Text('Continue with Google'),
                              ],
                            ),
                          ),
                          if (_authState.allowAnonymousSignups)
                            _AnonymousSignInButton(authState: _authState),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _isSignIn
                                    ? "Don't have an account?"
                                    : "Already have an account?",
                                style: ShadTheme.of(context).textTheme.small,
                              ),
                              ShadButton.link(
                                onPressed: () =>
                                    setState(() => _isSignIn = !_isSignIn),
                                child: Text(_isSignIn ? 'Sign Up' : 'Sign In'),
                              ),
                            ],
                          ),
                          if (_authState.errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: ShadAlert.destructive(
                                title: const Text('Error'),
                                description: Text(_authState.errorMessage!),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (_authState.isLoading)
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(child: LinearProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  void _handleEmailPasswordAuth() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      if (_isSignIn) {
        _authState.signInWithEmailAndPassword(email, password);
      } else {
        _authState.createUserWithEmailAndPassword(email, password);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class _AnonymousSignInButton extends StatelessWidget {
  const _AnonymousSignInButton({
    super.key,
    required AuthState authState,
  }) : _authState = authState;

  final AuthState _authState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        ShadButton.ghost(
          onPressed: _authState.isLoading ? null : _authState.signInAnonymously,
          child: const Text('Continue as Guest'),
        ),
      ],
    );
  }
}
