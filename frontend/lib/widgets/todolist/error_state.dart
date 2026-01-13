import 'package:flutter/material.dart';
import 'package:todo_app/widgets/todolist/empty_state.dart';

class ErrorState extends StatelessWidget {
  // flutter 는 변수를 선언하면
  // 생성자 또한 만들어서
  // 필수로 받아야하는 변수나 기능인가
  // 선택적으로 받아도되는 변수나 기능인지
  // 생성자에 반드시 작성!

  final String message;
  final VoidCallback onRetry;

  const ErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            message, //provider.errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onRetry,
            // onPressed: () => provider.loadTodos(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

// TODO: 구현
}
