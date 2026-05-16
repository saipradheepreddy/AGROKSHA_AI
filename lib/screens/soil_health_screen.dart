/// AGROKSHA AI — Soil Health Card Reader



/// Fully offline. Farmer enters values from Govt Soil Health Card.



/// App explains in Telugu what each value means and what to do.



library;







import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import 'package:provider/provider.dart';



import '../models/models.dart';



import '../theme/app_theme.dart';



import '../utils/app_provider.dart';



import '../services/voice_service.dart';







// ── Parameter models ──────────────────────────────────────────────────────────



class _Param {



  final String key, labelEN, labelTE, unit;



  final double? min, max;



  final String hintEN, hintTE;



  const _Param({



    required this.key, required this.labelEN, required this.labelTE,



    required this.unit, required this.hintEN, required this.hintTE,



    this.min, this.max,



  });



}







const _params = [



  _Param(key: 'pH',  labelEN: 'Soil pH',        labelTE: 'pH విలువ',        unit: '',       hintEN: 'e.g. 6.5', hintTE: 'ఉదా: 6.5', min: 3, max: 10),



  _Param(key: 'N',   labelEN: 'Nitrogen (N)',    labelTE: 'నత్రజని (N)',     unit: 'kg/ha',  hintEN: 'e.g. 180', hintTE: 'ఉదా: 180', min: 0, max: 600),



  _Param(key: 'P',   labelEN: 'Phosphorus (P)',  labelTE: 'భాస్వరం (P)',     unit: 'kg/ha',  hintEN: 'e.g. 15',  hintTE: 'ఉదా: 15',  min: 0, max: 100),



  _Param(key: 'K',   labelEN: 'Potassium (K)',   labelTE: 'పొటాషియం (K)',    unit: 'kg/ha',  hintEN: 'e.g. 180', hintTE: 'ఉదా: 180', min: 0, max: 600),



  _Param(key: 'OC',  labelEN: 'Organic Carbon',  labelTE: 'సేంద్రియ కర్బనం', unit: '%',      hintEN: 'e.g. 0.5', hintTE: 'ఉదా: 0.5', min: 0, max: 5),



  _Param(key: 'EC',  labelEN: 'Electrical Cond.', labelTE: 'విద్యుత్ వాహకత', unit: 'dS/m',  hintEN: 'e.g. 0.4', hintTE: 'ఉదా: 0.4', min: 0, max: 10),



  _Param(key: 'S',   labelEN: 'Sulphur (S)',     labelTE: 'సల్ఫర్ (S)',      unit: 'ppm',    hintEN: 'e.g. 12',  hintTE: 'ఉదా: 12',  min: 0, max: 100),



  _Param(key: 'Zn',  labelEN: 'Zinc (Zn)',       labelTE: 'జింక్ (Zn)',       unit: 'ppm',    hintEN: 'e.g. 0.8', hintTE: 'ఉదా: 0.8', min: 0, max: 20),



  _Param(key: 'Fe',  labelEN: 'Iron (Fe)',        labelTE: 'ఐరన్ (Fe)',        unit: 'ppm',    hintEN: 'e.g. 4.5', hintTE: 'ఉదా: 4.5', min: 0, max: 50),



  _Param(key: 'Mn',  labelEN: 'Manganese (Mn)',   labelTE: 'మాంగనీస్ (Mn)',   unit: 'ppm',    hintEN: 'e.g. 2.0', hintTE: 'ఉదా: 2.0', min: 0, max: 30),



  _Param(key: 'Cu',  labelEN: 'Copper (Cu)',      labelTE: 'రాగి (Cu)',        unit: 'ppm',    hintEN: 'e.g. 0.2', hintTE: 'ఉదా: 0.2', min: 0, max: 10),



  _Param(key: 'B',   labelEN: 'Boron (B)',        labelTE: 'బోరాన్ (B)',       unit: 'ppm',    hintEN: 'e.g. 0.5', hintTE: 'ఉదా: 0.5', min: 0, max: 5),



];







