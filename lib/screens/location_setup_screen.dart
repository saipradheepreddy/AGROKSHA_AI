/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Location Setup Screen



/// Step-by-step selector: State → District → Mandal → Village



/// Saves to SharedPreferences and restores on next launch



/// ─────────────────────────────────────────────────────────────────────────────







import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import 'package:provider/provider.dart';



import '../theme/app_theme.dart';



import '../utils/app_provider.dart';



import '../models/models.dart';



import '../data/location_data.dart';



import '../widgets/widgets.dart';
import '../widgets/location_permission_dialog.dart';



import 'home_screen.dart';



import 'login_screen.dart';



import '../services/voice_service.dart';



import 'package:geolocator/geolocator.dart';



import 'package:geocoding/geocoding.dart';







class LocationSetupScreen extends StatefulWidget {



  final bool isFirstLaunch;







  const LocationSetupScreen({super.key, this.isFirstLaunch = false});







  @override



  State<LocationSetupScreen> createState() => _LocationSetupScreenState();



}







class _LocationSetupScreenState extends State<LocationSetupScreen> {



  String? _selectedState;



  DistrictInfo? _selectedDistrict;



  String? _selectedMandal;



  final TextEditingController _villageController = TextEditingController();



  bool _isSaving = false;



  bool _isDetecting = false;







  @override



  void initState() {



    super.initState();



    if (widget.isFirstLaunch) {



      WidgetsBinding.instance.addPostFrameCallback((_) {



        final provider = context.read<AppProvider>();



        _autoDetectLocation();



      });



    }



  }







  Future<void> _autoDetectLocation() async {



    setState(() => _isDetecting = true);



    try {



      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();



      if (!serviceEnabled) throw 'Location services are disabled. Enable in Settings.';







      LocationPermission permission = await Geolocator.checkPermission();



      if (permission == LocationPermission.denied) {



        final shouldRequest = await LocationPermissionDialog.show(context);
        if (!shouldRequest) {
          setState(() => _isDetecting = false);
          return;
        }
        permission = await Geolocator.requestPermission();



        if (permission == LocationPermission.denied) throw 'Location permission denied.';



      }



      if (permission == LocationPermission.deniedForever) {



        throw 'Location permission permanently denied. Enable in phone Settings.';



      }







      // HIGH accuracy for getting sub-district level



      Position pos = await Geolocator.getCurrentPosition(



        desiredAccuracy: LocationAccuracy.high,



      );



      List<Placemark> placemarks = await placemarkFromCoordinates(



        pos.latitude, pos.longitude,



      );







      if (placemarks.isEmpty) throw 'No address found for your location.';







      final p = placemarks.first;







      // ── 1. STATE ──────────────────────────────────────────────────────────



      String? detectedState;



      final adminArea = p.administrativeArea ?? '';



      for (final s in LocationData.states) {



        if (s.toLowerCase() == adminArea.toLowerCase() ||



            adminArea.toLowerCase().contains(s.toLowerCase()) ||



            s.toLowerCase().contains(adminArea.toLowerCase())) {



          detectedState = s;



          break;



        }



      }







      // ── 2. DISTRICT ───────────────────────────────────────────────────────



      DistrictInfo? detectedDistrict;



      final subAdmin = p.subAdministrativeArea ?? p.locality ?? '';



      if (detectedState != null && subAdmin.isNotEmpty) {



        final districts = LocationData.getDistricts(detectedState);



        for (final d in districts) {



          if (d.name.toLowerCase() == subAdmin.toLowerCase() ||



              subAdmin.toLowerCase().contains(d.name.toLowerCase()) ||



              d.name.toLowerCase().contains(subAdmin.toLowerCase())) {



            detectedDistrict = d;



            break;



          }



        }



        // If no exact match, try first word



        if (detectedDistrict == null && subAdmin.isNotEmpty) {



          final firstWord = subAdmin.split(' ').first.toLowerCase();



          for (final d in districts) {



            if (d.name.toLowerCase().startsWith(firstWord)) {



              detectedDistrict = d;



              break;



            }



          }



        }



      }







      // ── 3. MANDAL ─────────────────────────────────────────────────────────



      String? detectedMandal;



      final locality = p.locality ?? p.subLocality ?? '';



      if (detectedDistrict != null && locality.isNotEmpty) {



        for (final m in detectedDistrict.mandals) {



          if (m.toLowerCase() == locality.toLowerCase() ||



              locality.toLowerCase().contains(m.toLowerCase()) ||



              m.toLowerCase().contains(locality.toLowerCase())) {



            detectedMandal = m;



            break;



          }



        }



        if (detectedMandal == null && locality.isNotEmpty) {



          final firstWord = locality.split(' ').first.toLowerCase();



          for (final m in detectedDistrict.mandals) {



            if (m.toLowerCase().startsWith(firstWord)) {



              detectedMandal = m;



              break;



            }



          }



        }



      }







      // ── 4. VILLAGE (optional) ─────────────────────────────────────────────



      final village = p.subLocality?.isNotEmpty == true



          ? p.subLocality!



          : p.thoroughfare?.isNotEmpty == true



              ? p.thoroughfare!



              : '';







      setState(() {



        if (detectedState != null) _selectedState = detectedState;



        if (detectedDistrict != null) {



          _selectedDistrict = detectedDistrict;



        } else if (detectedState != null && _selectedDistrict == null) {



          _selectedDistrict = null; // keep null — user must pick



        }



        if (detectedMandal != null) _selectedMandal = detectedMandal;



        if (village.isNotEmpty) _villageController.text = village;



      });







      if (mounted) {



        final detected = [



          if (detectedState != null) detectedState,



          if (detectedDistrict != null) detectedDistrict!.name,



          if (detectedMandal != null) detectedMandal,



        ].join(', ');



        ScaffoldMessenger.of(context).showSnackBar(SnackBar(



          content: Text('📍 Detected: $detected${detectedDistrict == null ? " — Please select district manually" : ""}'),



          backgroundColor: AppColors.primary,



          duration: const Duration(seconds: 4),



        ));



      }



    } catch (e) {



      if (mounted) {



        ScaffoldMessenger.of(context).showSnackBar(SnackBar(



          content: Text('Auto-detect failed: $e'),



          backgroundColor: AppColors.riskHigh,



        ));



      }



    } finally {



      if (mounted) setState(() => _isDetecting = false);



    }



  }







