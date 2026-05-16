/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Government Schemes Data



/// Central + State-specific schemes, direct links



/// ─────────────────────────────────────────────────────────────────────────────







library;







class SchemeData {



  SchemeData._();







  // ── Central Government Schemes ────────────────────────────────────────────



  static const List<Map<String, dynamic>> centralSchemes = [



    {



      'title': 'PM-KISAN Samman Nidhi',



      'subtitle': '₹6,000/year income support',



      'description':



          'Financial benefit of ₹6,000 per year in 3 equal instalments of ₹2,000 each to all landholding farmer families across India.',



      'tags': ['Income Support', 'Direct Benefit Transfer'],



      'link': 'https://pmkisan.gov.in/',



      'icon': '💰',



    },



    {



      'title': 'PM Fasal Bima Yojana (PMFBY)',



      'subtitle': 'Comprehensive Crop Insurance',



      'description':



          'Financial support in the event of crop failure due to natural calamities, pests & diseases. Premium as low as 2% for Kharif, 1.5% for Rabi.',



      'tags': ['Insurance', 'Risk Cover'],



      'link': 'https://pmfby.gov.in/',



      'icon': '🛡️',



    },



    {



      'title': 'Kisan Credit Card (KCC)',



      'subtitle': 'Easy short-term farm credit',



      'description':



          'Short-term credit for crop cultivation, post-harvest expenses, and farm maintenance at subsidised interest rates (4% effective).',



      'tags': ['Loan', 'Credit', 'Bank'],



      'link': 'https://www.nabard.org/content.aspx?id=595',



      'icon': '💳',



    },



    {



      'title': 'Soil Health Card Scheme',



      'subtitle': 'Know your soil nutrient status',



      'description':



          'Provides farmers with information on soil health and advice on the proper dosage of nutrients to improve soil quality and farm productivity.',



      'tags': ['Soil', 'Free Card'],



      'link': 'https://soilhealth.dac.gov.in/',



      'icon': '🌍',



    },



    {



      'title': 'PM Kisan MAN DHAN Yojana',



      'subtitle': 'Pension ₹3,000/month at age 60',



      'description':



          'A voluntary pension scheme providing a monthly pension of ₹3,000 to small and marginal farmers after 60 years of age.',



      'tags': ['Pension', 'Social Security'],



      'link': 'https://pmkmy.gov.in/',



      'icon': '👴',



    },



    {



      'title': 'e-NAM (National Agri Market)',



      'subtitle': 'Online trading for better prices',



      'description':



          'A pan-India electronic trading portal that networks existing APMC mandis to create a unified national market for agricultural commodities.',



      'tags': ['Market', 'Online Trading'],



      'link': 'https://enam.gov.in/',



      'icon': '📈',



    },



  ];







  // ── State-Specific Schemes ────────────────────────────────────────────────