// ── Analysis logic ────────────────────────────────────────────────────────────



class _Analysis {



  final String paramKey;



  final String status;         // 'Low' | 'Normal' | 'High'



  final String actionEN, actionTE;



  final Color color;



  final IconData icon;







  const _Analysis({



    required this.paramKey, required this.status,



    required this.actionEN, required this.actionTE,



    required this.color, required this.icon,



  });



}







List<_Analysis> _analyzeVals(Map<String, double> vals) {



  final res = <_Analysis>[];







  void add(String key, String status, String en, String te, Color c, IconData ic) =>



      res.add(_Analysis(paramKey: key, status: status, actionEN: en, actionTE: te, color: c, icon: ic));







  if (vals['pH'] != null) {



    final v = vals['pH']!;



    if (v < 5.5)      add('pH', 'Low (Acidic)',    'Apply agricultural lime (dolomite) @ 2 bags/acre to raise pH.',



                          'వ్యవసాయ సున్నం (డోలమైట్) 2 బస్తాలు/ఎకరా వేయండి - pH పెరుగుతుంది.',



                          AppColors.riskHigh, Icons.science_rounded);



    else if (v > 8.0) add('pH', 'High (Alkaline)', 'Apply Gypsum @ 2 bags/acre + FYM to reduce alkalinity.',



                          'జిప్సమ్ 2 బస్తాలు/ఎకరా + పశువుల ఎరువు వేయండి - pH తగ్గుతుంది.',



                          AppColors.riskMedium, Icons.science_rounded);



    else               add('pH', 'Normal',          'pH is ideal. No correction needed.',



                          'pH మంచిగా ఉంది. మార్పు అవసరం లేదు.',



                          AppColors.riskLow, Icons.check_circle_rounded);



  }







  if (vals['N'] != null) {



    final v = vals['N']!;



    if (v < 280)      add('N', 'Low',    'Apply Urea @ 50 kg/acre in 2 splits (at sowing and 30 days after).',



                          'యూరియా 50 కేజీ/ఎకరా - 2 దఫాలుగా వేయండి (విత్తనం వేసేటప్పుడు + 30 రోజుల తర్వాత).',



                          AppColors.riskHigh, Icons.grass_rounded);



    else if (v > 560) add('N', 'High',   'Reduce nitrogen fertilizer. Excess N causes pest attack.',



                          'నత్రజని ఎరువు తగ్గించండి. ఎక్కువైతే పురుగులు వస్తాయి.',



                          AppColors.riskMedium, Icons.grass_rounded);



    else               add('N', 'Normal', 'Nitrogen is adequate. Maintain with regular compost.',



                          'నత్రజని సరిపడా ఉంది. పశువుల ఎరువు వేయడం కొనసాగించండి.',



                          AppColors.riskLow, Icons.check_circle_rounded);



  }







  if (vals['P'] != null) {



    final v = vals['P']!;



    if (v < 10)       add('P', 'Low',    'Apply DAP @ 50 kg/acre at sowing time for phosphorus.',



                          'DAP 50 కేజీ/ఎకరా విత్తనం వేసేటప్పుడు వేయండి - భాస్వరం పెరుగుతుంది.',



                          AppColors.riskHigh, Icons.eco_rounded);



    else if (v > 50)  add('P', 'High',   'No phosphorus application needed. Save fertilizer cost.',



                          'భాస్వరం ఎరువు అవసరం లేదు. ఖర్చు తగ్గించవచ్చు.',



                          AppColors.riskMedium, Icons.eco_rounded);



    else               add('P', 'Normal', 'Phosphorus is sufficient.',



                          'భాస్వరం సరిపడా ఉంది.',



                          AppColors.riskLow, Icons.check_circle_rounded);



  }







  if (vals['K'] != null) {



    final v = vals['K']!;



    if (v < 110)      add('K', 'Low',    'Apply MOP (Muriate of Potash) @ 25 kg/acre.',



                          'MOP (పొటాష్) 25 కేజీ/ఎకరా వేయండి - పొటాషియం పెరుగుతుంది.',



                          AppColors.riskHigh, Icons.water_drop_rounded);



    else if (v > 280) add('K', 'High',   'Potassium is excess. Reduce MOP application.',



                          'పొటాషియం ఎక్కువగా ఉంది. MOP తగ్గించండి.',



                          AppColors.riskMedium, Icons.water_drop_rounded);



    else               add('K', 'Normal', 'Potassium is adequate.',



                          'పొటాషియం సరిపడా ఉంది.',



                          AppColors.riskLow, Icons.check_circle_rounded);



  }







  if (vals['OC'] != null) {



    final v = vals['OC']!;



    if (v < 0.5)      add('OC', 'Low',   'Apply FYM/compost @ 4 tonnes/acre. Add green manure crops.',



                          'పశువుల ఎరువు 4 టన్నులు/ఎకరా వేయండి. పచ్చిరొట్ట పంటలు వేయండి.',



                          AppColors.riskHigh, Icons.compost_rounded);



    else if (v > 1.5) add('OC', 'High',  'Organic carbon is good. Maintain with compost.',



                          'సేంద్రియ కర్బనం బాగుంది. కంపోస్ట్ వేయడం కొనసాగించండి.',



                          AppColors.riskLow, Icons.compost_rounded);



    else               add('OC', 'Normal','Organic carbon is adequate.',



                          'సేంద్రియ కర్బనం సరిపడా ఉంది.',



                          AppColors.riskLow, Icons.check_circle_rounded);



  }







  if (vals['Zn'] != null && vals['Zn']! < 0.6) {



    add('Zn', 'Low',   'Apply Zinc Sulphate @ 5 kg/acre as basal dose.',



        'జింక్ సల్ఫేట్ 5 కేజీ/ఎకరా బేసల్ డోస్‌గా వేయండి.',



        AppColors.riskHigh, Icons.biotech_rounded);



  }







  if (vals['S'] != null && vals['S']! < 10) {



    add('S', 'Low',    'Apply Gypsum @ 1 bag/acre or Sulphur 90% @ 3 kg/acre.',



        'జిప్సమ్ 1 బస్తా/ఎకరా లేదా సల్ఫర్ 90% 3 కేజీ/ఎకరా వేయండి.',



        AppColors.riskHigh, Icons.biotech_rounded);



  }







  return res;



}