  // Build dropdown items for states



  List<DropdownMenuItem<String>> get _stateItems =>



      LocationData.states.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList();







  // Build dropdown items for districts of selected state



  List<DropdownMenuItem<DistrictInfo>> get _districtItems {



    if (_selectedState == null) return [];



    return LocationData.getDistricts(_selectedState!).map((d) {



      return DropdownMenuItem(value: d, child: Text(d.name));



    }).toList();



  }







  // Build dropdown items for mandals of selected district



  List<DropdownMenuItem<String>> get _mandalItems {



    if (_selectedDistrict == null) return [];



    return _selectedDistrict!.mandals.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList();



  }







  bool get _canSave =>



      _selectedState != null &&



      _selectedDistrict != null &&



      _selectedMandal != null;



      // Village is OPTIONAL — farmer can save without it







  Future<void> _saveLocation() async {



    if (!_canSave) return;



    setState(() => _isSaving = true);







    final provider = context.read<AppProvider>();



    final loc = FarmerLocation(



      state: _selectedState!,



      district: _selectedDistrict!.name,



      mandal: _selectedMandal!,



      village: _villageController.text.trim().isEmpty ? null : _villageController.text.trim(),



      lat: _selectedDistrict!.lat,



      lon: _selectedDistrict!.lon,



    );







    await provider.saveLocation(loc);







    if (!mounted) return;







    ScaffoldMessenger.of(context).showSnackBar(



      SnackBar(



        content: Text('✅ Location saved: ${loc.village}, ${loc.district}'),



        backgroundColor: AppColors.primary,



      ),



    );







    // Navigate to HomeScreen



    Navigator.of(context).pushAndRemoveUntil(



      MaterialPageRoute(builder: (_) => HomeScreen()),



      (route) => false,



    );



  }







  @override



  void dispose() {



    _villageController.dispose();



    super.dispose();



  }







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;



    final provider = context.watch<AppProvider>();



    final lang = provider.langCode;







