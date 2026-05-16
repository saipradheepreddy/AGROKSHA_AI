/// AGROKSHA AI — Crop Disease Photo Diagnosis v2



/// Structured output: Plant → Disease → Cause → Solution + Certified Pesticides



library;







import 'dart:convert';



import 'dart:io';



import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import 'package:http/http.dart' as http;



import 'package:image_picker/image_picker.dart';



import 'package:provider/provider.dart';



import '../models/models.dart';



import '../theme/app_theme.dart';



import '../utils/app_provider.dart';



import '../services/voice_service.dart';



import '../services/ai_service.dart';







// ── Structured diagnosis model ────────────────────────────────────────────────



class _DiseaseReport {



  final String plantName;



  final String scientificName;



  final String diseaseName;



  final String causedBy;



  final String symptoms;



  final String solution;



  final List<String> pesticides;



  final List<String> organicRemedies;



  final double confidence;







  const _DiseaseReport({



    required this.plantName,



    required this.scientificName,



    required this.diseaseName,



    required this.causedBy,



    required this.symptoms,



    required this.solution,



    required this.pesticides,



    required this.organicRemedies,



    required this.confidence,



  });



}







class DiseaseDiagnosisScreen extends StatefulWidget {



  const DiseaseDiagnosisScreen({super.key});



  @override



  State<DiseaseDiagnosisScreen> createState() => _DiseaseDiagnosisScreenState();



}







class _DiseaseDiagnosisScreenState extends State<DiseaseDiagnosisScreen> {



  File? _image;



  bool _loading = false;



  bool _loadingAi = false;



  String? _error;



  String? _rawPlantName;



  String? _rawScientific;



  double _confidence = 0;



  _DiseaseReport? _report;







  static const _plantNetKey = '2b10jWbTprx0MgLuIhL74KRjO';



  final _picker = ImagePicker();







  // ── Step 1: Pick image ────────────────────────────────────────────────────



  Future<void> _pick(ImageSource src) async {



    final f = await _picker.pickImage(source: src, imageQuality: 80, maxWidth: 1024);



    if (f == null) return;



    setState(() { _image = File(f.path); _report = null; _error = null; _rawPlantName = null; });



    await _identifyPlant(File(f.path));



  }







  // ── Step 2: PlantNet identification ───────────────────────────────────────



  Future<void> _identifyPlant(File img) async {



    setState(() => _loading = true);



    try {



      final uri = Uri.parse(



        'https://my-api.plantnet.org/v2/identify/all?api-key=$_plantNetKey&lang=en&include-related-images=false',



      );



      final req = http.MultipartRequest('POST', uri);



      req.files.add(await http.MultipartFile.fromPath('images', img.path));



      req.fields['organs'] = 'leaf';







      final streamed = await req.send().timeout(const Duration(seconds: 30));



      final body = await streamed.stream.bytesToString();







      if (streamed.statusCode == 404) {



        // Not recognized — still run AI with unknown plant



        setState(() { _loading = false; _rawPlantName = null; _rawScientific = null; _confidence = 0; });



        await _getStructuredDiagnosis(null, null, 0);



        return;



      }



      if (streamed.statusCode != 200) throw Exception('PlantNet HTTP ${streamed.statusCode}');







      final data = jsonDecode(body);



      final results = (data['results'] as List? ?? []);



      if (results.isEmpty) throw Exception('No results');







      final top = results.first;



      final species = top['species'];



      final scientific = species['scientificNameWithoutAuthor']?.toString() ?? 'Unknown';



      final commonNames = (species['commonNames'] as List? ?? []);



      final common = commonNames.isNotEmpty ? commonNames.first.toString() : scientific;



      final score = (top['score'] as num?)?.toDouble() ?? 0.0;







      setState(() { _rawPlantName = common; _rawScientific = scientific; _confidence = score; _loading = false; });



      await _getStructuredDiagnosis(common, scientific, score);



    } catch (e) {



      setState(() { _loading = false; _error = 'Cannot analyze photo.\nCheck internet and try again.\n$e'; });



    }



  }







  // ── Step 3: Groq structured diagnosis ─────────────────────────────────────



