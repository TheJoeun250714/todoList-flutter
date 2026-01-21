import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/game_provider.dart';

class BarrierWidget extends StatelessWidget {
  const BarrierWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          alignment: Alignment(game.barrierX, -1.0),
          child: Container(
            width: 200,
            /* 장애물 너비 */
            height: game.barrierHeight,
            // color:Colors.green[700],
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/barrier_vertical_top.png'),
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.none)),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          alignment: Alignment(game.barrierX, 1.1),
          // 장애물을 png 이미지 가져와서 변경
          // 이모지로 변경
          child: Container(
            width: 170,
            height: game.barrierHeight,
            // color:Colors.green[700],
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/barrier_vertical_bottom.png'),
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.none)),
          ),
        ),
      ],
    );
  }
}
