/// AGROKSHA AI — e-NAM Screen



library;







import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import 'package:provider/provider.dart';



import 'package:url_launcher/url_launcher.dart';



import 'package:webview_flutter/webview_flutter.dart';



import '../theme/app_theme.dart';



import '../utils/app_provider.dart';



import '../models/models.dart';







class EnamScreen extends StatefulWidget {



  const EnamScreen({super.key});



  @override



  State<EnamScreen> createState() => _EnamScreenState();



}







class _EnamScreenState extends State<EnamScreen> with SingleTickerProviderStateMixin {



  late TabController _tabs;



  bool _webLoading = false;



  late final WebViewController _webCtrl;







  @override



  void initState() {



    super.initState();



    _tabs = TabController(length: 3, vsync: this);



    _webCtrl = WebViewController()



      ..setJavaScriptMode(JavaScriptMode.unrestricted)



      ..setNavigationDelegate(NavigationDelegate(



        onPageStarted: (_) => setState(() => _webLoading = true),



        onPageFinished: (_) => setState(() => _webLoading = false),



      ))



      ..loadRequest(Uri.parse('https://enam.gov.in/web/dashboard/trade-data'));



  }







  @override



  void dispose() { _tabs.dispose(); super.dispose(); }







  Future<void> _open(String url) async {



    final uri = Uri.parse(url);



    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);



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



          Text(isTe ? '🏛️ e-NAM మార్కెట్' : '🏛️ e-NAM Market',



              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),



          Text(isTe ? 'జాతీయ వ్యవసాయ మార్కెట్' : 'National Agriculture Market',



              style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.75))),



        ]),



        backgroundColor: AppColors.primary,



        foregroundColor: Colors.white,



        elevation: 0,



        bottom: TabBar(



          controller: _tabs,



          indicatorColor: Colors.white,



          labelColor: Colors.white,



          unselectedLabelColor: Colors.white60,



          tabs: [



            Tab(text: isTe ? 'గురించి' : 'About'),



            Tab(text: isTe ? 'ధరలు' : 'Prices'),



            Tab(text: isTe ? 'నమోదు' : 'Register'),



          ],



        ),



      ),



      body: TabBarView(controller: _tabs, children: [



        _AboutTab(isTe: isTe, isDark: isDark, onOpen: _open),



        _PricesTab(webCtrl: _webCtrl, loading: _webLoading, isTe: isTe),



        _RegisterTab(isTe: isTe, isDark: isDark, onOpen: _open),



      ]),



    );



  }



}







// ── About tab ─────────────────────────────────────────────────────────────────



class _AboutTab extends StatelessWidget {



  final bool isTe, isDark;



  final Function(String) onOpen;



  const _AboutTab({required this.isTe, required this.isDark, required this.onOpen});







  @override



