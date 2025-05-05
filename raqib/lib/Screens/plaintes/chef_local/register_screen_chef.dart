import 'package:flutter/material.dart';
import 'package:raqib/Screens/plaintes/chef_local/login_screen_chef.dart';
import 'package:raqib/services/chef_services.dart';

class ChefRegisterScreen extends StatefulWidget {
  const ChefRegisterScreen({Key? key}) : super(key: key);

  @override
  _ChefRegisterScreenState createState() => _ChefRegisterScreenState();
}

class _ChefRegisterScreenState extends State<ChefRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nniController = TextEditingController();
  final _phoneController = TextEditingController();
  final _moughataaController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _nniController.dispose();
    _phoneController.dispose();
    _moughataaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    try {
      final result = await ChefServices.register(
        name: _nameController.text.trim(),
        nni: _nniController.text.trim(),
        phoneNum: _phoneController.text.trim(),
        moughataa: _moughataaController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (result['success'] == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ChefLoginScreen()),
          (route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Inscription réussie! Veuillez vous connecter'),
            duration: Duration(seconds: 3),
          ),
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
            title: const Text('Erreur d\'inscription'),
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
      appBar: AppBar(title: const Text('Inscription Chef')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: AutofillGroup(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom complet',
                    prefixIcon: Icon(Icons.person),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom';
                    }
                    if (value.trim().length < 3) {
                      return 'Le nom doit contenir au moins 3 caractères';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nniController,
                  decoration: const InputDecoration(
                    labelText: 'NNI',
                    prefixIcon: Icon(Icons.credit_card),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre NNI';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
                      return '10 chiffres requis';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Numéro de téléphone',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
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
                DropdownButtonFormField<String>(
                  value:
                      _moughataaController.text.isEmpty
                          ? null
                          : _moughataaController.text,
                  decoration: const InputDecoration(
                    labelText: 'Moughataa',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  items:
                      const [
                        'Arafat',
                        'El Mina',
                        'Riyadh',
                        'Ksar',
                        'Sebkha',
                        'Tevragh Zeïna',
                        'Dar Naim',
                        'Teyareth',
                        'Toujounine',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _moughataaController.text = newValue ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez sélectionner votre moughataa';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
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
                  onFieldSubmitted: (_) => _register(),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      //=================
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 33,
                        ),
                        backgroundColor: const Color.fromARGB(255, 20, 232, 52), 
                        foregroundColor: Colors.white, 
                        elevation: 5, 
                        shadowColor: const Color.fromARGB(255, 82, 239, 71).withOpacity(
                          0.3,
                        ), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          side: BorderSide(
                            color:
                                const Color.fromARGB(255, 45, 156, 91), 
                            width: 2, 
                          ),
                        ),
                      ),
                      //================
                      child:
                          _isLoading
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : const Text('S\'inscrire',
                              style: TextStyle(
                                fontSize: 15
                              ),
                              ),
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
                                builder: (context) => const ChefLoginScreen(),
                              ),
                            );
                          },
                  child: const Text("Déjà inscrit? Se connecter"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
