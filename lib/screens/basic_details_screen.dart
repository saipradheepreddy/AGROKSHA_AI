import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../utils/app_provider.dart';
import 'home_screen.dart';
import 'location_setup_screen.dart';

class BasicDetailsScreen extends StatefulWidget {
  const BasicDetailsScreen({super.key});

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _farmSizeCtrl = TextEditingController();
  String? _selectedSoil;
  bool _isLoading = false;

  final List<String> _soilTypes = [
    'Alluvial Soil', 'Black Soil', 'Red Soil', 'Laterite Soil', 'Arid Soil'
  ];

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _ageCtrl.dispose();
    _farmSizeCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveDetails() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    try {
      final provider = context.read<AppProvider>();
      final currentUser = provider.currentUser;
      
      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(
          mobile: _phoneCtrl.text.trim(),
          age: int.tryParse(_ageCtrl.text),
          farmSize: _farmSizeCtrl.text.trim(),
          soilType: _selectedSoil,
        );
        
        await provider.updateProfile(updatedUser);
        
        if (!mounted) return;
        
        // Go to Location Setup next
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LocationSetupScreen(isFirstLaunch: true)),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppProvider>().currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Complete Your Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${user?.name ?? "Agroksha Farmer"}! 👋',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ).animate().fadeIn(),
              const SizedBox(height: 8),
              const Text(
                'Help us personalize your farming experience by providing a few more details.',
                style: TextStyle(color: Colors.grey),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 32),
              
              // Mobile Number
              _buildLabel('Mobile Number'),
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: _inputStyle('Enter 10-digit mobile number', Icons.phone_android_rounded),
                validator: (v) => (v == null || v.length < 10) ? 'Enter valid mobile' : null,
              ),
              const SizedBox(height: 20),
              
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Age'),
                        TextFormField(
                          controller: _ageCtrl,
                          keyboardType: TextInputType.number,
                          decoration: _inputStyle('e.g. 45', Icons.cake_rounded),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Farm Size'),
                        TextFormField(
                          controller: _farmSizeCtrl,
                          decoration: _inputStyle('e.g. 2 Acres', Icons.landscape_rounded),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              _buildLabel('Soil Type'),
              DropdownButtonFormField<String>(
                value: _selectedSoil,
                items: _soilTypes.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (v) => setState(() => _selectedSoil = v),
                decoration: _inputStyle('Select soil type', Icons.grass_rounded),
              ),
              
              const SizedBox(height: 60),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Continue to App', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, left: 4),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
  );

  InputDecoration _inputStyle(String hint, IconData icon) => InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
    filled: true,
    fillColor: Colors.grey.shade50,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.primary, width: 2)),
  );
}
