import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/game_provider.dart';

class BirdWidget extends StatelessWidget {
  const BirdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final birdY = context.watch<GameProvider>().birdY;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      alignment: Alignment(0, birdY),
      child: Container(
        width: 50,
        /* 새 모형의 크기 정사각형 */
        height: 50,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/fly_bird.png'),
                fit: BoxFit.contain, // cover = 50 50 맞추기 contain = 비율 유지
                filterQuality: FilterQuality.none // 픽셀아트의 경우 이 옵션을 추가하면 더 선명
            )),

        // decoration: const BoxDecoration(
        //   color: Colors.yellow,
        //   shape: BoxShape.circle,
        // ),
        //child: const Center(
        // child: Text('🐌', style: TextStyle(fontSize: 30),),

        // ),
      ),
    );
  }
}
