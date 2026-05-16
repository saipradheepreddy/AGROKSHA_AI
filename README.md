# AGROKSHA AI 🌾
**Smart Farming. Intelligent Future.**

AGROKSHA AI is a state-of-the-art, production-ready Flutter application designed to empower Indian farmers with real-time intelligence, AI-driven insights, and a secure digital identity.

---

## 🌟 Key Features

- **🤖 Virtual Scientist (AI)**: Real-time, localized farming advice powered by Groq Llama-3 & RAG.
- **☁️ Supabase Integration**: Secure Authentication, real-time Database, and scalable backend orchestration.
- **🌤 Smart Weather Engine**: Hyper-local forecasts and "Safe-to-Spray" predictive windows.
- **📊 Mandi Pulse**: Real-time market trends and MSP 2026 data across 1,000+ APMC locations.
- **🆔 Digi Farm ID**: A sovereign digital identity for farmers with verifiable QR codes.
- **🌐 Multi-Language support**: Full localized support for English, Telugu, and Hindi.
- **🌗 Immersive UI**: Premium Dark Mode and "Rural-First" design philosophy.

---

## 🚀 Technical Stack

- **Frontend**: Flutter (Stable) with Provider for State Management.
- **Backend**: Supabase (PostgreSQL, Auth, Edge Functions).
- **Intelligence**: Groq LPU Inference (Llama-3-70B) & LangChain.
- **Data APIs**: Open-Meteo, Agmarknet, e-NAM.
- **Security**: AES-256 Encryption & Secure Environment Obfuscation (Envied).

---

## 🛠 Setup & Installation

### 1. Prerequisites
- Flutter SDK (>= 3.0.0)
- Supabase Project (URL & Anon Key)

### 2. Environment Configuration
Create a `.env` file in the root directory:
```env
GROQ_API_KEY=your_groq_key
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 3. Run Build Runner
Generate the secure environment variables:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Launch the App
```bash
flutter pub get
flutter run
```

---

## 📁 Architecture Overview

- `lib/services/`: Modular service layer for AI, Supabase, and Weather.
- `lib/utils/app_provider.dart`: Centralized state management and auth logic.
- `lib/models/`: Strongly-typed entity models for farmers and crops.
- `lib/theme/`: Branded "Agroksha" Design System with Material 3.

---

## 🎯 Our Mission
To bridge the digital information gap for 150 million Indian farmers, moving agriculture from a high-risk gamble to a data-driven enterprise.

**Developed with ❤️ by TEAM SARA**
