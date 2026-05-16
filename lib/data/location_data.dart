/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — India Location Data



/// State → District (with lat/lon) → Mandal/Taluka → Villages



/// Coordinates used for Open-Meteo weather API



/// ─────────────────────────────────────────────────────────────────────────────







class DistrictInfo {



  final String name;



  final double lat;



  final double lon;



  final List<String> mandals;







  const DistrictInfo({



    required this.name,



    required this.lat,



    required this.lon,



    required this.mandals,



  });



}







class LocationData {



  LocationData._();







  /// All Indian states



  static const List<String> states = [



    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar',



    'Chhattisgarh', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh',



    'Jharkhand', 'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra',



    'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab',



    'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura',



    'Uttar Pradesh', 'Uttarakhand', 'West Bengal',



  ];







  /// Districts per state with GPS coordinates and mandals



  static const Map<String, List<DistrictInfo>> districts = {







    // ── ANDHRA PRADESH ─────────────────────────────────────────────────────



    'Andhra Pradesh': [



      DistrictInfo(name: 'Guntur', lat: 16.3067, lon: 80.4365, mandals: [



        'Guntur', 'Tenali', 'Mangalagiri', 'Ponnur', 'Bapatla', 'Repalle',



        'Sattenapalle', 'Macherla', 'Narasaraopet', 'Vinukonda',



        'Piduguralla', 'Gurazala', 'Atchampet', 'Dachepalle', 'Chilakaluripet',



        'Amaravathi', 'Tadepalle', 'Medikonduru', 'Phirangipuram', 'Veldurthi',



      ]),



      DistrictInfo(name: 'Krishna', lat: 16.6106, lon: 80.6444, mandals: [



        'Vijayawada', 'Machilipatnam', 'Gudivada', 'Nuzvid', 'Nandigama',



        'Jaggayyapeta', 'Tiruvuru', 'Mylavaram', 'Kaikaluru', 'Avanigadda',



        'Bantumilli', 'Koduru', 'Pamidimukkala', 'Unguturu', 'Movva',



        'Gannavaram', 'Pamarru', 'Kruthivennu', 'Vuyyuru', 'Vissannapet',



      ]),



      DistrictInfo(name: 'Visakhapatnam', lat: 17.6868, lon: 83.2185, mandals: [



        'Visakhapatnam', 'Bheemunipatnam', 'Anakapalli', 'Paderu',



        'Araku Valley', 'Yelamanchili', 'Narsipatnam', 'Chodavaram',



        'Payakaraopeta', 'Madugula', 'Chintapalle', 'Munagapaka',



        'Sabbavaram', 'Pendurthi', 'Bhimili', 'Nakkapalle',



      ]),



      DistrictInfo(name: 'East Godavari', lat: 17.0005, lon: 81.8040, mandals: [



        'Kakinada', 'Rajahmundry', 'Amalapuram', 'Ramachandrapuram',



        'Kotananduru', 'Mandapeta', 'Peddapuram', 'Tuni', 'Prathipadu',



        'Samarlakota', 'Kothapeta', 'Ravulapalem', 'Razole', 'Nidadavolu',



        'Alamuru', 'Draksharamam', 'Mummidivaram', 'Korukonda',



      ]),



      DistrictInfo(name: 'West Godavari', lat: 16.9173, lon: 81.3399, mandals: [



        'Eluru', 'Tadepalligudem', 'Bhimavaram', 'Narsapur', 'Palacole',



        'Kovvur', 'Jangareddygudem', 'Tanuku', 'Narasapuram', 'Penugonda',



        'Akividu', 'Undi', 'Polavaram', 'Chintalapudi', 'Gopalapuram',



        'Denduluru', 'Buttayagudem', 'Rajam', 'Ganapavaram',



      ]),



      DistrictInfo(name: 'Kurnool', lat: 15.8281, lon: 78.0373, mandals: [



        'Kurnool', 'Nandyal', 'Adoni', 'Yemmiganur', 'Dhone',



        'Allagadda', 'Nandikotkur', 'Atmakur', 'Pattikonda', 'Kodumur',



        'Banaganapalle', 'Koilkuntla', 'Sirvel', 'Velgode', 'Gospadu',



        'Peapully', 'Devanakonda', 'Bethamcherla', 'Kolimigundla',



      ]),



      DistrictInfo(name: 'Kadapa', lat: 14.4673, lon: 78.8242, mandals: [



        'Kadapa', 'Proddatur', 'Rajampet', 'Badvel', 'Pulivendla',



        'Jammalamadugu', 'Mydukur', 'Rayachoti', 'Kamalapuram', 'Vempalli',



        'Yerraguntla', 'Sidhout', 'Muddanur', 'Khajipet', 'Chapadu',



        'Vallur', 'Lingala', 'Lakkireddipalle', 'Pendlimarri',



      ]),



      DistrictInfo(name: 'Nellore', lat: 14.4426, lon: 79.9865, mandals: [



        'Nellore', 'Kavali', 'Gudur', 'Atmakur', 'Sullurpeta', 'Kovur',



        'Venkatagiri', 'Allur', 'Podalakur', 'Bogole', 'Duttalur',



        'Indukurpet', 'Marripadu', 'Muthukur', 'Ojili', 'Sangam',



        'Udayagiri', 'Vinjamur', 'Vidavalur',



      ]),



      DistrictInfo(name: 'Prakasam', lat: 15.3361, lon: 79.5741, mandals: [



        'Ongole', 'Markapur', 'Kandukur', 'Chirala', 'Giddalur',



        'Darsi', 'Addanki', 'Podili', 'Parchur', 'Santanuthalapadu',



        'Chimakurthi', 'Cumbum', 'Donakonda', 'Inkollu', 'Kondapi',



        'Komarolu', 'Kurichedu', 'Maddipadu', 'Mundlamuru',



      ]),



      DistrictInfo(name: 'Chittoor', lat: 13.2172, lon: 79.0999, mandals: [



        'Chittoor', 'Tirupati', 'Madanapalle', 'Punganur', 'Palamaner',



        'Srikalahasti', 'Chandragiri', 'Pakala', 'Puttur', 'Nagari',



        'Piler', 'Vayalpad', 'Kuppam', 'Bangarupalem', 'Gangadhara Nellore',



        'Vedurukuppam', 'Satyavedu', 'Yerpedu', 'Renigunta',



      ]),



      DistrictInfo(name: 'Srikakulam', lat: 18.2949, lon: 83.8938, mandals: [



        'Srikakulam', 'Narasannapeta', 'Palasa', 'Tekkali', 'Ichchapuram',



        'Amadalavalasa', 'Etcherla', 'Jalumuru', 'Kanchili', 'Kaviti',



        'Laveru', 'Pathapatnam', 'Rajam', 'Sarubujjili', 'Sompeta',



      ]),



      DistrictInfo(name: 'Vizianagaram', lat: 18.1067, lon: 83.3956, mandals: [



        'Vizianagaram', 'Bobbili', 'Gajapathinagaram', 'Salur', 'Parvathipuram',



        'Cheepurupalli', 'Dattirajeru', 'Gantyada', 'Gurla', 'Jami',



        'Kothavalasa', 'Laxmipuram', 'Makkuva', 'Mentada', 'Nellimarla',



      ]),



    ],







    // ── TELANGANA ──────────────────────────────────────────────────────────



    'Telangana': [



      DistrictInfo(name: 'Hyderabad', lat: 17.3850, lon: 78.4867, mandals: [



        'Secunderabad', 'Hindi Nagar', 'Khairtabad', 'Musheerabad', 'Nampally',



        'Charminar', 'Bahadurpura', 'Bandlaguda', 'Golconda', 'Amberpet',



        'Uppal', 'Malkajgiri', 'Kukatpally', 'Qutubullapur', 'Serilingampally',



      ]),



      DistrictInfo(name: 'Warangal', lat: 17.9689, lon: 79.5941, mandals: [



        'Warangal', 'Hanamkonda', 'Jangaon', 'Parkal', 'Narsampet',



        'Mahabubabad', 'Mulugu', 'Bhupalpally', 'Maripeda', 'Shayampet',



        'Ghanpur', 'Cherial', 'Duggondi', 'Dharmasagar', 'Geesugonda',



        'Khanapur', 'Nallabelly', 'Palakurthi', 'Rayaparthi', 'Thorrur',



      ]),



      DistrictInfo(name: 'Karimnagar', lat: 18.4386, lon: 79.1288, mandals: [



        'Karimnagar', 'Huzurabad', 'Peddapalli', 'Ramagundam', 'Mancherial',



        'Jagtial', 'Metpally', 'Choppadandi', 'Dharmapuri', 'Gangadhara',



        'Husnabad', 'Jammikunta', 'Kothapalli', 'Manthani', 'Pegadapalli',



        'Ramadugu', 'Sircilla', 'Sultanabad', 'Vemulawada',



      ]),



      DistrictInfo(name: 'Nizamabad', lat: 18.6725, lon: 78.0941, mandals: [



        'Nizamabad', 'Armoor', 'Bodhan', 'Kamareddy', 'Banswada',



        'Bheemgal', 'Dichpally', 'Domakonda', 'Enkoor', 'Fertizal',



        'Jakranpalle', 'Kotagiri', 'Lingampet', 'Madnoor', 'Mupkal',



        'Navipet', 'Nizar', 'Renjal', 'Varni', 'Yellareddy',



      ]),



      DistrictInfo(name: 'Medak', lat: 18.0446, lon: 78.2629, mandals: [



        'Medak', 'Sangareddy', 'Siddipet', 'Zaheerabad', 'Gajwel', 'Patancheru',



        'Andole', 'Chegunta', 'Doultabad', 'Hatnoora', 'Jogipet',



        'Kohir', 'Kulcharam', 'Masaipet', 'Narsapur', 'Narayankhed',



        'Ramayampet', 'Shankarampet', 'Toopran', 'Tekmal',



      ]),



      DistrictInfo(name: 'Nalgonda', lat: 17.0575, lon: 79.2673, mandals: [



        'Nalgonda', 'Miryalaguda', 'Suryapet', 'Bhongir', 'Nagarjuna Sagar',



        'Devarakonda', 'Tungathurthi', 'Alair', 'Chandampet', 'Chityal',



        'Damaracherla', 'Deverakonda', 'Halia', 'Kodad', 'Marriguda',



        'Munugode', 'Nakrekal', 'Nampalle', 'Pedda Adiserla Palle', 'Tirumalagiri',



      ]),



      DistrictInfo(name: 'Mahbubnagar', lat: 16.7366, lon: 77.9895, mandals: [



        'Mahbubnagar', 'Jadcherla', 'Wanaparthy', 'Gadwal', 'Narayanpet',



        'Alampur', 'Kalwakurthi', 'Achampet', 'Amangal', 'Atmakur',



        'Balanagar', 'Bhoothpur', 'Bijinapalle', 'Choudaraopet', 'Devarkadra',



        'Dhanwada', 'Hanwada', 'Ieeja', 'Kollapur', 'Lingal',



      ]),



      DistrictInfo(name: 'Adilabad', lat: 19.6655, lon: 78.5323, mandals: [



        'Adilabad', 'Mancherial', 'Nirmal', 'Bhainsa', 'Utnoor', 'Boath',



        'Asifabad', 'Bellampalli', 'Bheempur', 'Dadapur', 'Gudihathnoor',



        'Jainath', 'Kaghaznagar', 'Kerameri', 'Khanapur', 'Kouta',



        'Mudhole', 'Narnoor', 'Sirikonda', 'Tiryani',



      ]),



      DistrictInfo(name: 'Khammam', lat: 17.2473, lon: 80.1514, mandals: [



        'Khammam', 'Kothagudem', 'Bhadrachalam', 'Palvancha', 'Yellandu',



        'Aswaraopet', 'Burgampadu', 'Chandrugonda', 'Chintakani', 'Dammapeta',



        'Enkuru', 'Julurpad', 'Kamepalle', 'Kukunoor', 'Madhira',



        'Manuguru', 'Mulkalapalle', 'Sathupalle', 'Tekulapalle', 'Velairpad',



      ]),



      DistrictInfo(name: 'Rangareddy', lat: 17.2543, lon: 78.3886, mandals: [



        'LB Nagar', 'Hayathnagar', 'Shamshabad', 'Rajendranagar',



        'Maheshwaram', 'Kandukur', 'Chevella', 'Amangal', 'Balapur',



        'Farooqnagar', 'Ghatkesar', 'Ibrahimpatnam', 'Jadcherla', 'Kothur',



        'Manchal', 'Medchal', 'Moinabad', 'Nawabpet', 'Shabad', 'Yacharam',



      ]),



    ],







    // ── MAHARASHTRA ────────────────────────────────────────────────────────



    'Maharashtra': [



      DistrictInfo(name: 'Pune', lat: 18.5204, lon: 73.8567, mandals: [



        'Pune City', 'Haveli', 'Maval', 'Khed', 'Shirur', 'Baramati',



        'Indapur', 'Daund',



      ]),



      DistrictInfo(name: 'Nashik', lat: 20.0059, lon: 73.7898, mandals: [



        'Nashik', 'Igatpuri', 'Dindori', 'Niphad', 'Sinnar', 'Yeola',



        'Malegaon',



      ]),



      DistrictInfo(name: 'Nagpur', lat: 21.1458, lon: 79.0882, mandals: [



        'Nagpur City', 'Kamptee', 'Hingna', 'Katol', 'Narkhed', 'Saoner',



      ]),



      DistrictInfo(name: 'Aurangabad', lat: 19.8762, lon: 75.3433, mandals: [



        'Aurangabad City', 'Paithan', 'Gangapur', 'Phulambri', 'Vaijapur',



      ]),



      DistrictInfo(name: 'Amravati', lat: 20.9374, lon: 77.7796, mandals: [



        'Amravati City', 'Achalpur', 'Daryapur', 'Warud', 'Morshi',



      ]),



      DistrictInfo(name: 'Solapur', lat: 17.6599, lon: 75.9064, mandals: [



        'Solapur City', 'Akkalkot', 'Pandharpur', 'Barshi', 'Mangalvedhe',



      ]),



    ],







    // ── KARNATAKA ──────────────────────────────────────────────────────────



    'Karnataka': [



      DistrictInfo(name: 'Bengaluru Urban', lat: 12.9716, lon: 77.5946, mandals: [



        'Bengaluru North', 'Bengaluru South', 'Yelahanka', 'Anekal',



      ]),



      DistrictInfo(name: 'Mysuru', lat: 12.2958, lon: 76.6394, mandals: [



        'Mysuru', 'Hunsur', 'Piriyapatna', 'K.R. Nagar', 'Heggadadevankote',



      ]),



      DistrictInfo(name: 'Tumakuru', lat: 13.3379, lon: 77.1173, mandals: [



        'Tumakuru', 'Tiptur', 'Madhugiri', 'Koratagere', 'Pavagada',



      ]),



      DistrictInfo(name: 'Belagavi', lat: 15.8497, lon: 74.4977, mandals: [



        'Belagavi', 'Chikodi', 'Gokak', 'Athani', 'Hukkeri', 'Saundatti',



      ]),



      DistrictInfo(name: 'Kalaburagi', lat: 17.3297, lon: 76.8206, mandals: [



        'Kalaburagi', 'Afzalpur', 'Aland', 'Chincholi', 'Jevargi',



      ]),



      DistrictInfo(name: 'Vijayapura', lat: 16.8302, lon: 75.7100, mandals: [



        'Vijayapura', 'Sindgi', 'Muddebihal', 'Indi', 'Bagewadi',



      ]),



    ],







    // ── PUNJAB ─────────────────────────────────────────────────────────────



    'Punjab': [



      DistrictInfo(name: 'Ludhiana', lat: 30.9010, lon: 75.8573, mandals: [



        'Ludhiana', 'Jagraon', 'Raikot', 'Khanna', 'Samrala',



      ]),



      DistrictInfo(name: 'Amritsar', lat: 31.6340, lon: 74.8723, mandals: [



        'Amritsar', 'Ajnala', 'Baba Bakala', 'Attari', 'Majitha',



      ]),



      DistrictInfo(name: 'Patiala', lat: 30.3398, lon: 76.3869, mandals: [



        'Patiala', 'Nabha', 'Rajpura', 'Samana', 'Fatehgarh Sahib',



      ]),



      DistrictInfo(name: 'Jalandhar', lat: 31.3260, lon: 75.5762, mandals: [



        'Jalandhar', 'Nakodar', 'Phillaur', 'Shahkot', 'Lohian',



      ]),



    ],







    // ── UTTAR PRADESH ──────────────────────────────────────────────────────



    'Uttar Pradesh': [



      DistrictInfo(name: 'Lucknow', lat: 26.8467, lon: 80.9462, mandals: [



        'Lucknow Sadar', 'Mohanlalganj', 'Bakshi Ka Talab', 'Mal', 'Kakori',



      ]),



      DistrictInfo(name: 'Varanasi', lat: 25.3176, lon: 82.9739, mandals: [



        'Varanasi', 'Pindra', 'Arajiline', 'Chiraigaon', 'Sewapuri',



      ]),



      DistrictInfo(name: 'Agra', lat: 27.1767, lon: 78.0081, mandals: [



        'Agra', 'Etmadpur', 'Fatehabad', 'Kheragarh', 'Bah',



      ]),



      DistrictInfo(name: 'Meerut', lat: 28.9845, lon: 77.7064, mandals: [



        'Meerut', 'Hapur', 'Garhmukteshwar', 'Pilkhuwa', 'Modinagar',



      ]),



      DistrictInfo(name: 'Kanpur Nagar', lat: 26.4499, lon: 80.3319, mandals: [



        'Kanpur', 'Ghatampur', 'Kalyanpur', 'Bithur', 'Shivrajpur',



      ]),



    ],







    // ── RAJASTHAN ──────────────────────────────────────────────────────────



    'Rajasthan': [



      DistrictInfo(name: 'Jaipur', lat: 26.9124, lon: 75.7873, mandals: [



        'Jaipur', 'Sanganer', 'Chaksu', 'Phagi', 'Dudu', 'Shahpura',



      ]),



      DistrictInfo(name: 'Jodhpur', lat: 26.2389, lon: 73.0243, mandals: [



        'Jodhpur', 'Balesar', 'Luni', 'Phalodi', 'Osian', 'Bilara',



      ]),



      DistrictInfo(name: 'Udaipur', lat: 24.5854, lon: 73.7125, mandals: [



        'Udaipur', 'Mavli', 'Salumbar', 'Gogunda', 'Vallabhnagar',



      ]),



      DistrictInfo(name: 'Kota', lat: 25.2138, lon: 75.8648, mandals: [



        'Kota', 'Sangod', 'Ladpura', 'Sultanpur', 'Pipalda',



      ]),



    ],







    // ── MADHYA PRADESH ────────────────────────────────────────────────────



    'Madhya Pradesh': [



      DistrictInfo(name: 'Bhopal', lat: 23.2599, lon: 77.4126, mandals: [



        'Bhopal', 'Berasia', 'Huzur', 'Phanda', 'Sehore',



      ]),



      DistrictInfo(name: 'Indore', lat: 22.7196, lon: 75.8577, mandals: [



        'Indore City', 'Depalpur', 'Sanwer', 'Mhow', 'Hatod',



      ]),



      DistrictInfo(name: 'Jabalpur', lat: 23.1815, lon: 79.9864, mandals: [



        'Jabalpur', 'Sihora', 'Panagar', 'Kundam', 'Majholi',



      ]),



      DistrictInfo(name: 'Gwalior', lat: 26.2183, lon: 78.1828, mandals: [



        'Gwalior', 'Morar', 'Bhitarwar', 'Dabra', 'Bhind',



      ]),



    ],







    // ── GUJARAT ────────────────────────────────────────────────────────────



    'Gujarat': [



      DistrictInfo(name: 'Ahmedabad', lat: 23.0225, lon: 72.5714, mandals: [



        'Ahmedabad City', 'Dascroi', 'Daskroi', 'Sanand', 'Bavla', 'Dholka',



      ]),



      DistrictInfo(name: 'Surat', lat: 21.1702, lon: 72.8311, mandals: [



        'Surat City', 'Bardoli', 'Mandvi', 'Olpad', 'Mahuva', 'Kamrej',



      ]),



      DistrictInfo(name: 'Rajkot', lat: 22.3039, lon: 70.8022, mandals: [



        'Rajkot', 'Gondal', 'Jetpur', 'Morbi', 'Wankaner', 'Upleta',



      ]),



      DistrictInfo(name: 'Vadodara', lat: 22.3072, lon: 73.1812, mandals: [



        'Vadodara City', 'Savli', 'Dabhoi', 'Padra', 'Vaghodia',



      ]),



    ],







    // ── WEST BENGAL ────────────────────────────────────────────────────────



    'West Bengal': [



      DistrictInfo(name: 'Kolkata', lat: 22.5726, lon: 88.3639, mandals: [



        'Kolkata North', 'Kolkata South', 'Kolkata Port', 'Behala',



      ]),



      DistrictInfo(name: 'Murshidabad', lat: 24.1800, lon: 88.2700, mandals: [



        'Berhampore', 'Lalbagh', 'Raninagar', 'Jalangi', 'Domkal',



      ]),



      DistrictInfo(name: 'Bardhaman', lat: 23.2324, lon: 87.8615, mandals: [



        'Bardhaman', 'Kalna', 'Katwa', 'Memari', 'Ausgram',



      ]),



    ],







    // ── ODISHA ─────────────────────────────────────────────────────────────



    'Odisha': [



      DistrictInfo(name: 'Bhubaneswar', lat: 20.2961, lon: 85.8245, mandals: [



        'Bhubaneswar', 'Jatni', 'Khurda', 'Balianta', 'Tangi',



      ]),



      DistrictInfo(name: 'Cuttack', lat: 20.4625, lon: 85.8830, mandals: [



        'Cuttack', 'Kendrapara', 'Banki', 'Athagarh', 'Tigiria',



      ]),



      DistrictInfo(name: 'Koraput', lat: 18.8109, lon: 82.7125, mandals: [



        'Koraput', 'Jeypore', 'Nabarangpur', 'Umerkote', 'Kotpad',



      ]),



    ],







    // ── Other states use fallback coords ──────────────────────────────────



    'Bihar': [



      DistrictInfo(name: 'Patna', lat: 25.5941, lon: 85.1376, mandals: ['Patna Sadar', 'Phulwari', 'Sampatchak', 'Danapur', 'Maner']),



      DistrictInfo(name: 'Gaya', lat: 24.7955, lon: 85.0002, mandals: ['Gaya', 'Bodhgaya', 'Manpur', 'Amas', 'Dobhi']),



      DistrictInfo(name: 'Muzaffarpur', lat: 26.1197, lon: 85.3910, mandals: ['Muzaffarpur', 'Musahri', 'Kanti', 'Motipur', 'Sitamarhi']),



    ],



    'Tamil Nadu': [



      DistrictInfo(name: 'Chennai', lat: 13.0827, lon: 80.2707, mandals: ['Chennai North', 'Chennai South', 'Tambaram', 'Avadi', 'Thiruvottiyur']),



      DistrictInfo(name: 'Coimbatore', lat: 11.0168, lon: 76.9558, mandals: ['Coimbatore North', 'Coimbatore South', 'Pollachi', 'Mettupalayam', 'Annur']),



      DistrictInfo(name: 'Madurai', lat: 9.9252, lon: 78.1198, mandals: ['Madurai North', 'Madurai South', 'Usilampatti', 'Melur', 'Thirumangalam']),



      DistrictInfo(name: 'Thanjavur', lat: 10.7905, lon: 79.1366, mandals: ['Thanjavur', 'Kumbakonam', 'Papanasam', 'Thiruvayaru', 'Pattukottai']),



    ],



    'Haryana': [



      DistrictInfo(name: 'Gurugram', lat: 28.4595, lon: 77.0266, mandals: ['Gurugram', 'Sohna', 'Pataudi', 'Farukhnagar', 'Manesar']),



      DistrictInfo(name: 'Hisar', lat: 29.1492, lon: 75.7217, mandals: ['Hisar', 'Hansi', 'Barwala', 'Narnaund', 'Agroha']),



      DistrictInfo(name: 'Rohtak', lat: 28.8955, lon: 76.6066, mandals: ['Rohtak', 'Asthal Bohar', 'Kalanaur', 'Meham', 'Makrauli Kalan']),



    ],



    'Chhattisgarh': [



      DistrictInfo(name: 'Raipur', lat: 21.2514, lon: 81.6296, mandals: ['Raipur', 'Abhanpur', 'Arang', 'Dharsiwa', 'Tilda']),



      DistrictInfo(name: 'Bilaspur', lat: 22.0796, lon: 82.1391, mandals: ['Bilaspur', 'Takhatpur', 'Masturi', 'Mungeli', 'Lormi']),



    ],



    'Jharkhand': [



      DistrictInfo(name: 'Ranchi', lat: 23.3441, lon: 85.3096, mandals: ['Ranchi', 'Kanke', 'Ormanjhi', 'Angara', 'Sonahatu']),



      DistrictInfo(name: 'Jamshedpur', lat: 22.8046, lon: 86.2029, mandals: ['Jamshedpur', 'Boram', 'Baharagora', 'Dhalbhumgarh', 'Potka']),



    ],



    'Kerala': [



      DistrictInfo(name: 'Thiruvananthapuram', lat: 8.5241, lon: 76.9366, mandals: ['Thiruvananthapuram', 'Nedumangad', 'Varkala', 'Attingal', 'Neyyattinkara']),



      DistrictInfo(name: 'Ernakulam', lat: 9.9816, lon: 76.2999, mandals: ['Kochi', 'Aluva', 'Kothamangalam', 'Perumbavoor', 'Muvattupuzha']),



      DistrictInfo(name: 'Kozhikode', lat: 11.2588, lon: 75.7804, mandals: ['Kozhikode', 'Vadakara', 'Koyilandy', 'Thamarassery', 'Feroke']),



    ],



    'Assam': [



      DistrictInfo(name: 'Guwahati (Kamrup)', lat: 26.1445, lon: 91.7362, mandals: ['Guwahati', 'Hajo', 'Rangia', 'Palashbari', 'Goroimari']),



      DistrictInfo(name: 'Dibrugarh', lat: 27.4728, lon: 94.9120, mandals: ['Dibrugarh', 'Chabua', 'Duliajan', 'Naharkatia', 'Tingkhong']),



    ],



    'Goa': [



      DistrictInfo(name: 'North Goa', lat: 15.5787, lon: 73.7573, mandals: ['Panaji', 'Mapusa', 'Bicholim', 'Pernem', 'Sattari']),



      DistrictInfo(name: 'South Goa', lat: 15.1736, lon: 74.0200, mandals: ['Margao', 'Mormugao', 'Quepem', 'Sanguem', 'Canacona']),



    ],



    'Himachal Pradesh': [



      DistrictInfo(name: 'Shimla', lat: 31.1048, lon: 77.1734, mandals: ['Shimla', 'Rampur', 'Rohru', 'Chopal', 'Jubbal']),



      DistrictInfo(name: 'Mandi', lat: 31.7083, lon: 76.9337, mandals: ['Mandi', 'Sundernagar', 'Jogindernagar', 'Aut', 'Padhar']),



    ],



    'Uttarakhand': [



      DistrictInfo(name: 'Dehradun', lat: 30.3165, lon: 78.0322, mandals: ['Dehradun', 'Vikasnagar', 'Chakrata', 'Kalsi', 'Doiwala']),



      DistrictInfo(name: 'Haridwar', lat: 29.9457, lon: 78.1642, mandals: ['Haridwar', 'Roorkee', 'Laksar', 'Manglaur', 'Bhagwanpur']),



    ],



    'Arunachal Pradesh': [



      DistrictInfo(name: 'Itanagar', lat: 27.0844, lon: 93.6053, mandals: ['Itanagar', 'Naharlagun', 'Nirjuli', 'Doimukh', 'Banderdewa']),



    ],



    'Manipur': [



      DistrictInfo(name: 'Imphal West', lat: 24.8170, lon: 93.9368, mandals: ['Imphal', 'Patsoi', 'Nambol', 'Yairipok']),



    ],



    'Meghalaya': [



      DistrictInfo(name: 'East Khasi Hills', lat: 25.5788, lon: 91.8933, mandals: ['Shillong', 'Mylliem', 'Mawlai', 'Madanriting']),



    ],



    'Mizoram': [



      DistrictInfo(name: 'Aizawl', lat: 23.7271, lon: 92.7176, mandals: ['Aizawl', 'Darlawn', 'Thingsulthliah', 'Lengpui']),



    ],



    'Nagaland': [



      DistrictInfo(name: 'Kohima', lat: 25.6751, lon: 94.1086, mandals: ['Kohima', 'Zubza', 'Kigwema', 'Jakhama']),



    ],



    'Sikkim': [



      DistrictInfo(name: 'East Sikkim', lat: 27.3314, lon: 88.6138, mandals: ['Gangtok', 'Pakyong', 'Ranka', 'Rhenock']),



    ],



    'Tripura': [



      DistrictInfo(name: 'West Tripura', lat: 23.8303, lon: 91.2868, mandals: ['Agartala', 'Hezamara', 'Mandai', 'Jirania']),



    ],



  };







  /// Get districts for a given state



  static List<DistrictInfo> getDistricts(String state) {



    return districts[state] ?? [];



  }







  /// Get district info by state + district name



  static DistrictInfo? getDistrictInfo(String state, String district) {



    return getDistricts(state).where((d) => d.name == district).firstOrNull;



  }







  /// Default villages (user types custom or picks generic)



  static const List<String> genericVillages = [



    'Agraharam', 'Rayalaseema', 'Kothapeta', 'Indranagar', 'Lakshmipuram',



    'Ramnagar', 'Srinagar', 'Ramanagar', 'Ganesh Nagar', 'Shanti Nagar',



    'Patel Nagar', 'Saraswati Nagar', 'Ambedkar Nagar', 'Gandhi Nagar',



  ];



}