  Future<void> _getStructuredDiagnosis(String? common, String? scientific, double conf) async {



    final provider = context.read<AppProvider>();



    final isTe = provider.language == AppLanguage.telugu;



    setState(() => _loadingAi = true);







    final plantInfo = common != null



        ? 'Plant identified: $common ($scientific), confidence: ${(conf * 100).toInt()}%'



        : 'Plant NOT identified from photo. Analyze as unknown crop disease.';







    final prompt = '''



You are an expert Indian agricultural plant disease diagnostician.



$plantInfo







Farmer uploaded a photo of a diseased plant leaf/fruit.



${isTe ? "Respond in Telugu language." : "Respond in English."}







Provide EXACTLY this structured response (use these exact section labels):







PLANT NAME: [Common name in ${isTe ? "Telugu" : "English"}]



DISEASE NAME: [Most likely disease name]



CAUSED BY: [Pathogen type — Fungus/Bacteria/Virus/Insect/Deficiency — and exact name]



SYMPTOMS: [2-3 key visible symptoms the farmer should look for]



SOLUTION: [Step-by-step treatment — what to do today, tomorrow, next week]



CERTIFIED PESTICIDES: [List 3-4 real certified pesticides available in India with exact dose, e.g. "Mancozeb 75% WP — 2.5g per litre water, spray 3 times at 10-day intervals"]



ORGANIC REMEDY: [1-2 organic/natural alternatives like neem oil, copper sulphate, etc.]







Rules:



- Give DIRECT actionable advice. NO "consult officer" or vague suggestions.



- Only mention pesticides approved by CIB&RC India (Central Insecticides Board).



- Be specific about dose, timing, frequency.



- Keep each section concise but complete.



''';







    try {



      final raw = await AIService.chat(



        userMessage: prompt,



        language: provider.language,



        weather: provider.weather,



        location: provider.farmerLocation,



        currentCrop: common ?? 'unknown crop',



        marketData: [],



        farmerName: provider.currentUser?.name,



      );







      final report = _parseReport(raw, common, scientific ?? '', conf);



      if (mounted) setState(() { _report = report; _loadingAi = false; });



    } catch (e) {



      if (mounted) setState(() => _loadingAi = false);



    }



  }







  // ── Parse AI structured response ──────────────────────────────────────────



  _DiseaseReport _parseReport(String raw, String? common, String scientific, double conf) {



    String extract(String label) {



      final patterns = [



        RegExp('$label:\\s*(.+?)(?=\\n[A-Z ]+:|\\Z)', dotAll: true, caseSensitive: false),



        RegExp('\\*\\*$label:\\*\\*\\s*(.+?)(?=\\n\\*\\*|\\Z)', dotAll: true, caseSensitive: false),



      ];



      for (final p in patterns) {



        final m = p.firstMatch(raw);



        if (m != null) return m.group(1)?.trim() ?? '';



      }



      return '';



    }







    List<String> extractList(String label) {



      final block = extract(label);



      if (block.isEmpty) return [];



      return block.split('\n')



          .map((l) => l.replaceAll(RegExp(r'^[-•*\d.)\s]+'), '').trim())



          .where((l) => l.isNotEmpty)



          .toList();



    }







    return _DiseaseReport(



      plantName: extract('PLANT NAME').isNotEmpty ? extract('PLANT NAME') : (common ?? 'Unknown Plant'),



      scientificName: scientific,



      diseaseName: extract('DISEASE NAME').isNotEmpty ? extract('DISEASE NAME') : 'Disease analysis complete',



      causedBy: extract('CAUSED BY').isNotEmpty ? extract('CAUSED BY') : 'See solution below',



      symptoms: extract('SYMPTOMS').isNotEmpty ? extract('SYMPTOMS') : 'See photo analysis',



      solution: extract('SOLUTION').isNotEmpty ? extract('SOLUTION') : raw,



      pesticides: extractList('CERTIFIED PESTICIDES').isNotEmpty



          ? extractList('CERTIFIED PESTICIDES')



          : extractList('PESTICIDES'),



      organicRemedies: extractList('ORGANIC REMEDY').isNotEmpty



          ? extractList('ORGANIC REMEDY')



          : extractList('ORGANIC'),



      confidence: conf,



    );



  }







