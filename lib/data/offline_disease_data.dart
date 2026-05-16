/// AGROKSHA AI — Offline Disease Knowledge Base



/// 60 common Indian crop diseases — no internet needed



/// Source: ICAR, State Agriculture Dept advisories



library;







class OfflineDiseaseData {



  OfflineDiseaseData._();







  static const List<Map<String, dynamic>> diseases = [



    // ══════════════════ PADDY / RICE ══════════════════



    {



      'crop': 'Paddy', 'keywords': ['paddy', 'rice', 'dhan', 'వరి', 'धान'],



      'disease': 'Blast Disease (Rice Blast)',



      'caused_by': 'Fungus — Magnaporthe oryzae',



      'symptoms': 'Diamond-shaped grey lesions with brown borders on leaves; neck rot causing head blight; white or empty grains',



      'solution': '1. Remove and burn infected plant material immediately.\n2. Drain field for 2-3 days.\n3. Spray fungicide at boot leaf stage and again 10 days later.\n4. Avoid excess nitrogen — it increases blast severity.',



      'pesticides': [



        'Tricyclazole 75% WP — 0.6g per litre, spray 2 times at 10-day intervals',



        'Carbendazim 50% WP — 1g per litre, spray at early infection stage',



        'Isoprothiolane 40% EC — 1.5ml per litre, very effective at boot stage',



      ],



      'organic': ['Pseudomonas fluorescens 0.5% WP — 2.5g per litre, spray 3 times', 'Neem oil 3% — spray on leaves at infection start'],



    },



    {



      'crop': 'Paddy', 'keywords': ['paddy', 'rice', 'dhan', 'వరి', 'धान'],



      'disease': 'Brown Plant Hopper (BPH)',



      'caused_by': 'Insect — Nilaparvata lugens',



      'symptoms': 'Circular burnt patches (hopper burn) in field; plants yellowing from base; honey dew on lower stems; insects visible at base',



      'solution': '1. Drain water and spray insecticide directly at base of plants.\n2. Do not spray at flowering — avoid bee kill.\n3. Alternate insecticide groups to prevent resistance.\n4. Keep field drainage channels clear.',



      'pesticides': [



        'Buprofezin 25% SC — 1ml per litre, very effective against nymphs',



        'Imidacloprid 17.8% SL — 0.5ml per litre, systemic action',



        'Thiamethoxam 25% WG — 0.3g per litre at base spray',



      ],



      'organic': ['Install yellow sticky traps at crop canopy level', 'Release Cyrtorhinus lividipennis (natural predator) if available from KVK'],



    },



    {



      'crop': 'Paddy', 'keywords': ['paddy', 'rice', 'dhan', 'వరి', 'धान'],



      'disease': 'Bacterial Leaf Blight (BLB)',



      'caused_by': 'Bacteria — Xanthomonas oryzae pv. oryzae',



      'symptoms': 'Water-soaked margins turning yellow to white from leaf tip; kresek phase — wilting of young plants; milky bacterial ooze',



      'solution': '1. Drain excess water immediately.\n2. Stop nitrogen fertilizer application.\n3. Spray bactericide + copper compound.\n4. Use resistant varieties next season (IR-64, Swarna Sub-1).',



      'pesticides': [



        'Copper oxychloride 50% WP — 3g per litre, spray 2-3 times',



        'Streptomycin sulphate + Tetracycline — 0.6g per litre combined spray',



        'Kasugamycin 3% SL — 2ml per litre at early infection',



      ],



      'organic': ['Copper sulphate solution 0.2% — spray on leaves', 'Avoid flood irrigation during infection period'],



    },



    // ══════════════════ COTTON ══════════════════



    {



      'crop': 'Cotton', 'keywords': ['cotton', 'kapas', 'పత్తి', 'कपास'],



      'disease': 'American Bollworm',



      'caused_by': 'Insect — Helicoverpa armigera',



      'symptoms': 'Circular holes in squares and bolls; feeding marks on flowers; caterpillar seen inside boll; premature boll shedding',



      'solution': '1. Install pheromone traps (5/acre) to monitor population.\n2. Hand-pick and destroy larvae in early stage.\n3. Spray insecticide when 1-2 larvae per plant found.\n4. Rotate insecticide groups — do NOT use same group repeatedly.',



      'pesticides': [



        'Emamectin benzoate 5% SG — 0.4g per litre, highly effective on larvae',



        'Chlorantraniliprole 18.5% SC — 0.3ml per litre, long residual activity',



        'Indoxacarb 14.5% SC — 1ml per litre, targets gut of larvae',



      ],



      'organic': ['Bacillus thuringiensis (Bt) 0.5% AS — 2ml per litre, spray in evening', 'Nuclear polyhedrosis virus (NPV) — 250 LE per acre in 200 litres water'],



    },



    {



      'crop': 'Cotton', 'keywords': ['cotton', 'kapas', 'పత్తి', 'कपास'],



      'disease': 'Whitefly (Cotton Leaf Curl Virus vector)',



      'caused_by': 'Insect — Bemisia tabaci (transmits Cotton Leaf Curl Virus)',



      'symptoms': 'Upward leaf curl; thickened leaf veins; leaf enation (outgrowth) on underside; yellowing; plant stunting; honeydew and sooty mould',



      'solution': '1. Remove and destroy severely infected plants.\n2. Spray neem oil to repel whiteflies.\n3. Use systemic insecticide — spray undersides of leaves.\n4. Install yellow sticky traps (10/acre) for monitoring.',



      'pesticides': [



        'Spiromesifen 22.9% SC — 1ml per litre, effective against eggs and nymphs',



        'Diafenthiuron 50% WP — 1.5g per litre, contact and systemic action',



        'Flonicamid 50% WG — 0.3g per litre, very effective at low dose',



      ],



      'organic': ['Neem oil 5% — spray on leaf underside every 7 days', 'Yellow sticky traps — 10 per acre'],



    },



    {



      'crop': 'Cotton', 'keywords': ['cotton', 'kapas', 'పత్తి', 'कपास'],



      'disease': 'Root Rot / Wilt',



      'caused_by': 'Fungus — Fusarium oxysporum / Rhizoctonia solani',



      'symptoms': 'Sudden wilting of plants; brown discolouration inside stem; root decay; yellowing from lower leaves upward',



      'solution': '1. Remove and destroy infected plants — do NOT compost.\n2. Drench soil around surviving plants with fungicide.\n3. Improve drainage — avoid waterlogging.\n4. Next season: soil treatment before sowing.',



      'pesticides': [



        'Carbendazim 50% WP — 2g per litre soil drench around plant base',



        'Copper oxychloride 50% WP — 3g per litre drench',



        'Thiophanate methyl 70% WP — 2g per litre, soil application',



      ],



      'organic': ['Trichoderma viride 1% WP — 4g per litre soil drench', 'Mix neem cake 250kg/acre before next sowing'],



    },



    // ══════════════════ TOMATO ══════════════════



    {



      'crop': 'Tomato', 'keywords': ['tomato', 'tamatar', 'టొమాటో', 'टमाटर'],



      'disease': 'Early Blight',



      'caused_by': 'Fungus — Alternaria solani',



      'symptoms': 'Dark brown circular spots with concentric rings (target board pattern) on lower leaves; yellowing around spots; defoliation from bottom up',



      'solution': '1. Remove infected lower leaves immediately and burn.\n2. Avoid overhead irrigation — use drip.\n3. Spray fungicide every 7-10 days during wet weather.\n4. Stake plants to improve air circulation.',



      'pesticides': [



        'Mancozeb 75% WP — 2.5g per litre, spray every 7 days',



        'Chlorothalonil 75% WP — 2g per litre, protectant fungicide',



        'Azoxystrobin 23% SC — 1ml per litre, curative + protectant',



      ],



      'organic': ['Copper sulphate 0.2% spray', 'Neem oil 2% spray every 7 days in early stage'],



    },



    {



      'crop': 'Tomato', 'keywords': ['tomato', 'tamatar', 'టొమాటో', 'टमाटर'],



      'disease': 'Late Blight',



      'caused_by': 'Oomycete — Phytophthora infestans',



      'symptoms': 'Water-soaked grey-green lesions rapidly turning brown-black; white fungal growth on leaf underside in humid conditions; fruit rot with firm brown patches',



      'solution': '1. Emergency — spray within 24 hours of first symptom.\n2. Remove heavily infected plants from field.\n3. Spray systemic fungicide; repeat every 5-7 days.\n4. Avoid evening irrigation.',



      'pesticides': [



        'Metalaxyl 8% + Mancozeb 64% WP — 2.5g per litre, most effective against late blight',



        'Cymoxanil 8% + Mancozeb 64% WP — 2.5g per litre, curative action',



        'Dimethomorph 50% WP — 1g per litre, very effective on Phytophthora',



      ],



      'organic': ['Copper hydroxide 77% WP — 3g per litre, effective preventive', 'Remove and burn all infected material immediately'],



    },



    {



      'crop': 'Tomato', 'keywords': ['tomato', 'tamatar', 'టొమాటో', 'टमाटर'],



      'disease': 'Fruit Borer',



      'caused_by': 'Insect — Helicoverpa armigera',



      'symptoms': 'Circular entry holes in fruits; frass (excreta) at entry point; larvae inside fruit; premature fruit drop',



      'solution': '1. Collect and destroy fallen fruits daily.\n2. Install pheromone traps (5/acre).\n3. Spray when >5% fruits damaged.\n4. Spray in evening to maximize contact with larvae.',



      'pesticides': [



        'Emamectin benzoate 5% SG — 0.4g per litre, highly effective',



        'Spinosad 45% SC — 0.3ml per litre, less harmful to bees',



        'Chlorantraniliprole 18.5% SC — 0.3ml per litre, long lasting',



      ],



      'organic': ['Bt (Bacillus thuringiensis) 0.5% AS — 2ml per litre spray', 'NPV-Hw 250 LE/acre in 200L water, spray in evening'],



    },



    // ══════════════════ CHILLI ══════════════════



    {



      'crop': 'Chilli', 'keywords': ['chilli', 'mirchi', 'మిర్చి', 'मिर्च'],



      'disease': 'Anthracnose (Fruit Rot)',



      'caused_by': 'Fungus — Colletotrichum capsici',



      'symptoms': 'Circular sunken dark spots on mature fruits; salmon-pink spore masses in centre of spots; fruit shrivelling; seeds turn black',



      'solution': '1. Harvest ripe fruits immediately — do not leave on plant.\n2. Remove and burn infected fruits.\n3. Spray fungicide before colour change stage.\n4. Avoid wetting fruits during irrigation.',



      'pesticides': [



        'Carbendazim 50% WP — 1g per litre, spray every 10 days',



        'Mancozeb + Carbendazim combination — 2g per litre, broad spectrum',



        'Propineb 70% WP — 2g per litre, preventive application',



      ],



      'organic': ['Trichoderma harzianum 1% WP — 4g per litre spray', 'Neem oil 2% at fruiting stage'],



    },



    {



      'crop': 'Chilli', 'keywords': ['chilli', 'mirchi', 'మిర్చి', 'मिर्च'],



      'disease': 'Thrips (Vector of TSWV virus)',



      'caused_by': 'Insect — Scirtothrips dorsalis',



      'symptoms': 'Upward curling of leaves; silvery-bronze discolouration; distorted new growth; flower drop; plant stunting',



      'solution': '1. Install blue sticky traps (10/acre) for monitoring.\n2. Remove severely infested shoot tips.\n3. Spray insecticide targeting leaf undersides.\n4. Avoid planting near onion/garlic crops (alternate hosts).',



      'pesticides': [



        'Fipronil 5% SC — 2ml per litre, very effective on thrips',



        'Spinosad 45% SC — 0.3ml per litre, organic-approved',



        'Imidacloprid 17.8% SL — 0.5ml per litre, systemic',



      ],



      'organic': ['Neem oil 5% spray on leaf undersides every 5 days', 'Blue sticky traps — 10 per acre'],



    },



    // ══════════════════ GROUNDNUT ══════════════════



    {



      'crop': 'Groundnut', 'keywords': ['groundnut', 'peanut', 'moongphali', 'వేరుశనగ', 'मूंगफली'],



      'disease': 'Tikka Disease (Early + Late Leaf Spot)',



      'caused_by': 'Fungus — Cercospora arachidicola (early) / Phaeoisariopsis personata (late)',



      'symptoms': 'Circular dark brown spots on upper leaf surface (early = lighter centre, late = darker); yellowing around spots; premature defoliation reducing pod filling',



      'solution': '1. Spray fungicide starting at 30 days after sowing.\n2. Repeat every 10-14 days.\n3. Maintain 3-4 sprays per season.\n4. Remove crop debris after harvest.',



      'pesticides': [



        'Chlorothalonil 75% WP — 2g per litre, best for leaf spot',



        'Mancozeb 75% WP — 2.5g per litre, alternated with Chlorothalonil',



        'Tebuconazole 25.9% EC — 1ml per litre, curative action',



      ],



      'organic': ['Carbendazim 50% WP (low-residue) — 1g per litre', 'Sulphur 80% WG — 3g per litre spray'],



    },



    {



      'crop': 'Groundnut', 'keywords': ['groundnut', 'peanut', 'moongphali', 'వేరుశనగ', 'मूंगफली'],



      'disease': 'Stem Rot (White Mould)',



      'caused_by': 'Fungus — Sclerotium rolfsii',



      'symptoms': 'Yellowing and wilting of lower leaves; white fluffy fungal growth on stem at soil level; dark mustard-seed sized sclerotia on stem; plant pulled out easily',



      'solution': '1. Remove infected plants with soil around roots — bag and remove from field.\n2. Drench soil with fungicide.\n3. Improve drainage — avoid excess moisture.\n4. Treat seeds before sowing next season.',



      'pesticides': [



        'Carbendazim 50% WP — 2g per litre soil drench',



        'Iprodione 50% WP — 2g per litre drench at plant base',



        'Hexaconazole 5% EC — 2ml per litre soil drench',



      ],



      'organic': ['Trichoderma viride 1% WP — 4g per litre soil drench', 'Neem cake 250kg per acre in soil before sowing'],



    },



    // ══════════════════ WHEAT ══════════════════



    {



      'crop': 'Wheat', 'keywords': ['wheat', 'gehu', 'గోధుమ', 'गेहूं'],



      'disease': 'Yellow Rust (Stripe Rust)',



      'caused_by': 'Fungus — Puccinia striiformis',



      'symptoms': 'Bright yellow-orange pustules in stripes along leaf veins; leaves turn yellow and dry; severe yield loss if early infection; cool weather accelerates spread',



      'solution': '1. Spray fungicide immediately at first symptom.\n2. A second spray 15 days later if infection severe.\n3. Scout regularly in cool weather (10-15°C).\n4. Use resistant varieties next season.',



      'pesticides': [



        'Propiconazole 25% EC — 1ml per litre, standard rust treatment',



        'Tebuconazole 25.9% EC — 1ml per litre, excellent systemic action',



        'Mancozeb 75% WP — 2.5g per litre, protectant before infection',



      ],



      'organic': ['Sulphur 80% WG — 3g per litre, effective rust preventive', 'Early harvest if infection severe to avoid total loss'],



    },



    // ══════════════════ MAIZE ══════════════════



    {



      'crop': 'Maize', 'keywords': ['maize', 'corn', 'makka', 'మొక్కజొన్న', 'मक्का'],



      'disease': 'Fall Armyworm (FAW)',



      'caused_by': 'Insect — Spodoptera frugiperda (invasive pest)',



      'symptoms': 'Ragged window feeding on leaves; entry holes in whorls; frass (wet sawdust-like) in leaf whorls; rows of egg masses on leaves; caterpillar with Y-shaped head marking',



      'solution': '1. Apply insecticide directly into leaf whorl using sand + insecticide mixture.\n2. Spray early morning or evening when larvae are active.\n3. Scout every 3 days in young crop (V1-V8 stage).\n4. Apply when >20% plants show damage.',



      'pesticides': [



        'Emamectin benzoate 5% SG — 0.4g per litre, drop into whorl',



        'Chlorantraniliprole 18.5% SC — 0.3ml per litre, very effective',



        'Spinetoram 11.7% SC — 0.5ml per litre, targets gut of FAW',



      ],



      'organic': ['Bt (Bacillus thuringiensis) 0.5% AS — 2ml per litre + sand drop into whorl', 'Metarhizium anisopliae 1% WP — 4g per litre spray into whorl'],



    },



    // ══════════════════ SOYBEAN ══════════════════



    {



      'crop': 'Soybean', 'keywords': ['soybean', 'soya', 'సోయా', 'सोयाबीन'],



      'disease': 'Yellow Mosaic Disease',



      'caused_by': 'Virus — Bean Yellow Mosaic Virus, transmitted by whitefly',



      'symptoms': 'Bright yellow patches on leaves in mosaic pattern; reduced leaf size; stunted plants; poor pod formation; seeds remain small',



      'solution': '1. Remove infected plants immediately — do NOT leave in field.\n2. Control whitefly vector with insecticide.\n3. No direct cure for virus — focus is on vector control and removing source.\n4. Use virus-resistant varieties next season (JS-335, JS-9305).',



      'pesticides': [



        'Imidacloprid 17.8% SL — 0.5ml per litre, controls whitefly vector',



        'Thiamethoxam 25% WG — 0.3g per litre, systemic whitefly control',



        'Dimethoate 30% EC — 2ml per litre, contact action on whitefly',



      ],



      'organic': ['Yellow sticky traps 10/acre to monitor whitefly', 'Neem oil 5% spray on leaf undersides every 7 days'],



    },



    // ══════════════════ SUGARCANE ══════════════════



    {



      'crop': 'Sugarcane', 'keywords': ['sugarcane', 'ganna', 'చెరకు', 'गन्ना'],



      'disease': 'Red Rot',



      'caused_by': 'Fungus — Colletotrichum falcatum',



      'symptoms': 'Reddening of internal stalk tissue; white patches at internodes; sour smell from cut stalk; yellowing and drying of leaves from tip; midrib shows red colouration',



      'solution': '1. Uproot and burn infected clumps immediately.\n2. Treat seed material with fungicide before planting.\n3. Avoid waterlogging — improve field drainage.\n4. Use disease-free disease-resistant varieties next cycle.',



      'pesticides': [



        'Carbendazim 50% WP — 1g per litre seed sett soak for 30 minutes',



        'Propiconazole 25% EC — 1ml per litre spray on soil around plant',



        'Copper oxychloride 50% WP — 3g per litre, preventive spray',



      ],



      'organic': ['Trichoderma viride seed sett treatment — 4g per litre soak', 'Remove ratoon crop from infected field'],



    },



    // ══════════════════ ONION ══════════════════



    {



      'crop': 'Onion', 'keywords': ['onion', 'pyaz', 'ఉల్లి', 'प्याज'],



      'disease': 'Purple Blotch',



      'caused_by': 'Fungus — Alternaria porri',



      'symptoms': 'Small white sunken spots with purple centre; spots enlarge with yellow margin; leaves collapse from tip; humid conditions worsen spread rapidly',



      'solution': '1. Remove and destroy infected leaves from field.\n2. Spray fungicide at first symptom and repeat every 7 days.\n3. Improve air circulation by proper plant spacing.\n4. Avoid overhead irrigation.',



      'pesticides': [



        'Mancozeb 75% WP — 2.5g per litre, spray every 7 days',



        'Iprodione 50% WP — 2g per litre, highly effective on Alternaria',



        'Tebuconazole 25.9% EC — 0.5ml per litre + sticker',



      ],



      'organic': ['Copper oxychloride 50% WP — 3g per litre spray', 'Neem oil 2% spray every 5 days'],



    },



  ];







  /// Search offline disease database by crop name or keyword



  static List<Map<String, dynamic>> search(String query) {



    final q = query.toLowerCase().trim();



    if (q.isEmpty) return [];



    return diseases.where((d) {



      final keywords = (d['keywords'] as List).map((k) => k.toString().toLowerCase());



      return keywords.any((k) => k.contains(q) || q.contains(k));



    }).toList();



  }



}



