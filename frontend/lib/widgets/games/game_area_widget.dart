import 'package:flutter/cupertino.dart';
import 'package:todo_app/widgets/games/background_widget.dart';
import 'package:todo_app/widgets/games/barrier_widget.dart';
import 'package:todo_app/widgets/games/bird_widget.dart';

class GameArea extends StatelessWidget {
  const GameArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 6,
        child: Stack(
          children: [
            const BackgroundWidget(),
            BirdWidget(),
            BarrierWidget(),
          ],
        ));
  }
}