  @override



  Widget build(BuildContext context) {



    final provider = context.watch<AppProvider>();



    final isDark = Theme.of(context).brightness == Brightness.dark;



    final isTe = provider.language == AppLanguage.telugu;







    return Scaffold(



      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,



      appBar: AppBar(



        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



          Text(isTe ? '📸 పంట వ్యాధి నిర్ధారణ' : '📸 Crop Disease Diagnosis',



              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),



          Text(isTe ? 'ఆకు ఫోటో తీసి వ్యాధి తెలుసుకోండి' : 'Photo → Disease → Treatment',



              style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.75))),



        ]),



        backgroundColor: AppColors.primary,



        foregroundColor: Colors.white,



        elevation: 0,



      ),



      body: SingleChildScrollView(



        padding: const EdgeInsets.all(16),



        child: Column(children: [







          // ── Instruction banner ──────────────────────────────────────────



          Container(



            padding: const EdgeInsets.all(14),



            decoration: BoxDecoration(



              color: AppColors.primarySurface,



              borderRadius: BorderRadius.circular(14),



              border: Border.all(color: AppColors.primary.withOpacity(0.2)),



            ),



            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



              Text(isTe ? '📷 ఎలా వాడాలి:' : '📷 How to use:',



                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary)),



              const SizedBox(height: 6),



              _step('1', isTe ? 'అనారోగ్యకర ఆకు లేదా కాయ ఫోటో తీయండి' : 'Take a clear photo of the sick leaf or fruit'),



              _step('2', isTe ? 'దగ్గరగా తీయండి — వ్యాధి మచ్చలు స్పష్టంగా కనపడాలి' : 'Take close-up — disease spots must be clearly visible'),



              _step('3', isTe ? 'మొక్క పేరు, వ్యాధి పేరు, కారణం, పరిష్కారం చూపిస్తాం' : 'App shows: Plant, Disease, Cause, Complete Treatment'),



            ]),



          ).animate().fadeIn(duration: 300.ms),



          const SizedBox(height: 16),







          // ── Buttons ─────────────────────────────────────────────────────



          Row(children: [



            Expanded(child: _BigBtn(icon: Icons.camera_alt_rounded,



              label: isTe ? '📷 ఫోటో తీయండి' : '📷 Take Photo',



              color: AppColors.primary, onTap: () => _pick(ImageSource.camera))),



            const SizedBox(width: 12),



            Expanded(child: _BigBtn(icon: Icons.photo_library_rounded,



              label: isTe ? '🖼️ గ్యాలరీ నుండి' : '🖼️ From Gallery',



              color: const Color(0xFF6A1B9A), onTap: () => _pick(ImageSource.gallery))),



          ]).animate().fadeIn(delay: 100.ms),



          const SizedBox(height: 16),







          // ── Image preview ────────────────────────────────────────────────



          if (_image != null) ...[



            ClipRRect(



              borderRadius: BorderRadius.circular(18),



              child: Image.file(_image!, height: 200, width: double.infinity, fit: BoxFit.cover),



            ).animate().fadeIn(duration: 350.ms),



            const SizedBox(height: 14),



          ],







          // ── Loading states ───────────────────────────────────────────────



          if (_loading) _loadingCard(isTe ? '🔍 మొక్కను గుర్తిస్తున్నాం...' : '🔍 Identifying plant...'),



          if (_loadingAi) _loadingCard(isTe ? '🤖 వ్యాధి విశ్లేషిస్తున్నాం...' : '🤖 Analyzing disease...'),







          // ── Error ────────────────────────────────────────────────────────



          if (_error != null)



            Container(



              padding: const EdgeInsets.all(14),



              decoration: BoxDecoration(color: AppColors.riskHigh.withOpacity(0.08),



                  borderRadius: BorderRadius.circular(12),



                  border: Border.all(color: AppColors.riskHigh.withOpacity(0.3))),



              child: Text(_error!, style: const TextStyle(color: AppColors.riskHigh, fontSize: 13)),



            ),







          // ── Structured Report ─────────────────────────────────────────────



          if (_report != null) ...[



            const SizedBox(height: 4),



            _ReportCard(report: _report!, isDark: isDark, isTe: isTe,



              onSpeak: () => VoiceService().speak(



                '${_report!.plantName}. ${_report!.diseaseName}. ${_report!.causedBy}. ${_report!.solution}',



                language: provider.language, speed: provider.voiceSpeed,



              ),



            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.08),



          ],







          const SizedBox(height: 32),



        ]),



      ),



    );



  }







  Widget _loadingCard(String msg) => Padding(



    padding: const EdgeInsets.only(bottom: 14),



    child: Row(children: [



      const SizedBox(width: 20, height: 20,



          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary)),



      const SizedBox(width: 12),



      Text(msg, style: const TextStyle(color: AppColors.textLight, fontSize: 13)),



    ]),



  );







  Widget _step(String n, String txt) => Padding(



    padding: const EdgeInsets.only(bottom: 4),



    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [



      Container(width: 18, height: 18,



          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),



          child: Center(child: Text(n, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)))),



      const SizedBox(width: 8),



      Expanded(child: Text(txt, style: const TextStyle(fontSize: 12, color: AppColors.textMedium, height: 1.4))),



    ]),



  );



}







