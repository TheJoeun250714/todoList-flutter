import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameCharacter extends StatelessWidget {
  const GameCharacter({super.key});
  @override
  Widget build(BuildContext context) {
    print('🎮 GameCharacter 생성됨 (게임캐릭터 화면을 다시 그리므로 무거운 작업)');
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue, width: 3),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Colors.blue),
            Text('캐릭터', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
