import 'dart:math';
import 'dart:async';
import 'package:tuple/tuple.dart';

void main() {
  List<List<Tuple2<String, int>>> grid = [
    [
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0)
    ],
    [
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0)
    ],
    [
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0)
    ],
    [
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0)
    ],
    [
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0)
    ],
    [
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0)
    ],
    [
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0)
    ],
    [
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0)
    ],
    [
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0)
    ],
    [
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0),
      Tuple2<String, int>('', 0)
    ],
  ];

  // Oyun başlangıcında 3 satır harf ekle
  for (int i = 7; i < 10; i++) {
    for (int j = 0; j < 8; j++) {
      String firstRandomLetter =
          String.fromCharCode(Random().nextInt(26) + 'A'.codeUnitAt(0));
      grid[i][j] = [firstRandomLetter, 1] as Tuple2<String, int>;
    }
  }

  bool gameover = true;
  double startTime = DateTime.now().millisecondsSinceEpoch.toDouble();
  while (gameover) {
    // harfleri en alta yerleştir
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 9; j++) {
        if (grid[j][i].item2 > grid[j + 1][i].item2) {
          // 0.5 saniyede bir kutucu yer değiştir
          print(grid);
          print('--------------------');
          Future.delayed(Duration(milliseconds: 500), () {
            var a = grid[j][i];
            grid[j][i] = grid[j + 1][i];
            grid[j + 1][i] = a;
          });
        }
      }
    }

    // yeni kutu İlk satıra yeni harf yerleştir
    Future.delayed(Duration(seconds: 4), () {
      int random = Random().nextInt(8);
      String randomLetter =
          String.fromCharCode(Random().nextInt(26) + 'A'.codeUnitAt(0));
      grid[0][random] = [randomLetter, 1] as Tuple2<String, int>;
      print('yeni kutu eklendi');
    });

    // oyunun bitişini sütünlarn dolu olma durumu kontrol et
    for (var i = 0; i < 8; i++) {
      var endControl = 0;
      for (var j = 0; j < 10; j++) {
        if (grid[j][i].item2 == 1) {
          endControl += 1;
        }
        if (endControl == 10) {
          gameover = false;
        }
      }
    }
  }
}