  Widget build(BuildContext context) {



    final benefits = isTe ? [



      ('💰', 'మెరుగైన ధర', 'దళారుల లేకుండా నేరుగా కొనుగోలుదారులకు అమ్ముకోవచ్చు — 15-20% ఎక్కువ ధర'),



      ('📊', 'పారదర్శక ధరలు', 'భారతదేశంలోని అన్ని మండీల ధరలు ఒకే చోట తెలుసుకోవచ్చు'),



      ('🏦', 'త్వరిత చెల్లింపు', 'అమ్మకం అయిన 24 గంటల్లో బ్యాంక్ ఖాతాకు నేరుగా చెల్లింపు'),



      ('📱', 'మొబైల్ లో అమ్మకం', 'ఇంటి నుండే ఆన్‌లైన్‌లో బిడ్ చేయవచ్చు'),



      ('🌐', '1000+ మండీలు', 'భారతదేశంలో 23 రాష్ట్రాలలో 1000+ e-NAM మండీలు'),



    ] : [



      ('💰', 'Better Price', 'Sell directly to buyers without middlemen — 15-20% higher price'),



      ('📊', 'Transparent Prices', 'See live prices from all mandis across India in one place'),



      ('🏦', 'Fast Payment', 'Payment directly to bank account within 24 hours of sale'),



      ('📱', 'Sell from Mobile', 'Place bids and sell online from your home'),



      ('🌐', '1000+ Mandis', '1000+ e-NAM mandis across 23 states in India'),



    ];







    return SingleChildScrollView(



      padding: const EdgeInsets.all(16),



      child: Column(children: [



        // Hero banner



        Container(



          width: double.infinity,



          padding: const EdgeInsets.all(20),



          decoration: BoxDecoration(



            gradient: const LinearGradient(



              colors: [Color(0xFF1B5E20), Color(0xFF388E3C)],



              begin: Alignment.topLeft, end: Alignment.bottomRight,



            ),



            borderRadius: BorderRadius.circular(18),



          ),



          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



            const Text('🏛️', style: TextStyle(fontSize: 36)),



            const SizedBox(height: 8),



            Text(isTe ? 'e-NAM — జాతీయ వ్యవసాయ మార్కెట్' : 'e-NAM — National Agriculture Market',



                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),



            const SizedBox(height: 6),



            Text(isTe



                ? 'భారత ప్రభుత్వం యొక్క అధికారిక ఆన్‌లైన్ వ్యవసాయ వాణిజ్య వేదిక'



                : 'Official online agricultural trading platform by Government of India',



                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12, height: 1.4)),



          ]),



        ).animate().fadeIn(duration: 300.ms),



        const SizedBox(height: 20),







        // Benefits



        Text(isTe ? 'e-NAM వల్ల ప్రయోజనాలు' : 'Benefits of e-NAM',



            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),



        const SizedBox(height: 12),



        ...benefits.map((b) => Container(



          margin: const EdgeInsets.only(bottom: 10),



          padding: const EdgeInsets.all(14),



          decoration: BoxDecoration(



            color: isDark ? AppColors.darkCard : Colors.white,



            borderRadius: BorderRadius.circular(14),



            border: Border.all(color: AppColors.primary.withOpacity(0.1)),



            boxShadow: AppTheme.cardShadow,



          ),



          child: Row(children: [



            Text(b.$1, style: const TextStyle(fontSize: 24)),



            const SizedBox(width: 14),



            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



              Text(b.$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),



              const SizedBox(height: 3),



              Text(b.$3, style: const TextStyle(fontSize: 12, color: AppColors.textMedium, height: 1.4)),



            ])),



          ]),



        )).toList(),







        const SizedBox(height: 16),



        SizedBox(width: double.infinity,



          child: ElevatedButton.icon(



            onPressed: () => onOpen('https://enam.gov.in/web/'),



            icon: const Icon(Icons.open_in_new_rounded, size: 18),



            label: Text(isTe ? 'e-NAM వెబ్‌సైట్ తెరవండి' : 'Open e-NAM Website'),



            style: ElevatedButton.styleFrom(



              backgroundColor: AppColors.primary, foregroundColor: Colors.white,



              padding: const EdgeInsets.symmetric(vertical: 14),



              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),



            ),



          ),



        ),



        const SizedBox(height: 32),



      ]),



    );



  }



}







// ── Prices tab (WebView) ──────────────────────────────────────────────────────



class _PricesTab extends StatelessWidget {



  final WebViewController webCtrl;



  final bool loading;



  final bool isTe;



  const _PricesTab({required this.webCtrl, required this.loading, required this.isTe});







  @override



  Widget build(BuildContext context) {



    return Stack(children: [



      WebViewWidget(controller: webCtrl),



      if (loading)



        Container(color: Colors.white,



          child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [



            const CircularProgressIndicator(color: AppColors.primary),



            const SizedBox(height: 12),



            Text(isTe ? 'e-NAM ధరలు లోడ్ అవుతున్నాయి...' : 'Loading e-NAM prices...',



                style: const TextStyle(color: AppColors.textLight)),



          ]))),



    ]);



  }



}







// ── Register tab ──────────────────────────────────────────────────────────────



class _RegisterTab extends StatelessWidget {



  final bool isTe, isDark;



  final Function(String) onOpen;



  const _RegisterTab({required this.isTe, required this.isDark, required this.onOpen});







  @override