  static const Map<String, List<Map<String, dynamic>>> stateSchemes = {



    'Telangana': [



      {



        'title': 'Rythu Bandhu Scheme',



        'subtitle': '₹10,000/acre per season investment support',



        'description':



            'Telangana\'s flagship scheme providing ₹5,000 per acre per season (₹10,000/year) as farm investment support directly to farmers before each season.',



        'tags': ['Investment Support', 'Telangana'],



        'link': 'https://rythubandhu.telangana.gov.in/',



        'icon': '🌱',



      },



      {



        'title': 'UREA / Fertiliser Booking (TS iFert)',



        'subtitle': 'Book fertilisers online with subsidies',



        'description':



            'Telangana farmers can book subsidised UREA, DAP, MOP and other fertilisers online through the TS iFert portal using Aadhaar. Collect from nearest Primary Agricultural Cooperative Society (PACS).',



        'tags': ['Fertiliser', 'UREA', 'DAP', 'Online Booking'],



        'link': 'https://agri.telangana.gov.in/',



        'icon': '🧪',



      },



      {



        'title': 'Rythu Vedika (Farmer Centres)',



        'subtitle': 'Free advisory at your village',



        'description':



            'Village-level service centres providing free soil testing, crop advisory, pest management, and market information services to Telangana farmers.',



        'tags': ['Advisory', 'Free Service'],



        'link': 'https://agri.telangana.gov.in/',



        'icon': '🏡',



      },



      {



        'title': 'TS Rythu Bima (Crop Insurance)',



        'subtitle': '₹5 Lakh life insurance for farmers',



        'description':



            'Life insurance cover of ₹5 Lakh to farmers aged 18-59 years who are registered under Rythu Bandhu, in case of accidental or natural death.',



        'tags': ['Life Insurance', 'Free'],



        'link': 'https://rythubandhu.telangana.gov.in/',



        'icon': '🛡️',



      },



      {



        'title': 'Mission Kakatiya (Tank Revival)',



        'subtitle': 'Restore farm tanks for irrigation',



        'description':



            'Comprehensive irrigation support to restore village tanks and water bodies to improve last-mile irrigation connectivity in Telangana.',



        'tags': ['Irrigation', 'Water'],



        'link': 'https://irrigation.telangana.gov.in/',



        'icon': '💧',



      },



    ],



    'Andhra Pradesh': [



      {



        'title': 'YSR Rythu Bharosa',



        'subtitle': '₹13,500/year investment support',



        'description':



            'Provides ₹13,500 per year (₹5,500 from State + ₹6,000 from PM-KISAN + ₹2,000 bonus) directly to farmer accounts as investment support.',



        'tags': ['Investment Support', 'AP'],



        'link': 'https://ysrrythubharosa.ap.gov.in/',



        'icon': '💰',



      },



      {



        'title': 'AP Fertiliser Booking (Mee-Bhoomi)',



        'subtitle': 'Book UREA, DAP online with Aadhaar',



        'description':



            'AP farmers can book subsidised fertilisers like UREA, DAP, NPK through the state portal and collect from nearest retailers using biometric authentication.',



        'tags': ['Fertiliser', 'UREA', 'DAP', 'Online'],



        'link': 'https://www.meebhoomi.ap.gov.in/',



        'icon': '🧪',



      },



      {



        'title': 'YSR Free Crop Insurance',



        'subtitle': 'Premium paid by AP government',



        'description':



            'AP Government pays the entire farmer premium share for Pradhan Mantri Fasal Bima Yojana making crop insurance completely free for AP farmers.',



        'tags': ['Insurance', 'Free', 'AP'],



        'link': 'https://apagrisnet.ap.gov.in/',



        'icon': '🛡️',



      },



      {



        'title': 'Jagananna Thodu (KCC Support)',



        'subtitle': 'Zero interest loans up to ₹1 Lakh',



        'description':



            'Interest subvention scheme making Kisan Credit Cards effectively zero interest for loans up to ₹1 Lakh per eligible farmer in AP.',



        'tags': ['Loan', 'Zero Interest'],



        'link': 'https://apagrisnet.ap.gov.in/',



        'icon': '💳',



      },



    ],



    'Maharashtra': [



      {



        'title': 'Mahatma Jyotiba Phule Shetkari Borj Mukti Yojana',



        'subtitle': 'Farm loan waiver up to ₹2 Lakh',



        'description':



            'Farm loan waiver scheme for small and marginal farmers in Maharashtra, providing relief up to ₹2 Lakh on outstanding institutional loans.',



        'tags': ['Loan Waiver', 'Maharashtra'],



        'link': 'https://aaple.maharashtra.gov.in/',



        'icon': '💸',



      },



      {



        'title': 'Namo Shetkari Maha Samman Nidhi',



        'subtitle': '₹6,000/year additional support',



        'description':



            'Maharashtra state provides an additional ₹6,000 per year on top of PM-KISAN giving eligible Maharashtra farmers a total of ₹12,000/year.',



        'tags': ['Income Support', 'State Bonus'],



        'link': 'https://krishi.maharashtra.gov.in/',



        'icon': '💰',



      },



      {



        'title': 'Agri Fertiliser Distribution (MahaDBT)',



        'subtitle': 'Subsidised fertiliser & seeds',



        'description':



            'Apply online through MahaDBT portal for subsidised agriculture inputs including seeds, fertilisers and pesticides for Maharashtra farmers.',



        'tags': ['Fertiliser', 'Seeds', 'Online'],



        'link': 'https://mahadbt.maharashtra.gov.in/Farmer/Login/Login',



        'icon': '🧪',



      },



    ],



    'Punjab': [



      {



        'title': 'Punjab Zero Interest Crop Loan',



        'subtitle': 'Zero interest seasonal loans',



        'description':



            'Punjab government provides interest subvention on short-term crop loans making them effectively zero interest for small and marginal farmers.',



        'tags': ['Loan', 'Zero Interest', 'Punjab'],



        'link': 'https://agripb.gov.in/',



        'icon': '💳',



      },



      {



        'title': 'Pani Bachao Paise Kamao',



        'subtitle': 'Save water, earn incentives',



        'description':



            'Incentive scheme in Punjab that pays farmers directly for reducing paddy water consumption by switching to direct seeded rice or micro-irrigation.',



        'tags': ['Water', 'Incentive', 'Punjab'],



        'link': 'https://agripb.gov.in/',



        'icon': '💧',



      },



    ],



    'Rajasthan': [



      {



        'title': 'Mukhyamantri Krishak Sathi Yojana',



        'subtitle': 'Accident insurance ₹2 Lakh for farmers',



        'description':



            'Accident insurance cover of ₹2 Lakh for farmers and farm labourers in Rajasthan in the event of disability or death during farming activities.',



        'tags': ['Insurance', 'Rajasthan'],



        'link': 'https://agriculture.rajasthan.gov.in/',



        'icon': '🛡️',



      },



    ],



    'Karnataka': [



      {



        'title': 'Raitha Siri (Farmer Income Support)',



        'subtitle': '₹10,000/year for small farmers',



        'description':



            'Karnataka state scheme providing ₹10,000 annual financial assistance to small and marginal farmers in addition to PM-KISAN benefits.',



        'tags': ['Income Support', 'Karnataka'],



        'link': 'https://raitamitra.karnataka.gov.in/',



        'icon': '💰',



      },



      {



        'title': 'Krishi Bhagya (Rainfall Adaptation)',



        'subtitle': 'Support for dryland farmers',



        'description':



            'Comprehensive scheme to assist rainfed farmers in Karnataka with farm ponds, sprinkler irrigation, and drought-resistant seed varieties.',



        'tags': ['Irrigation', 'Dryland', 'Karnataka'],



        'link': 'https://raitamitra.karnataka.gov.in/',



        'icon': '🌧️',



      },



    ],



    'Tamil Nadu': [



      {



        'title': 'Uzhavar Urimai (Farmer Rights Scheme)',



        'subtitle': '₹1,000/month direct support',



        'description':



            'Monthly financial support of ₹1,000 to farming families in Tamil Nadu directly to bank accounts to cover living expenses during off-season.',



        'tags': ['Monthly Support', 'Tamil Nadu'],



        'link': 'https://tnagrisnet.tn.gov.in/',



        'icon': '💰',



      },



    ],



    'Gujarat': [



      {



        'title': 'Mukhyamantri Kisan Sahay Yojana',



        'subtitle': 'Crop loss compensation',



        'description':



            'State crop insurance scheme providing compensation for crop loss due to natural disasters like heavy rain, drought and unseasonal rainfall in Gujarat.',



        'tags': ['Insurance', 'Gujarat'],



        'link': 'https://agri.gujarat.gov.in/',



        'icon': '🛡️',



      },



    ],



    'Madhya Pradesh': [



      {



        'title': 'Mukhyamantri Kisan Kalyan Yojana',



        'subtitle': '₹4,000 additional annual support',



        'description':



            'MP Government tops up PM-KISAN with ₹4,000/year additional support in 2 instalments, benefiting registered farmers across the state.',



        'tags': ['Income Support', 'MP'],



        'link': 'https://mpfarmer.gov.in/',



        'icon': '💰',



      },



    ],



    'Uttar Pradesh': [



      {



        'title': 'Kisan Rin Mochan Yojana',



        'subtitle': 'Farm loan waiver up to ₹1 Lakh',



        'description':



            'UP government\'s loan waiver scheme for small and marginal farmers with outstanding crop loans up to ₹1 Lakh from cooperative banks.',



        'tags': ['Loan Waiver', 'UP'],



        'link': 'https://upagripardarshi.gov.in/',



        'icon': '💸',



      },



    ],



    'West Bengal': [



      {



        'title': 'Krishak Bandhu (WB)',



        'subtitle': '₹10,000/year for 1+ acre farmers',



        'description':



            'WB government\'s own farm income support scheme providing ₹10,000 annually to farmers with 1+ acre, and ₹2,000/year for marginal farmers.',



        'tags': ['Income Support', 'West Bengal'],



        'link': 'https://krishakbandhu.net/',



        'icon': '💰',



      },



    ],



  };



}