    return Scaffold(



      body: Container(



        decoration: const BoxDecoration(gradient: AppColors.heroGradient),



        child: SafeArea(



          child: Column(



            children: [



              // Back button (not on first launch)



              if (!widget.isFirstLaunch)



                Padding(



                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),



                  child: Row(



                    children: [



                      GestureDetector(



                        onTap: () => Navigator.pop(context),



                        child: Container(



                          padding: const EdgeInsets.all(10),



                          decoration: BoxDecoration(



                            color: Colors.white.withValues(alpha: 0.15),



                            borderRadius: BorderRadius.circular(12),



                          ),



                          child: const Icon(Icons.arrow_back_rounded, color: Colors.white),



                        ),



                      ),



                    ],



                  ),



                ),







              // Header



              Padding(



                padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),



                child: Column(



                  crossAxisAlignment: CrossAxisAlignment.start,



                  children: [



                    const Text('📍', style: TextStyle(fontSize: 44))



                        .animate().scale(duration: 600.ms, curve: Curves.easeOutBack),



                    const SizedBox(height: 16),



                    Text(



                      translate(S.locationSetupTitle, lang),



                      style: const TextStyle(



                        color: Colors.white,



                        fontSize: 26,



                        fontWeight: FontWeight.w800,



                      ),



                    ).animate(delay: 200.ms).fadeIn().slideX(begin: -0.3),



                    const SizedBox(height: 8),



                    Text(



                      translate(S.locationSetupSub, lang),



                      style: TextStyle(



                        color: Colors.white.withValues(alpha: 0.75),



                        fontSize: 14,



                        height: 1.5,



                      ),



                    ).animate(delay: 300.ms).fadeIn(),



                  ],



                ),



              ),







              // White card with selectors



              Expanded(



                child: Container(



                  decoration: BoxDecoration(



                    color: isDark ? AppColors.darkBackground : Colors.white,



                    borderRadius: const BorderRadius.only(



                      topLeft: Radius.circular(32),



                      topRight: Radius.circular(32),



                    ),



                    boxShadow: [



                      BoxShadow(



                        color: Colors.black.withValues(alpha: 0.1),



                        blurRadius: 20,



                        offset: const Offset(0, -5),



                      ),



                    ],



                  ),



                  child: SingleChildScrollView(



                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),



                    child: Column(



                      crossAxisAlignment: CrossAxisAlignment.start,



                      children: [



                        // Auto Detect Button



                        if (widget.isFirstLaunch) ...[



                          GradientButton(



                            label: _isDetecting ? 'Detecting Location...' : 'Detect Automatically',



                            icon: Icons.my_location_rounded,



                            isLoading: _isDetecting,



                            onPressed: _autoDetectLocation,



                          ),



                          const SizedBox(height: 20),



                          Row(



                            children: [



                              const Expanded(child: Divider()),



                              Padding(



                                padding: const EdgeInsets.symmetric(horizontal: 12),



                                child: Text('OR ENTER MANUALLY', style: TextStyle(color: AppColors.textLight, fontSize: 12, fontWeight: FontWeight.w600)),



                              ),



                              const Expanded(child: Divider()),



                            ],



                          ),



                          const SizedBox(height: 24),



                        ],



                        // Step indicator



                        _StepIndicator(



                          steps: const ['State', 'District', 'Mandal', 'Village'],



                          currentStep: _currentStep,



                        ),



                        const SizedBox(height: 28),







                        // State dropdown



                        AgriDropdown<String>(



                          label: translate(S.selectState, lang),



                          hint: translate(S.selectState, lang),



                          value: _selectedState,



                          prefixIcon: Icons.map_rounded,



                          items: _stateItems,



                          onChanged: (v) => setState(() {



                            _selectedState = v;



                            _selectedDistrict = null;



                            _selectedMandal = null;



                          }),



                        ),



                        const SizedBox(height: 20),







                        // District dropdown



                        AgriDropdown<DistrictInfo>(



                          label: translate(S.selectDistrict, lang),



                          hint: translate(S.selectDistrict, lang),



                          value: _selectedDistrict,



                          prefixIcon: Icons.location_city_rounded,



                          items: _districtItems,



                          onChanged: (v) {



                            if (_selectedState == null) return;



                            setState(() {



                              _selectedDistrict = v;



                              _selectedMandal = null;



                            });



                          },



                        ),



                        const SizedBox(height: 20),







                        // Mandal dropdown



                        AgriDropdown<String>(



                          label: translate(S.selectMandal, lang),



                          hint: translate(S.selectMandal, lang),



                          value: _selectedMandal,



                          prefixIcon: Icons.account_balance_rounded,



                          items: _mandalItems,



                          onChanged: (v) {



                            if (_selectedDistrict == null) return;



                            setState(() => _selectedMandal = v);



                          },



                        ),



                        const SizedBox(height: 20),







                        // Village text field



                        Text(



                          translate(S.village, lang),



                          style: TextStyle(



                            fontSize: 13,



                            fontWeight: FontWeight.w600,



                            color: isDark ? AppColors.darkTextMedium : AppColors.textMedium,



                          ),



                        ),



                        const SizedBox(height: 8),



                        TextField(



                          controller: _villageController,



                          onChanged: (_) => setState(() {}),



                          decoration: InputDecoration(



                            hintText: translate(S.enterVillage, lang),



                            prefixIcon: const Icon(Icons.home_rounded, color: AppColors.primary),



                          ),



                        ),



                        const SizedBox(height: 32),







                        // Save button



                        GradientButton(



                          label: translate(S.saveLocation, lang),



                          icon: Icons.save_rounded,



                          isLoading: _isSaving,



                          onPressed: _canSave ? _saveLocation : null,



                        ),







                        // Location preview



                        if (_selectedState != null) ...[



                          const SizedBox(height: 20),



                          _LocationPreview(



                            state: _selectedState!,



                            district: _selectedDistrict?.name,



                            mandal: _selectedMandal,



                            village: _villageController.text.trim().isEmpty



                                ? null



                                : _villageController.text.trim(),



                          ),



                        ],



                      ],



                    ),



                  ),



                ),



              ),



            ],



          ),



        ),



      ),



    );



  }







  int get _currentStep {



    if (_selectedState == null) return 0;



    if (_selectedDistrict == null) return 1;



    if (_selectedMandal == null) return 2;



    return 3;



  }



}