// ── Screen ────────────────────────────────────────────────────────────────────



class SoilHealthScreen extends StatefulWidget {



  const SoilHealthScreen({super.key});



  @override



  State<SoilHealthScreen> createState() => _SoilHealthScreenState();



}







class _SoilHealthScreenState extends State<SoilHealthScreen> {



  final _controllers = <String, TextEditingController>{};



  final _vals = <String, double>{};



  List<_Analysis>? _results;



  bool _analyzed = false;







  @override



  void initState() {



    super.initState();



    for (final p in _params) {



      _controllers[p.key] = TextEditingController();



    }



  }







  @override



  void dispose() {



    for (final c in _controllers.values) c.dispose();



    super.dispose();



  }







  void _analyze() {



    _vals.clear();



    for (final p in _params) {



      final v = double.tryParse(_controllers[p.key]!.text.trim());



      if (v != null) _vals[p.key] = v;



    }



    if (_vals.isEmpty) {



      ScaffoldMessenger.of(context).showSnackBar(



        const SnackBar(content: Text('Please enter at least one value from your Soil Health Card.')),



      );



      return;



    }



    setState(() { _results = _analyzeVals(_vals); _analyzed = true; });



  }







  void _speakResults(AppLanguage lang, int speed) {



    if (_results == null || _results!.isEmpty) return;



    final isTe = lang == AppLanguage.telugu;



    final sb = StringBuffer(isTe ? 'మీ మట్టి పరీక్ష ఫలితాలు: ' : 'Your soil test results: ');



    for (final r in _results!) {



      if (isTe) {



        sb.write('${r.paramKey} ${r.status}. ${r.actionTE} ');



      } else {



        sb.write('${r.paramKey} ${r.status}. ${r.actionEN} ');



      }



    }



    VoiceService().speak(sb.toString(), language: lang, speed: speed);



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



          Text(isTe ? '🧪 మట్టి పరీక్ష కార్డు' : '🧪 Soil Health Card',



              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),



          Text(isTe ? 'మీ కార్డు నుండి విలువలు నమోదు చేయండి' : 'Enter values from your Govt Soil Card',



              style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.75))),



        ]),



        backgroundColor: AppColors.primary,



        foregroundColor: Colors.white,



        elevation: 0,



        actions: [



          if (_analyzed)



            IconButton(



              icon: const Icon(Icons.volume_up_rounded),



              onPressed: () => _speakResults(provider.language, provider.voiceSpeed),



              tooltip: 'Listen',



            ),



          IconButton(



            icon: const Icon(Icons.refresh_rounded),



            onPressed: () {



              for (final c in _controllers.values) c.clear();



              setState(() { _results = null; _analyzed = false; });



            },



            tooltip: 'Reset',



          ),



        ],



      ),



      body: SingleChildScrollView(



        padding: const EdgeInsets.all(14),



        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



          // Info banner



          Container(



            padding: const EdgeInsets.all(12),



            decoration: BoxDecoration(



              color: AppColors.primarySurface,



              borderRadius: BorderRadius.circular(12),



              border: Border.all(color: AppColors.primary.withOpacity(0.2)),



            ),



            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [



              const Text('📋', style: TextStyle(fontSize: 22)),



              const SizedBox(width: 10),



              Expanded(child: Text(



                isTe



                    ? 'మీ ప్రభుత్వ మట్టి పరీక్ష కార్డు లో ఉన్న విలువలు ఇక్కడ నమోదు చేయండి. అన్నీ నమోదు చేయనవసరం లేదు.'



                    : 'Enter values from your Government Soil Health Card. You don\'t need to fill all fields.',



                style: const TextStyle(fontSize: 12, color: AppColors.textMedium, height: 1.4),



              )),



            ]),



          ),



          const SizedBox(height: 16),







          // Input fields



          Text(isTe ? '📊 విలువలు నమోదు చేయండి' : '📊 Enter Your Values',



              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),



          const SizedBox(height: 12),



          ..._params.map((p) => _ParamField(



            param: p, controller: _controllers[p.key]!, isDark: isDark, isTe: isTe,



          )),



          const SizedBox(height: 16),







          // Analyze button



          SizedBox(width: double.infinity,



            child: ElevatedButton.icon(



              onPressed: _analyze,



              icon: const Icon(Icons.analytics_rounded, size: 20),



              label: Text(isTe ? 'విశ్లేషించండి' : 'Analyze My Soil',



                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),



              style: ElevatedButton.styleFrom(



                backgroundColor: AppColors.primary, foregroundColor: Colors.white,



                padding: const EdgeInsets.symmetric(vertical: 14),



                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),



                elevation: 0,



              ),



            ),



          ),



          const SizedBox(height: 20),







          // Results



          if (_results != null && _results!.isNotEmpty) ...[



            Text(isTe ? '🌱 మీ పంటకు సలహాలు' : '🌱 Recommendations for Your Crop',



                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),



            const SizedBox(height: 10),



            ..._results!.asMap().entries.map((e) {



              final r = e.value;



              return _ResultCard(analysis: r, isTe: isTe, isDark: isDark)



                  .animate(delay: Duration(milliseconds: e.key * 60))



                  .fadeIn(duration: 300.ms).slideY(begin: 0.1);



            }),



            const SizedBox(height: 12),



            Container(



              padding: const EdgeInsets.all(12),



              decoration: BoxDecoration(



                color: AppColors.riskMedium.withOpacity(0.08),



                borderRadius: BorderRadius.circular(12),



                border: Border.all(color: AppColors.riskMedium.withOpacity(0.2)),



              ),



              child: Text(



                isTe



                    ? '⚠️ ఈ సలహాలు సాధారణ మార్గదర్శకాలు మాత్రమే. మీ జిల్లా వ్యవసాయ అధికారి లేదా రైతు సేవా కేంద్రాన్ని సంప్రదించండి.'



                    : '⚠️ These are general guidelines. Consult your district Agriculture Officer or Rythu Seva Kendra for precise advice.',



                style: const TextStyle(fontSize: 11, color: AppColors.riskMedium, height: 1.4),



              ),



            ),



          ] else if (_analyzed) ...[



            const Center(child: Text('✅ All entered values are within normal range!',



                style: TextStyle(color: AppColors.riskLow, fontWeight: FontWeight.w700))),



          ],



          const SizedBox(height: 32),



        ]),



      ),



    );



  }



}







