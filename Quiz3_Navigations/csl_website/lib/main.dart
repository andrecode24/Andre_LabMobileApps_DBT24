import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universitas Prasetiya Mulya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _showBottomMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF424242), // Dark grey background
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItem(context, 'PROGRAMS'),
              _buildMenuItem(context, 'ADMISSION'),
              _buildMenuItem(context, 'PEOPLE'),
              _buildMenuItem(context, 'LABORATORY'),
              _buildMenuItem(context, 'CAMPUS LIFE'),
              _buildMenuItem(context, 'OFFICE & SERVICES'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        Navigator.pop(context); // Close bottom sheet
        _showMenuDialog(context, title);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  void _showMenuDialog(BuildContext context, String menuItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$menuItem clicked'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE31E24), // Red color from the image
        elevation: 0,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Image.asset(
            'assets/prasmul-logo-white.png',
            fit: BoxFit.contain,
          ),
        ),
        title: null,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _showBottomMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset(
                'assets/logo_upm_biru.png',
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Vision Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'VISION',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'A globally recognized School for STEMpreneur Education and Research',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6B7280),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Mission Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'MISSION',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Provide quality STEM education and research for nurturing the holistic citizen graduates through:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6B7280),
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '1. Collaborative learning by enterprising involving interdisciplinary catalytic projects',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6B7280),
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '2. Innovative and impactful research to the society',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6B7280),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 60),
            
            // Footer Section
            Container(
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo_upm_biru.png',
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'BSD City Kavling Edutown I.1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Jl. BSD Raya Utama, BSD City 15339',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Kabupaten Tangerang, Indonesia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tel. (021) 304-50-500',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}