// ── Big button ────────────────────────────────────────────────────────────────



class _BigBtn extends StatelessWidget {



  final IconData icon; final String label; final Color color; final VoidCallback onTap;



  const _BigBtn({required this.icon, required this.label, required this.color, required this.onTap});



  @override



  Widget build(BuildContext context) => GestureDetector(



    onTap: onTap,



    child: Container(



      padding: const EdgeInsets.symmetric(vertical: 18),



      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16),



          boxShadow: [BoxShadow(color: color.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 4))]),



      child: Column(children: [



        Icon(icon, color: Colors.white, size: 28),



        const SizedBox(height: 6),



        Text(label, textAlign: TextAlign.center,



            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),



      ]),



    ),



  );



}







// ── Full structured report card ───────────────────────────────────────────────



class _ReportCard extends StatelessWidget {



  final _DiseaseReport report;



  final bool isDark, isTe;



  final VoidCallback onSpeak;



  const _ReportCard({required this.report, required this.isDark, required this.isTe, required this.onSpeak});







  @override



  Widget build(BuildContext context) {



    final confColor = report.confidence >= 0.7 ? AppColors.riskLow



        : report.confidence >= 0.4 ? AppColors.riskMedium : AppColors.riskHigh;







    return Column(children: [



      // ── Plant ID header ──────────────────────────────────────────────────



      Container(



        padding: const EdgeInsets.all(14),



        decoration: BoxDecoration(



          gradient: const LinearGradient(



              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],



              begin: Alignment.topLeft, end: Alignment.bottomRight),



          borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),



        ),



        child: Row(children: [



          const Text('🌿', style: TextStyle(fontSize: 26)),



          const SizedBox(width: 12),



          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



            Text(report.plantName,



                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),



            if (report.scientificName.isNotEmpty)



              Text(report.scientificName,



                  style: const TextStyle(color: Colors.white70, fontSize: 11, fontStyle: FontStyle.italic)),



          ])),



          if (report.confidence > 0)



            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [



              Text('${(report.confidence * 100).toInt()}%',



                  style: TextStyle(color: confColor == AppColors.riskLow ? Colors.greenAccent : Colors.orangeAccent,



                      fontSize: 16, fontWeight: FontWeight.w800)),



              Text(isTe ? 'ఖచ్చితత్వం' : 'confidence',



                  style: const TextStyle(color: Colors.white60, fontSize: 10)),



            ]),



          const SizedBox(width: 8),



