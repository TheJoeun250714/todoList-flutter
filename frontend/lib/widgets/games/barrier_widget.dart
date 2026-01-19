import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/game_provider.dart';

class BarrierWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();

    return Stack(
      children: [
        // TODO: 위쪽 장애물
        AnimatedContainer(
          duration: Duration(milliseconds: 0),
          alignment: Alignment(game.barrierX, -1.0),
          child: Container(
            width: 80, /* 장애물 너비 */
            height: game.barrierHeight,
            color:Colors.green[700],
          ),
        ),

        // TODO: 아래쪽 장애물
        AnimatedContainer(
          duration: Duration(milliseconds: 0),
          alignment: Alignment(game.barrierX, 1.1),
          child: Container(
            width: 80,
            height: game.barrierHeight,
            color:Colors.green[700],
          ),
        ),
      ],
    );
  }
}
