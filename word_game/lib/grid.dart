import 'dart:math';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final Function(String) onLetterSelected; // Callback fonksiyon
  Game({required this.onLetterSelected});
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  late List<List<String>> grid; // Grid veri yapısı
  List<String> letters = [
    'A',
    'B',
    'C',
    'Ç',
    'D',
    'E',
    'F',
    'G',
    'Ğ',
    'H',
    'I',
    'İ',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'Ö',
    'P',
    'R',
    'S',
    'Ş',
    'T',
    'U',
    'Ü',
    'V',
    'Y',
    'Z'
  ]; // Rastgele harf seçenekleri
  String selectedWord = ''; // Seçilen kelime
  Set<int> selectedCells =
      Set<int>(); // Seçilen hücrelerin indekslerini tutan küme

  @override
  void initState() {
    super.initState();
    // Gridi başlat
    resetGrid();
  }

  // Gridi sıfırla
  void resetGrid() {
    setState(() {
      grid = List.generate(
          10, (index) => List.generate(8, (index) => getRandomLetter()));
      selectedWord = '';
      selectedCells.clear();
    });
  }

  // Rastgele bir harf seç
  String getRandomLetter() {
    Random random = Random();
    return letters[random.nextInt(letters.length)];
  }

  // Birime basıldığında
  void onCellPressed(int row, int col) {
    final cellIndex = row * 8 + col;
    setState(() {
      if (!selectedCells.contains(cellIndex)) {
        // Eğer hücre daha önce seçilmediyse
        selectedWord += grid[row][col]; // Seçilen harfi kelimeye ekle
        selectedCells.add(
            cellIndex); // Hücrenin indeksini seçilen hücreler kümesine ekle
      } else {
        // Eğer hücre daha önce seçildiyse
        selectedWord = selectedWord.replaceAll(
            grid[row][col], ''); // Seçilen harfi kelimeden çıkar
        selectedCells.remove(
            cellIndex); // Hücrenin indeksini seçilen hücreler kümesinden çıkar
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cellSize = screenWidth / 8;

    return GridView.builder(
      itemCount: 80,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemBuilder: (context, index) {
        final row = index ~/ 8;
        final col = index % 8;
        final cellLetter = grid[row][col];

        return GestureDetector(
          onTap: () {
            String selectedLetter = cellLetter; // Seçilen harf
            widget.onLetterSelected(
                selectedLetter); // Callback fonksiyonunu çağır
            if (cellLetter.isNotEmpty) {
              onCellPressed(row, col);
            }
          },
          child: Container(
            width: cellSize,
            height: cellSize,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: selectedCells.contains(index)
                  ? Colors.green // Seçili hücrenin rengi yeşil
                  : Colors.white, // Diğer hücrelerin rengi beyaz
            ),
            child: Center(
              child: Text(
                cellLetter,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
