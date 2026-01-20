import 'package:flutter/cupertino.dart';
import 'package:todo_app/widgets/games/background_widget.dart';
import 'package:todo_app/widgets/games/barrier_widget.dart';
import 'package:todo_app/widgets/games/bird_widget.dart';
import 'package:todo_app/widgets/games/game_over_listener.dart';

class GameArea extends StatelessWidget {
  const GameArea({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        flex: 6,
        child: Stack(
          children: [
            // 내부에 객체를 호출할 생성자가 모두다 존재하기 때문에
            // Expanded 옆에서 최상위로 const 사용
            BackgroundWidget(),
            BirdWidget(),
            BarrierWidget(),
            GameOverListener()
            // 화면에 보이지 않는 위젯이지만, 게임 상태를 계속 감시하다가 게임이 종료되면
            // 다이얼로그를 띄워주는 그림자 같은 존재 역할
            // body에서 bird와 barrier 움직임에 따라 나오는 위젯
          ],
        ));
  }
}
