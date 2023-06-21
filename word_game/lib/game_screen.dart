import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yazlab2_2/home.dart';
import 'grid.dart';
import 'iswordexist.dart';
import 'package:turkish/turkish.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> selectedLetters = []; // Seçilen harfleri tutacak liste
  int score = 0;
  List<int> scores = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      scores = prefs.getStringList('scores')?.map(int.parse).toList() ?? [];
    });
  }

  // Callback fonksiyonu, seçilen harfleri günceller
  void _onLetterSelected(String letter) {
    setState(() {
      selectedLetters.add(letter.toLowerCaseTr());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.187,
            color: Color.fromARGB(255, 22, 24, 58),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenWidth * 0.4,
                    child: Center(
                      child: Text(
                        '$score',
                        style: TextStyle(
                          fontSize: screenWidth * 0.2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenWidth * 0.02,
                  left: screenWidth * 0.02,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Oyun Bitti!'),
                            content: Text('Puanınız: $score'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  // Step 1: SharedPreferences'dan scores listesini al.
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  final scores = prefs
                                          .getStringList('scores')
                                          ?.map(int.parse)
                                          .toList() ??
                                      [];
                                  // Yeni score ekle.
                                  scores.add(score);
                                  // scores listesini sırala
                                  scores.sort((a, b) => b.compareTo(a));
                                  // sıralanmış listeyi kaydet
                                  await prefs.setStringList('scores',
                                      scores.map((e) => e.toString()).toList());
                                  // durumu güncelle
                                  setState(() {});
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                },
                                child: Text('Tamam'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  // Step 1: SharedPreferences'dan scores listesini al.
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  final scores = prefs
                                          .getStringList('scores')
                                          ?.map(int.parse)
                                          .toList() ??
                                      [];
                                  // Yeni score ekle.
                                  scores.add(score);
                                  // scores listesini sırala
                                  scores.sort((a, b) => b.compareTo(a));
                                  // sıralanmış listeyi kaydet
                                  await prefs.setStringList('scores',
                                      scores.map((e) => e.toString()).toList());
                                  // durumu güncelle
                                  setState(() {});
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameScreen()),
                                  );
                                },
                                child: Text('Tekrar Oyna'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth,
            height: screenWidth * 1.4,
            color: Color.fromARGB(255, 15, 16, 39),
            child: Game(
              onLetterSelected:
                  _onLetterSelected, // Callback fonksiyonunu Game widget'ına aktar
            ),
          ),
          Container(
            height: screenHeight * 0.06,
            color: Color.fromARGB(255, 22, 24, 58),
            child: Row(
              children: [
                Container(
                  width: screenHeight * 0.06,
                  height: screenHeight * 0.06,
                  color: Colors.red,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        selectedLetters
                            .clear(); // selectedLetters listesini sıfırla
                      });
                    },
                  ),
                ),
                Container(
                  height: screenHeight * 0.06,
                  width: screenWidth - screenHeight * 0.12,
                  child: Center(
                    child: Text(
                      selectedLetters
                          .join(), // "selectedLetters" listesini stringe dönüştür

                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenHeight * 0.06,
                  height: screenHeight * 0.06,
                  color: Colors.green,
                  child: IconButton(
                    icon: const Icon(Icons.check),
                    color: Colors.white,
                    onPressed: () async {
                      String selectedWord = selectedLetters.join(
                          ""); // Seçili harfleri birleştirerek kelime oluştur
                      bool isTurkish = await isTurkishWord(selectedWord);
                      if (isTurkish) {
                        setState(() {
                          score +=
                              100; // Eğer seçili kelime listede varsa, score'u 100 artır
                        });
                      } else {
                        setState(() {
                          score -=
                              20; // Eğer seçili kelime listede yoksa, score'u 20 azalt
                        });
                      }
                      selectedLetters
                          .clear(); // selectedLetters listesini sıfırla
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 22, 24, 58),
            ),
          ),
        ],
      ),
    );
  }
}
