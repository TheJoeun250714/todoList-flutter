import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/game_provider.dart';

// TODO 과제: 게임 오버를 감지하고 다이얼로그를 표시하는 위젯 완성하기
//
// 구현해야 할 기능:
// 1. 게임이 진행 중이었다가 멈춘 경우 감지
// 2. 게임 종료 다이얼로그 표시
//    - 시간 종료인지, 목표 달성인지, 게임 오버인지 구분
//    - 최종 점수 표시
//    - 플레이 시간 표시
// 3. "다시 시작" 버튼으로 게임 리셋

class GameOverListener extends StatefulWidget {
  const GameOverListener({super.key});

  @override
  State<GameOverListener> createState() => _GameOverListenerState();
}

class _GameOverListenerState extends State<GameOverListener> {
  bool _wasGameStarted = false;

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();

    if (_wasGameStarted && !game.gameStarted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showGameOverDialog(context, game);
      });
    }

    _wasGameStarted = game.gameStarted;

    return const SizedBox.shrink();
  }

  void _showGameOverDialog(BuildContext context, GameProvider game) {
    // TODO 과제 2: 게임 종료 이유 판단
    // 힌트 1: game.gameTime >= game.targetTime 이면 시간 종료
    if (game.gameTime >= game.targetTime) {
      print("시간종료!");
    } else if (game.score >= game.targetScore) {
      print("목표 달성!");
    } else {
      print("게임 오버!");
    }

    // TODO 과제 3: AlertDialog 작성
    // 힌트: showDialog 함수를 사용하세요
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('게임 종료', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "메세지",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text('플레이 시간 : ${game.gameTime.toStringAsFixed(1)}초')
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              game.resetGame();
            },
            child: const Text("다시 시작"),
          )
        ],
      ),
    );
    // 힌트: AlertDialog의 구성요소
    //   - title: 게임 종료 텍스트
    //   - content: 종료 메시지와 플레이 시간
    //   - actions: 다시 시작 버튼 (game.resetGame() 호출)
  }
}
