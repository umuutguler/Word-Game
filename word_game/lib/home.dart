import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'game_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 22, 24, 58),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              child: Text(
                'Başla',
                style: TextStyle(
                  color: Color.fromARGB(255, 22, 24, 58),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Skorlar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text('Yükleniyor...');
                      }
                      final prefs = snapshot.data!;
                      final scoreStrings = prefs.getStringList('scores') ?? [];
                      final scores = scoreStrings.map(int.parse).toList();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final score in scores)
                            Text(
                              score.toString(),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('scores'); // veya prefs.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Skorlar Sıfırlandı')),
                );
              },
              child: Text(
                'Sıfırla',
                style: TextStyle(
                  color: Color.fromARGB(255, 22, 24, 58),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> clearScores() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('scores');
}
