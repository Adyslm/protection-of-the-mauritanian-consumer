import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:raqib/provider/chef_notification.dart';
import 'package:raqib/Screens/plaintes/chef_local/home_screen_chef.dart'; // Assurez-vous d'importer la bonne route

class NotificationPlainte extends StatelessWidget {
  const NotificationPlainte({super.key});

  @override
  Widget build(BuildContext context) {
    final notification = context.watch<ChefNotification>();

    Future<void> _copyToClipboard(String text) async {
      await Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copié dans le presse-papier')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la Plainte'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreenChef()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('Détails', notification.details, _copyToClipboard),
            _buildDetailItem('Moughataa', notification.moughataa, _copyToClipboard),
            _buildDetailItem('Adresse', notification.address, _copyToClipboard),
            const SizedBox(height: 20),
            if (notification.imageBase64 != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Photo jointe:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: InteractiveViewer(
                                panEnabled: true,
                                minScale: 0.5,
                                maxScale: 3.0,
                                child: Image.memory(
                                  base64Decode(notification.imageBase64!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              base64Decode(notification.imageBase64!),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else
              const Text('Aucune photo jointe'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, Function(String) onCopy) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.content_copy, size: 20),
                onPressed: () => onCopy(value),
                tooltip: 'Copier le texte',
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value.isNotEmpty ? value : 'Non spécifié'),
          ),
        ],
      ),
    );
  }
}