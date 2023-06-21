import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> isTurkishWord(String word) async {
  Map<String, String> headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
  };

  final response = await http
      .get(Uri.parse('https://sozluk.gov.tr/gts?ara=$word'), headers: headers);

  if (response.statusCode == 200) {
    // API başarıyla cevap verdiyse
    // JSON yanıtı parse edin
    final json = jsonDecode(response.body);
    // JSON yanıtında "error" anahtarının var olup olmadığını kontrol edin
    String jsonString = jsonEncode(json);
    if (!jsonString.contains('error')) {
      return true;
    }
  }
  // Herhangi bir hata durumunda veya kelimenin Türkçe bir kelime olmadığı durumda false döndürün
  return false;
}
