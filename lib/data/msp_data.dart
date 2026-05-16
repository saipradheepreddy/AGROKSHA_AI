/// AGROKSHA AI — MSP 2026 Official Data (CACP Approved)




/// Source: Cabinet Committee on Economic Affairs (CCEA) India




library;









class MspData {




  MspData._();









  /// MSP rates per quintal (100 kg) for Kharif 2026 and Rabi 2026




  static const List<Map<String, dynamic>> crops = [




    // ── KHARIF 2026 ────────────────────────────────────────────────────────




    {




      'name': 'Paddy (Common)',     'nameTE': 'వరి (సాధారణ)',    'emoji': '🌾',




      'msp': 2300, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['AP', 'Telangana', 'Punjab', 'Haryana', 'UP', 'West Bengal', 'Odisha'],




    },




    {




      'name': 'Paddy (Grade A)',    'nameTE': 'వరి (గ్రేడ్ A)',  'emoji': '🌾',




      'msp': 2320, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['AP', 'Telangana', 'Punjab', 'Haryana'],




    },




    {




      'name': 'Cotton (Medium)',    'nameTE': 'పత్తి (మీడియం)',  'emoji': '🌿',




      'msp': 7121, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['Telangana', 'AP', 'Maharashtra', 'Gujarat', 'MP'],




    },




    {




      'name': 'Cotton (Long)',      'nameTE': 'పత్తి (లాంగ్)',   'emoji': '🌿',




      'msp': 7521, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['Gujarat', 'Maharashtra', 'AP'],




    },




    {




      'name': 'Maize',             'nameTE': 'మొక్కజొన్న',     'emoji': '🌽',




      'msp': 2225, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['Telangana', 'Karnataka', 'AP', 'Maharashtra', 'MP'],




    },




    {




      'name': 'Groundnut',         'nameTE': 'వేరుశెనగ',       'emoji': '🥜',




      'msp': 6783, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['AP', 'Telangana', 'Gujarat', 'Rajasthan', 'Tamil Nadu'],




    },




    {




      'name': 'Soybean (Yellow)',  'nameTE': 'సోయాబీన్',       'emoji': '🫛',




      'msp': 4892, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['Maharashtra', 'MP', 'Rajasthan', 'Telangana'],




    },




    {




      'name': 'Bajra (Pearl Millet)', 'nameTE': 'సజ్జలు',      'emoji': '🌾',




      'msp': 2625, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['Rajasthan', 'Haryana', 'UP', 'AP'],




    },




    {




      'name': 'Jowar (Hybrid)',    'nameTE': 'జొన్న (హైబ్రిడ్)', 'emoji': '🌾',




      'msp': 3371, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['Maharashtra', 'Karnataka', 'AP', 'MP'],




    },




    {




      'name': 'Tur / Arhar Dal',  'nameTE': 'కంది పప్పు',      'emoji': '🫘',




      'msp': 7550, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['Maharashtra', 'Telangana', 'AP', 'Karnataka', 'UP'],




    },




    {




      'name': 'Moong (Green Gram)', 'nameTE': 'పెసలు',          'emoji': '🫛',




      'msp': 8682, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['Rajasthan', 'Maharashtra', 'AP', 'Telangana', 'Karnataka'],




    },




    {




      'name': 'Urad (Black Gram)', 'nameTE': 'మినుములు',        'emoji': '🫘',




      'msp': 7400, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['MP', 'Maharashtra', 'AP', 'Telangana'],




    },




    {




      'name': 'Sesame',           'nameTE': 'నువ్వులు',         'emoji': '🌱',




      'msp': 9267, 'season': 'Kharif', 'unit': 'qtl',




      'states': ['AP', 'Telangana', 'Rajasthan', 'MP', 'Gujarat'],




    },




    // ── RABI 2026 ──────────────────────────────────────────────────────────




    {




      'name': 'Wheat',            'nameTE': 'గోధుమలు',          'emoji': '🌾',




      'msp': 2275, 'season': 'Rabi', 'unit': 'qtl',




      'states': ['Punjab', 'Haryana', 'UP', 'MP', 'Rajasthan'],




    },




    {




      'name': 'Barley',           'nameTE': 'బార్లీ',           'emoji': '🌾',




      'msp': 1735, 'season': 'Rabi', 'unit': 'qtl',




      'states': ['Rajasthan', 'Haryana', 'UP', 'MP'],




    },




    {




      'name': 'Gram (Chana)',     'nameTE': 'సెనగలు',           'emoji': '🫘',




      'msp': 5440, 'season': 'Rabi', 'unit': 'qtl',




      'states': ['MP', 'Maharashtra', 'Rajasthan', 'AP', 'Telangana'],




    },




    {




      'name': 'Lentil (Masur)',   'nameTE': 'మసూర్ పప్పు',     'emoji': '🫘',




      'msp': 6425, 'season': 'Rabi', 'unit': 'qtl',




      'states': ['MP', 'UP', 'Bihar', 'Rajasthan'],




    },




    {




      'name': 'Mustard / Rapeseed', 'nameTE': 'ఆవాలు',          'emoji': '🌼',




      'msp': 5650, 'season': 'Rabi', 'unit': 'qtl',




      'states': ['Rajasthan', 'Haryana', 'MP', 'UP'],




    },




    {




      'name': 'Sunflower',        'nameTE': 'పొద్దుతిరుగుడు',  'emoji': '🌻',




      'msp': 7280, 'season': 'Rabi', 'unit': 'qtl',




      'states': ['Karnataka', 'AP', 'Telangana', 'Maharashtra'],




    },




    {




      'name': 'Safflower',        'nameTE': 'కుసుమ',            'emoji': '🌸',




      'msp': 5940, 'season': 'Rabi', 'unit': 'qtl',




      'states': ['Maharashtra', 'Karnataka', 'AP', 'Telangana'],




    },




    {




      'name': 'Sugarcane (FRP)',  'nameTE': 'చెరకు',            'emoji': '🎋',




      'msp': 340, 'season': 'Both', 'unit': 'qtl',




      'states': ['UP', 'Maharashtra', 'Karnataka', 'AP', 'Telangana'],




      'note': 'FRP per quintal — Fair and Remunerative Price',




    },




  ];









  static Map<String, dynamic>? findByName(String name) {




    try {




      return crops.firstWhere(




        (c) => c['name'].toString().toLowerCase().contains(name.toLowerCase()) ||




               (c['nameTE']?.toString() ?? '').contains(name),




      );




    } catch (_) {




      return null;




    }




  }




}