  Widget build(BuildContext context) {



    final steps = isTe ? [



      ('1', 'ఆధార్ కార్డు సిద్ధం చేయండి', 'ఆధార్ నంబర్ మరియు మొబైల్ లింక్ అయి ఉండాలి'),



      ('2', 'బ్యాంక్ పాస్‌బుక్ సిద్ధం చేయండి', 'IFSC కోడ్ మరియు ఖాతా నంబర్ అవసరం'),



      ('3', 'e-NAM వెబ్‌సైట్ తెరవండి', 'enam.gov.in కి వెళ్ళి "Farmer Registration" నొక్కండి'),



      ('4', 'వివరాలు నమోదు చేయండి', 'పేరు, ఆధార్, బ్యాంక్ వివరాలు పూరించండి'),



      ('5', 'OTP ధృవీకరణ', 'మీ మొబైల్ కు వచ్చిన OTP ఎంటర్ చేయండి'),



      ('6', 'మండీ ఎంచుకోండి', 'మీ దగ్గరలోని e-NAM మండీ నమోదు చేయండి'),



    ] : [



      ('1', 'Prepare Aadhaar Card', 'Aadhaar must be linked to your mobile number'),



      ('2', 'Prepare Bank Passbook', 'You need IFSC code and account number'),



      ('3', 'Open e-NAM Website', 'Go to enam.gov.in and click "Farmer Registration"'),



      ('4', 'Fill in Details', 'Enter name, Aadhaar, bank details'),



      ('5', 'OTP Verification', 'Enter OTP sent to your mobile number'),



      ('6', 'Select Your Mandi', 'Register at your nearest e-NAM mandi'),



    ];







    return SingleChildScrollView(



      padding: const EdgeInsets.all(16),



      child: Column(children: [



        Container(



          padding: const EdgeInsets.all(14),



          decoration: BoxDecoration(



            color: AppColors.primarySurface,



            borderRadius: BorderRadius.circular(14),



            border: Border.all(color: AppColors.primary.withOpacity(0.2)),



          ),



          child: Text(



            isTe ? '📋 e-NAM లో నమోదు ఉచితం. ఒక్కసారి నమోదు చేసుకుంటే జీవితకాలం ఉపయోగించవచ్చు.'



                : '📋 e-NAM registration is FREE. Register once and sell forever across India.',



            style: const TextStyle(fontSize: 13, height: 1.5, fontWeight: FontWeight.w600, color: AppColors.primary),



          ),



        ),



        const SizedBox(height: 20),



        Text(isTe ? 'నమోదు దశలు' : 'Registration Steps',



            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),



        const SizedBox(height: 14),



        ...steps.map((s) => Container(



          margin: const EdgeInsets.only(bottom: 10),



          padding: const EdgeInsets.all(14),



          decoration: BoxDecoration(



            color: isDark ? AppColors.darkCard : Colors.white,



            borderRadius: BorderRadius.circular(14),



            border: Border.all(color: AppColors.primary.withOpacity(0.08)),



          ),



          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [



            Container(width: 28, height: 28,



              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),



              child: Center(child: Text(s.$1, style: const TextStyle(color: Colors.white,



                  fontSize: 12, fontWeight: FontWeight.w800)))),



            const SizedBox(width: 14),



            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



              Text(s.$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),



              const SizedBox(height: 3),



              Text(s.$3, style: const TextStyle(fontSize: 12, color: AppColors.textMedium, height: 1.4)),



            ])),



          ]),



        )).toList(),



        const SizedBox(height: 16),



        SizedBox(width: double.infinity,



          child: ElevatedButton.icon(



            onPressed: () => onOpen('https://enam.gov.in/web/registration/farmer-registration'),



            icon: const Icon(Icons.how_to_reg_rounded, size: 18),



            label: Text(isTe ? 'ఇప్పుడు నమోదు చేయండి' : 'Register on e-NAM Now'),



            style: ElevatedButton.styleFrom(



              backgroundColor: AppColors.primary, foregroundColor: Colors.white,



              padding: const EdgeInsets.symmetric(vertical: 14),



              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),



            ),



          ),



        ),



        const SizedBox(height: 8),



        Text(isTe ? 'ℹ️ రాష్ट्रीय వ్యవసాయ మార్కెట్ — భారత ప్రభుత్వం, వ్యవసాయ మంత్రిత్వ శాఖ'



            : 'ℹ️ National Agriculture Market — Govt of India, Ministry of Agriculture',



            textAlign: TextAlign.center,



            style: const TextStyle(fontSize: 11, color: AppColors.textLight, height: 1.4)),



        const SizedBox(height: 32),



      ]),



    );



  }



}