// ── Input field ───────────────────────────────────────────────────────────────



class _ParamField extends StatelessWidget {



  final _Param param;



  final TextEditingController controller;



  final bool isDark, isTe;



  const _ParamField({required this.param, required this.controller, required this.isDark, required this.isTe});







  @override



  Widget build(BuildContext context) => Padding(



    padding: const EdgeInsets.only(bottom: 10),



    child: Row(children: [



      SizedBox(width: 130, child: Text(



        isTe ? param.labelTE : param.labelEN,



        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),



      )),



      const SizedBox(width: 8),



      Expanded(child: TextField(



        controller: controller,



        keyboardType: const TextInputType.numberWithOptions(decimal: true),



        decoration: InputDecoration(



          hintText: isTe ? param.hintTE : param.hintEN,



          suffixText: param.unit,



          suffixStyle: const TextStyle(fontSize: 11, color: AppColors.textLight),



          filled: true,



          fillColor: isDark ? AppColors.darkCard : Colors.white,



          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),



          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),



          isDense: true,



        ),



        style: const TextStyle(fontSize: 13),



      )),



    ]),



  );



}







// ── Result card ───────────────────────────────────────────────────────────────



class _ResultCard extends StatelessWidget {



  final _Analysis analysis;



  final bool isDark, isTe;



