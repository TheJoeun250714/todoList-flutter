import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ParticleEffect extends StatelessWidget {
  const ParticleEffect({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('✨ ParticleEffect 생성됨 (이펙트 효과를 다시 그리므로 무거운 작업)');
    }

    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
              (index) => const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.star, color: Colors.yellow, size: 30),
          ),
        ),
      ),
    );
  }
}