/// Step indicator bar



class _StepIndicator extends StatelessWidget {



  final List<String> steps;



  final int currentStep;







  const _StepIndicator({required this.steps, required this.currentStep});







  @override



  Widget build(BuildContext context) {



    return Row(



      children: List.generate(steps.length, (i) {



        final isActive = i <= currentStep;



        final isLast = i == steps.length - 1;



        return Expanded(



          child: Row(



            children: [



              Column(



                crossAxisAlignment: CrossAxisAlignment.center,



                children: [



                  AnimatedContainer(



                    duration: const Duration(milliseconds: 300),



                    width: 28,



                    height: 28,



                    decoration: BoxDecoration(



                      color: isActive ? AppColors.primary : AppColors.divider,



                      shape: BoxShape.circle,



                    ),



                    child: Center(



                      child: Icon(



                        isActive ? Icons.check_rounded : null,



                        color: Colors.white,



                        size: 14,



                      ),



                    ),



                  ),



                  const SizedBox(height: 4),



                  Text(



                    steps[i],



                    style: TextStyle(



                      fontSize: 10,



                      color: isActive ? AppColors.primary : AppColors.textLight,



                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,



                    ),



                  ),



                ],



              ),



              if (!isLast)



                Expanded(



                  child: Container(



                    height: 2,



                    margin: const EdgeInsets.only(bottom: 18),



                    color: isActive ? AppColors.primary : AppColors.divider,



                  ),



                ),



            ],



          ),



        );



      }),



    );



  }



}







/// Preview card showing the assembled location



class _LocationPreview extends StatelessWidget {



  final String state;



  final String? district;



  final String? mandal;



  final String? village;







  const _LocationPreview({



    required this.state,



    this.district,



    this.mandal,



    this.village,



  });







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;



    final parts = [



      if (village != null) village!,



      if (mandal != null) mandal!,



      if (district != null) district!,



      state,



    ];







    return Container(



      padding: const EdgeInsets.all(16),



      decoration: BoxDecoration(



        color: AppColors.primarySurface,



        borderRadius: BorderRadius.circular(14),



        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),



      ),



      child: Row(



        children: [



          const Icon(Icons.location_on, color: AppColors.primary, size: 20),



          const SizedBox(width: 10),



          Expanded(



            child: Text(



              parts.join(', '),



              style: const TextStyle(



                fontSize: 13,



                fontWeight: FontWeight.w600,



                color: AppColors.primary,



              ),



            ),



          ),



        ],



      ),



    );



  }



}













