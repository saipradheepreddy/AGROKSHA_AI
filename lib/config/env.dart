import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'GROQ_API_KEY')
  static final String groqApiKey = _Env.groqApiKey;

  @EnviedField(varName: 'DATA_GOV_IN_API_KEY')
  static final String dataGovInApiKey = _Env.dataGovInApiKey;

  @EnviedField(varName: 'SUPABASE_URL', defaultValue: '')
  static final String supabaseUrl = _Env.supabaseUrl;

  @EnviedField(varName: 'SUPABASE_ANON_KEY', defaultValue: '')
  static final String supabaseAnonKey = _Env.supabaseAnonKey;
}