          GestureDetector(



            onTap: onSpeak,



            child: Container(



              padding: const EdgeInsets.all(8),



              decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),



              child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 18),



            ),



          ),



        ]),



      ),







      // ── Disease name ─────────────────────────────────────────────────────



      _Section(



        color: AppColors.riskHigh, icon: Icons.coronavirus_rounded,



        title: isTe ? 'వ్యాధి పేరు' : 'Disease Name',



        content: report.diseaseName, isDark: isDark,



      ),







      // ── Caused by ────────────────────────────────────────────────────────



      _Section(



        color: const Color(0xFFE65100), icon: Icons.bug_report_rounded,



        title: isTe ? 'కారణం' : 'Caused By',



        content: report.causedBy, isDark: isDark,



      ),







      // ── Symptoms ─────────────────────────────────────────────────────────



      _Section(



        color: AppColors.riskMedium, icon: Icons.visibility_rounded,



        title: isTe ? 'లక్షణాలు' : 'Symptoms',



        content: report.symptoms, isDark: isDark,



      ),







      // ── Solution ─────────────────────────────────────────────────────────



      _Section(



        color: AppColors.riskLow, icon: Icons.healing_rounded,



        title: isTe ? 'పరిష్కారం (దశలవారీగా)' : 'Solution (Step by Step)',



        content: report.solution, isDark: isDark,



      ),







      // ── Certified pesticides ─────────────────────────────────────────────



      if (report.pesticides.isNotEmpty)



        _ListSection(



          color: const Color(0xFF1A237E), icon: Icons.science_rounded,



          title: isTe ? '🧪 సర్టిఫైడ్ పురుగుమందులు (CIB&RC Approved)' : '🧪 Certified Pesticides (CIB&RC Approved)',



          items: report.pesticides, isDark: isDark,



        ),







      // ── Organic remedies ─────────────────────────────────────────────────



      if (report.organicRemedies.isNotEmpty)



        _ListSection(



          color: const Color(0xFF33691E), icon: Icons.eco_rounded,



          title: isTe ? '🌿 సేంద్రియ పరిష్కారాలు' : '🌿 Organic Remedies',



          items: report.organicRemedies, isDark: isDark,



          isLast: true,



        ),



    ]);



  }



}







// ── Section widget ────────────────────────────────────────────────────────────



class _Section extends StatelessWidget {



  final Color color; final IconData icon;



  final String title, content; final bool isDark;



  const _Section({required this.color, required this.icon, required this.title, required this.content, required this.isDark});







  @override



  Widget build(BuildContext context) => Container(



    margin: const EdgeInsets.only(top: 2),



    padding: const EdgeInsets.all(14),



    decoration: BoxDecoration(



      color: isDark ? AppColors.darkCard : Colors.white,



      border: Border(left: BorderSide(color: color, width: 4)),



    ),



    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [



      Icon(icon, color: color, size: 20),



      const SizedBox(width: 10),



      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



        Text(title, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w800)),



        const SizedBox(height: 4),



        Text(content, style: const TextStyle(fontSize: 13, height: 1.5)),



      ])),



    ]),



  );



}







// ── List section (pesticides / organic) ──────────────────────────────────────



class _ListSection extends StatelessWidget {



  final Color color; final IconData icon;



  final String title; final List<String> items;



  final bool isDark; final bool isLast;



  const _ListSection({required this.color, required this.icon,



      required this.title, required this.items, required this.isDark, this.isLast = false});







  @override



  Widget build(BuildContext context) => Container(



    margin: EdgeInsets.only(top: 2, bottom: isLast ? 0 : 0),



    padding: const EdgeInsets.all(14),



    decoration: BoxDecoration(



      color: isDark ? AppColors.darkCard : Colors.white,



      border: Border(left: BorderSide(color: color, width: 4)),



      borderRadius: isLast ? const BorderRadius.only(



          bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)) : null,



    ),



    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



      Row(children: [



        Icon(icon, color: color, size: 18),



        const SizedBox(width: 8),



        Expanded(child: Text(title, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w800))),



      ]),



      const SizedBox(height: 8),



      ...items.map((item) => Padding(



        padding: const EdgeInsets.only(bottom: 6),



        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [



          Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 5, right: 8),



              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),



          Expanded(child: Text(item, style: const TextStyle(fontSize: 12, height: 1.4))),



        ]),



      )),



    ]),



  );



}


















