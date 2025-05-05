import 'package:flutter/material.dart';
import 'package:raqib/Screens/home_screen.dart';
import 'package:raqib/Screens/plaintes/chef_local/home_screen_chef.dart';
import 'package:raqib/Screens/plaintes/chef_local/register_screen_chef.dart';
import 'package:raqib/services/chef_services.dart';

class ChefLoginScreen extends StatefulWidget {
  const ChefLoginScreen({Key? key}) : super(key: key);

  @override
  _ChefLoginScreenState createState() => _ChefLoginScreenState();
}

class _ChefLoginScreenState extends State<ChefLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    try {
      final result = await ChefServices.login(
        phoneNum: _phoneController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (result['success'] == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreenChef()),
          (route) => false,
        );
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Erreur de connexion'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion Chef')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Numéro de téléphone',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre numéro';
                    }
                    if (!RegExp(r'^[0-9]{8}$').hasMatch(value.trim())) {
                      return '8 chiffres requis';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe (4 chiffres)',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  keyboardType: TextInputType.number,
                  autofillHints: const [AutofillHints.password],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    if (!RegExp(r'^[0-9]{4}$').hasMatch(value.trim())) {
                      return '4 chiffres requis';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _login(),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 33,
                        ),
                        backgroundColor: const Color.fromARGB(255, 20, 232, 52),
                        foregroundColor: Colors.white,
                        elevation: 5,
                        shadowColor: const Color.fromARGB(
                          255,
                          82,
                          239,
                          71,
                        ).withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: const Color.fromARGB(255, 45, 156, 91),
                            width: 2,
                          ),
                        ),
                      ),
                      child:
                          _isLoading
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                              : const Text('Se connecter'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed:
                      _isLoading
                          ? null
                          : () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChefRegisterScreen(),
                              ),
                            );
                          },
                  child: const Text("Pas encore inscrit? Créer un compte"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
