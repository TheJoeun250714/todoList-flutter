import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/game_provider.dart';

// 점수를 표시하는 위젯
// 게임 시작 전에는 탭하여 시작 게임 중에는 현재 점수 표시
class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();

    return Expanded(
      flex: 1,
      child: Container(
          color: Colors.blue[300],
          child: Center(
              child: game.gameStarted
                  ? Column(children: [
                      Text(
                        game.gameStarted ? '점수 :${game.score}' : '탭하여 시작',
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '시간 : ${game.remainingTime.toStringAsFixed(1)}',
                        style: const TextStyle(
                            fontSize: 30, color: Colors.white70),
                      ),
                      Text(
                        '목표 : ${game.targetScore}점',
                        style: const TextStyle(
                            fontSize: 30, color: Colors.white60),
                      ),
                    ])
                  : const Text(
                      '탭하여 시작',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ))),
    );
  }
}
