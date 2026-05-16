import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../utils/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Personal Details
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _aadhaarCtrl = TextEditingController();
  
  // Location
  final _stateCtrl = TextEditingController();
  final _districtCtrl = TextEditingController();
  final _mandalCtrl = TextEditingController();
  final _villageCtrl = TextEditingController();
  
  // Farm Details
  final _acresCtrl = TextEditingController();
  final _primaryCropCtrl = TextEditingController();
  final _experienceCtrl = TextEditingController();
  
  String? _gender = 'Male';
  String? _soilType = 'Red';
  String? _irrigationType = 'Borewell';
  String? _cropStage = 'Seedling';
  
  // Crop History
  List<CropHistory> _cropHistoryList = [];
  
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _isLoadingLocation = false;
  
  final List<String> _avatars = ['👨‍🌾', '👳‍♂️', '👩‍🌾', '🧕'];
  int _selectedAvatarIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }
  
  void _loadExistingData() {
    final provider = context.read<AppProvider>();
    final user = provider.currentUser;
    if (user == null) return;
    
    _nameCtrl.text = user.name;
    _phoneCtrl.text = user.mobile ?? '';
    _dobCtrl.text = user.dob ?? '';
    _aadhaarCtrl.text = user.aadhaar ?? '';
    
    _stateCtrl.text = user.state ?? '';
    _districtCtrl.text = user.district ?? '';
    _mandalCtrl.text = user.mandal ?? '';
    _villageCtrl.text = user.village ?? '';
    
    _acresCtrl.text = user.farmSize?.replaceAll(' acres', '') ?? '';
    _primaryCropCtrl.text = provider.selectedCrop;
    _experienceCtrl.text = user.experienceYears?.toString() ?? '';
    
    if (user.gender != null) _gender = user.gender;
    if (user.soilType != null) _soilType = user.soilType;
    if (user.irrigationType != null) _irrigationType = user.irrigationType;
    if (user.cropStage != null) _cropStage = user.cropStage;
    
    _cropHistoryList = List.from(user.cropHistoryList);
    
    if (user.profileImagePath != null && user.profileImagePath!.isNotEmpty) {
      _profileImage = File(user.profileImagePath!);
    }
  }

  Future<void> _pickProfileImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (picked != null && mounted) {
      setState(() => _profileImage = File(picked.path));
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) throw Exception('Permission denied');
      }
      Position pos = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _stateCtrl.text = place.administrativeArea ?? '';
          _districtCtrl.text = place.subAdministrativeArea ?? place.locality ?? '';
          _villageCtrl.text = place.subLocality ?? place.name ?? '';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to get location: $e')));
    } finally {
      setState(() => _isLoadingLocation = false);
    }
  }

  void _listenToVoice() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
            final words = val.recognizedWords.toLowerCase();
            if (words.contains('paddy')) _primaryCropCtrl.text = 'Paddy';
            if (words.contains('cotton')) _primaryCropCtrl.text = 'Cotton';
            if (words.contains('name is')) {
               final idx = words.indexOf('name is');
               _nameCtrl.text = val.recognizedWords.substring(idx + 8).split(' ').first;
            }
            if (val.hasConfidenceRating && val.confidence > 0) {
               setState(() => _isListening = false);
            }
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _addCropHistory() {
    setState(() {
      _cropHistoryList.add(CropHistory(
        year: '${DateTime.now().year - _cropHistoryList.length}',
        cropName: 'New Crop',
        season: 'Kharif',
      ));
    });
  }

  void _saveProfile() {
    context.read<AppProvider>().updateProfileDetails(
      name: _nameCtrl.text.trim().isNotEmpty ? _nameCtrl.text.trim() : null,
      crop: _primaryCropCtrl.text.trim().isNotEmpty ? _primaryCropCtrl.text.trim() : null,
      farmSize: _acresCtrl.text.trim().isNotEmpty ? '${_acresCtrl.text.trim()} acres' : null,
      imagePath: _profileImage?.path,
      gender: _gender,
      dob: _dobCtrl.text,
      aadhaar: _aadhaarCtrl.text,
      state: _stateCtrl.text,
      district: _districtCtrl.text,
      mandal: _mandalCtrl.text,
      village: _villageCtrl.text,
      soilType: _soilType,
      irrigationType: _irrigationType,
      cropStage: _cropStage,
      experienceYears: int.tryParse(_experienceCtrl.text),
      cropHistoryList: _cropHistoryList,
    );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved securely.'), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F4),
      appBar: AppBar(
        title: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
        elevation: 0,
        actions: [
          IconButton(icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: _isListening ? Colors.red : Colors.white), onPressed: _listenToVoice),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatarSection(),
            const SizedBox(height: 24),
            _buildSectionHeader('Personal Details'),
            _buildCard([
              _buildField(_nameCtrl, 'Full Name', Icons.person),
              _buildDropdown('Gender', Icons.wc, ['Male', 'Female', 'Other'], _gender, (v) => setState(() => _gender = v)),
              _buildField(_dobCtrl, 'Date of Birth', Icons.calendar_today, isDate: true),
              _buildField(_phoneCtrl, 'Phone Number', Icons.phone, type: TextInputType.phone),
              _buildField(_aadhaarCtrl, 'Aadhaar Number (Optional)', Icons.verified_user, type: TextInputType.number, obscure: true),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('Location Details', action: _buildLocationBtn()),
            _buildCard([
              _buildField(_stateCtrl, 'State', Icons.map),
              _buildField(_districtCtrl, 'District', Icons.location_city),
              _buildField(_mandalCtrl, 'Mandal', Icons.holiday_village),
              _buildField(_villageCtrl, 'Village', Icons.home),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('Farm Details'),
            _buildCard([
              _buildField(_acresCtrl, 'Total Land Size (Acres)', Icons.landscape, type: TextInputType.number),
              _buildField(_primaryCropCtrl, 'Primary Crop', Icons.grass),
              _buildDropdown('Soil Type', Icons.layers, ['Red', 'Black', 'Sandy', 'Clay'], _soilType, (v) => setState(() => _soilType = v)),
              _buildDropdown('Irrigation', Icons.water_drop, ['Borewell', 'Canal', 'Drip', 'Rainfed'], _irrigationType, (v) => setState(() => _irrigationType = v)),
              _buildDropdown('Crop Stage', Icons.eco, ['Seedling', 'Vegetative', 'Flowering', 'Harvesting'], _cropStage, (v) => setState(() => _cropStage = v)),
              _buildField(_experienceCtrl, 'Farming Experience (Years)', Icons.work_history, type: TextInputType.number),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('Crop History (Past 3 Years)', action: _buildAddHistoryBtn()),
            _buildCropHistorySection(),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity, height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: _saveProfile,
                child: const Text('Save Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCropHistorySection() {
    if (_cropHistoryList.isEmpty) return const Text('No history added. Tap + to add.', style: TextStyle(color: Colors.grey));
    return Column(
      children: List.generate(_cropHistoryList.length, (i) {
        final entry = _cropHistoryList[i];
        return _buildCard([
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: entry.year,
                  decoration: const InputDecoration(labelText: 'Year', isDense: true),
                  onChanged: (val) => _cropHistoryList[i] = CropHistory(year: val, cropName: entry.cropName, season: entry.season, secondaryCrop: entry.secondaryCrop, yieldStr: entry.yieldStr),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: entry.season ?? 'Kharif',
                  items: ['Kharif', 'Rabi', 'Summer'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
                  onChanged: (val) => setState(() => _cropHistoryList[i] = CropHistory(year: entry.year, cropName: entry.cropName, season: val, secondaryCrop: entry.secondaryCrop, yieldStr: entry.yieldStr)),
                  decoration: const InputDecoration(labelText: 'Season', isDense: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            initialValue: entry.cropName,
            decoration: const InputDecoration(labelText: 'Primary Crop', isDense: true),
            onChanged: (val) => _cropHistoryList[i] = CropHistory(year: entry.year, cropName: val, season: entry.season, secondaryCrop: entry.secondaryCrop, yieldStr: entry.yieldStr),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: entry.secondaryCrop,
                  decoration: const InputDecoration(labelText: 'Secondary Crop (Optional)', isDense: true),
                  onChanged: (val) => _cropHistoryList[i] = CropHistory(year: entry.year, cropName: entry.cropName, season: entry.season, secondaryCrop: val, yieldStr: entry.yieldStr),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  initialValue: entry.yieldStr,
                  decoration: const InputDecoration(labelText: 'Yield', isDense: true),
                  onChanged: (val) => _cropHistoryList[i] = CropHistory(year: entry.year, cropName: entry.cropName, season: entry.season, secondaryCrop: entry.secondaryCrop, yieldStr: val),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: () => setState(() => _cropHistoryList.removeAt(i)),
            ),
          )
        ]);
      }),
    );
  }

  Widget _buildAddHistoryBtn() {
    return GestureDetector(
      onTap: _addCropHistory,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: const Color(0xFF1B5E20), borderRadius: BorderRadius.circular(20)),
        child: const Row(
          children: [
            Icon(Icons.add, color: Colors.white, size: 14),
            SizedBox(width: 4),
            Text('Add History', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Helper UI methods unchanged below this line
  Widget _buildAvatarSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white, border: Border.all(color: const Color(0xFF1B5E20), width: 3),
                  image: _profileImage != null ? DecorationImage(image: FileImage(_profileImage!), fit: BoxFit.cover) : null,
                ),
                child: _profileImage == null ? Center(child: Text(_avatars[_selectedAvatarIndex], style: const TextStyle(fontSize: 40))) : null,
              ),
              Positioned(
                bottom: 0, right: 0,
                child: GestureDetector(
                  onTap: _pickProfileImage,
                  child: Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Color(0xFF1B5E20), shape: BoxShape.circle), child: const Icon(Icons.camera_alt, color: Colors.white, size: 18)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_profileImage == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_avatars.length, (i) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedAvatarIndex = i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4), padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: _selectedAvatarIndex == i ? const Color(0xFF1B5E20).withOpacity(0.1) : Colors.transparent, shape: BoxShape.circle),
                    child: Text(_avatars[i], style: const TextStyle(fontSize: 24)),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {Widget? action}) {
    return Padding(padding: const EdgeInsets.only(left: 4, bottom: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1B5E20))), if (action != null) action]));
  }

  Widget _buildLocationBtn() {
    return GestureDetector(
      onTap: _getCurrentLocation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: const Color(0xFF1B5E20), borderRadius: BorderRadius.circular(20)),
        child: Row(children: [_isLoadingLocation ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Icon(Icons.my_location, color: Colors.white, size: 14), const SizedBox(width: 6), const Text('Use Current Location', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))]),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))]), child: Column(children: children));
  }

  Widget _buildField(TextEditingController ctrl, String label, IconData icon, {TextInputType type = TextInputType.text, bool obscure = false, bool isDate = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: ctrl, keyboardType: type, obscureText: obscure, readOnly: isDate,
        onTap: isDate ? () async {
          final date = await showDatePicker(context: context, initialDate: DateTime(1990), firstDate: DateTime(1900), lastDate: DateTime.now());
          if (date != null) ctrl.text = '${date.day}/${date.month}/${date.year}';
        } : null,
        decoration: InputDecoration(
          labelText: label, labelStyle: const TextStyle(fontSize: 13, color: Colors.grey),
          prefixIcon: Icon(icon, color: const Color(0xFF1B5E20), size: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1B5E20))),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, IconData icon, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value, items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(), onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label, labelStyle: const TextStyle(fontSize: 13, color: Colors.grey),
          prefixIcon: Icon(icon, color: const Color(0xFF1B5E20), size: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
