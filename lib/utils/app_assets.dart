// ─────────────────────────────────────────────────────────────────────────────



// AGROKSHA AI — App Assets



// Premium Unsplash images for Crops, Vegetables, and Fruits



// ─────────────────────────────────────────────────────────────────────────────







class AppAssets {



  static const _base = 'auto=format&fit=crop&w=400&q=80';







  /// Maps crop/vegetable/fruit names to professional Unsplash images



  static String getCropImage(String cropName) {



    final lower = cropName.toLowerCase();







    // ── CROPS ────────────────────────────────────────────────────────────────



    if (lower.contains('cotton')) {



      return 'https://images.unsplash.com/photo-1595155985012-78a2e1d752aa?$_base';



    }



    if (lower.contains('paddy') || lower.contains('rice')) {



      return 'https://images.unsplash.com/photo-1586771107445-d3afbf0dd1ca?$_base';



    }



    if (lower.contains('maize') || lower.contains('corn')) {



      return 'https://images.unsplash.com/photo-1601314167099-232773b2a54b?$_base';



    }



    if (lower.contains('chilli') || lower.contains('chili')) {



      return 'https://images.unsplash.com/photo-1588012886079-baef00bc03c2?$_base';



    }



    if (lower.contains('groundnut') || lower.contains('peanut')) {



      return 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?$_base';



    }



    if (lower.contains('wheat')) {



      return 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?$_base';



    }



    if (lower.contains('soybean') || lower.contains('soya')) {



      return 'https://images.unsplash.com/photo-1587735243615-c03f25aaff15?$_base';



    }



    if (lower.contains('sunflower')) {



      return 'https://images.unsplash.com/photo-1597848212624-a19eb35e2651?$_base';



    }



    if (lower.contains('turmeric')) {



      return 'https://images.unsplash.com/photo-1615485500704-8e990f9900f7?$_base';



    }



    if (lower.contains('jowar') || lower.contains('sorghum')) {



      return 'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?$_base';



    }



    if (lower.contains('bajra') || lower.contains('millet')) {



      return 'https://images.unsplash.com/photo-1599409636395-20f1f6d16f4a?$_base';



    }



    if (lower.contains('sugarcane')) {



      return 'https://images.unsplash.com/photo-1628524524087-7db7c3b6c9e8?$_base';



    }







    // ── VEGETABLES ───────────────────────────────────────────────────────────



    if (lower.contains('tomato')) {



      return 'https://images.unsplash.com/photo-1524593166156-312f362cada0?$_base';



    }



    if (lower.contains('onion')) {



      return 'https://images.unsplash.com/photo-1518977822534-7049a61ee0c2?$_base';



    }



    if (lower.contains('potato')) {



      return 'https://images.unsplash.com/photo-1518977676405-d449f1a2b9a4?$_base';



    }



    if (lower.contains('brinjal') || lower.contains('eggplant')) {



      return 'https://images.unsplash.com/photo-1615485291109-9cb40e42a804?$_base';



    }



    if (lower.contains('okra') || lower.contains('bhindi')) {



      return 'https://images.unsplash.com/photo-1601575068890-4a4e04e7dfcc?$_base';



    }



    if (lower.contains('cabbage')) {



      return 'https://images.unsplash.com/photo-1564890369478-c89ca3d9cde9?$_base';



    }



    if (lower.contains('cauliflower')) {



      return 'https://images.unsplash.com/photo-1510627498534-cf7e9002facc?$_base';



    }



    if (lower.contains('carrot')) {



      return 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?$_base';



    }



    if (lower.contains('beans')) {



      return 'https://images.unsplash.com/photo-1567375698348-5d9d5ae99de0?$_base';



    }



    if (lower.contains('capsicum') || lower.contains('bell pepper')) {



      return 'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?$_base';



    }



    if (lower.contains('cucumber')) {



      return 'https://images.unsplash.com/photo-1568584711271-6c929fb49b60?$_base';



    }



    if (lower.contains('pumpkin')) {



      return 'https://images.unsplash.com/photo-1570586437263-ab629fccc818?$_base';



    }



    if (lower.contains('spinach')) {



      return 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?$_base';



    }







    // ── FRUITS ───────────────────────────────────────────────────────────────



    if (lower.contains('mango')) {



      return 'https://images.unsplash.com/photo-1591073113125-e46713c829ed?$_base';



    }



    if (lower.contains('banana')) {



      return 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?$_base';



    }



    if (lower.contains('apple')) {



      return 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?$_base';



    }



    if (lower.contains('papaya')) {



      return 'https://images.unsplash.com/photo-1526318472351-c75fcf070305?$_base';



    }



    if (lower.contains('grape')) {



      return 'https://images.unsplash.com/photo-1537640538966-79f369143f8f?$_base';



    }



    if (lower.contains('orange') || lower.contains('sweet lime')) {



      return 'https://images.unsplash.com/photo-1547514701-42782101795e?$_base';



    }



    if (lower.contains('pomegranate')) {



      return 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?$_base';



    }



    if (lower.contains('guava')) {



      return 'https://images.unsplash.com/photo-1627308595229-7830a5c91f9f?$_base';



    }



    if (lower.contains('watermelon')) {



      return 'https://images.unsplash.com/photo-1563114773-84221bd62daa?$_base';



    }



    if (lower.contains('coconut')) {



      return 'https://images.unsplash.com/photo-1581375236434-c516a9f3afc5?$_base';



    }



    if (lower.contains('lemon')) {



      return 'https://images.unsplash.com/photo-1582287014914-1db2e7b8e61b?$_base';



    }



    if (lower.contains('pineapple')) {



      return 'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?$_base';



    }







    // Generic agriculture placeholder



    return 'https://images.unsplash.com/photo-1605000797499-95a51c5269ae?$_base';



  }







  /// Maps crop names to emojis (used as fallback / in chips)



  static String getCropEmoji(String cropName) {



    final lower = cropName.toLowerCase();



    if (lower.contains('cotton')) return '🌿';



    if (lower.contains('paddy') || lower.contains('rice')) return '🌾';



    if (lower.contains('maize') || lower.contains('corn')) return '🌽';



    if (lower.contains('chilli')) return '🌶️';



    if (lower.contains('groundnut') || lower.contains('peanut')) return '🥜';



    if (lower.contains('wheat')) return '🌾';



    if (lower.contains('turmeric')) return '🟡';



    if (lower.contains('sugarcane')) return '🎋';



    if (lower.contains('tomato')) return '🍅';



    if (lower.contains('onion')) return '🧅';



    if (lower.contains('potato')) return '🥔';



    if (lower.contains('brinjal')) return '🍆';



    if (lower.contains('cabbage') || lower.contains('cauliflower')) return '🥦';



    if (lower.contains('carrot')) return '🥕';



    if (lower.contains('cucumber')) return '🥒';



    if (lower.contains('mango')) return '🥭';



    if (lower.contains('banana')) return '🍌';



    if (lower.contains('apple')) return '🍎';



    if (lower.contains('grape')) return '🍇';



    if (lower.contains('orange')) return '🍊';



    if (lower.contains('watermelon')) return '🍉';



    if (lower.contains('coconut')) return '🥥';



    if (lower.contains('lemon')) return '🍋';



    if (lower.contains('pineapple')) return '🍍';



    return '🌱';



  }



}