  const _ResultCard({required this.analysis, required this.isDark, required this.isTe});







  @override



  Widget build(BuildContext context) => Container(



    margin: const EdgeInsets.only(bottom: 10),



    padding: const EdgeInsets.all(14),



    decoration: BoxDecoration(



      color: isDark ? AppColors.darkCard : Colors.white,



      borderRadius: BorderRadius.circular(14),



      border: Border.all(color: analysis.color.withOpacity(0.3)),



      boxShadow: AppTheme.cardShadow,



    ),



    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [



      Container(



        width: 42, height: 42,



        decoration: BoxDecoration(color: analysis.color.withOpacity(0.1), shape: BoxShape.circle),



        child: Icon(analysis.icon, color: analysis.color, size: 22),



      ),



      const SizedBox(width: 12),



      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



        Row(children: [



          Text(analysis.paramKey,



              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),



          const SizedBox(width: 8),



          Container(



            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),



            decoration: BoxDecoration(color: analysis.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),



            child: Text(analysis.status,



                style: TextStyle(fontSize: 9, color: analysis.color, fontWeight: FontWeight.w700)),



          ),



        ]),



        const SizedBox(height: 5),



        Text(isTe ? analysis.actionTE : analysis.actionEN,



            style: const TextStyle(fontSize: 12, color: AppColors.textMedium, height: 1.4)),



      ])),



    ]),



  );



}













