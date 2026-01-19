// ========================== Provider ==========================
// 게임의 모든 상태와 로직을 관리하는 Provider 클래스
// ChangeNotifier를 상속받아 상태 변경 시 UI 에 알림
import 'dart:async';

import 'package:flutter/cupertino.dart';

class GameProvider extends ChangeNotifier {
  // ============= 게임 상태 변수들 =============

  // 새의 Y축 위치(-1 : 화면 최상단, 0: 중앙, 1: 화면 최하단)
  double birdY = 0;

  // 중력 계산을 위한 시간 변수 (초 단위)
  double time = 0;

  // 새의 현재 높이(물리 계산용)
  double height = 0;

  // 점프 시작 시점의 새 높이(초기값 저장)
  double initialHeight = 0;

  // 게임 시작 여부(true:게임 진행 중, false:대기 중)
  bool gameStarted = false;

  // 현재 점수(장애물을 통과할 때마다 1식 증가)
  int score = 0;

  // 장애물 X축 위치(2: 화면 오른쪽 끝, -2: 화면 왼쪽 끝)
  double barrierX = 2;

  // 장애물의 높이(픽셀 단위)
  double barrierHeight = 200;

  // 게임 루프를 실행하는 타이머 객체
  Timer? _timer;

  // 2-2 ~ 2-6
  // ============= 게임 메서드들 =============
  // 게임을 시작하는 메서드
  // 50ms 마다 게임 상태를 업데이트하는 타이머 시작
  void startGame() {
    gameStarted = true;

    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = initialHeight - 4.9 * time * time;

      // 점프 시작 시점의 새 높이(초기값 저장)
      // 물리 공식으로 높이 계산한 height 사용
      birdY = initialHeight - height;
      if (barrierX < -2) {
        barrierX = 2.5; //오른쪽 끝으로 리셋
        score++; //장애물 피할 때 마다 점수 증가
      } else {
        barrierX -= 0.05; // 장애물 왼쪽으로 지나가는 듯한 이동  처리
      }
      notifyListeners();
      if (_checkGameOver()) {
        stopGame(); // 게임 중
      }
    });
  }

  // 새를 점프시키는 메서드
  // 화면을 탭 할 때마다 호출됨
  void jump() {
    time = 0;
    initialHeight = birdY;
    notifyListeners();
  }

  // 게임 오버 조건을 체크하는 메서드
  // @return true : 게임 오버 flase : 계속 진행
  bool _checkGameOver() {
    if (birdY > 1.0 || birdY < -1.0) return true;
    if (barrierX < 0.2 && barrierX > -0.2) {
      if (birdY < -0.3 || birdY > 0.3) return true;
    }
    return false; // 게임 계속 진행
  }

  // 게임을 중지하는 메서드
  // 타이머를 멈추고 게임 시작 상태를 false로 변경
  void stopGame() {
    _timer?.cancel();
    gameStarted = false; // 게임 중지 상태로 변경 후
    notifyListeners();
  }

  // 게임을 처음 상태로 리셋하는 메서드
  // 게임 종료 후 다시 시작할 때 호출됨
  void resetGame() {
    birdY = 0;
    time = 0;
    height = 0;
    initialHeight = 0;
    gameStarted = false;
    score = 0;
    barrierX = 2;
    notifyListeners();
  }
}
