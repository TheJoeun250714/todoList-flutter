// lib/screens/todo_list_screen.dart
// Todo 목록 메인 화면

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/app_styles.dart';
import '../common/constants.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item.dart';

/*
 * TODO: TodoListScreen 위젯 작성
 * 
 * StatefulWidget 상속
 * 
 * initState():
 * - WidgetsBinding.instance.addPostFrameCallback() 사용
 * - TodoProvider의 loadTodos() 호출
 * 
 * _showAddDialog() 메서드:
 * - TextEditingController 생성
 * - AlertDialog 표시
 *   - title: 'New Todo'
 *   - content: TextField (hint: 'What needs to be done?', maxLines: 3)
 *   - actions: 취소, 추가 버튼
 *     - 추가 버튼: provider.addTodo() 호출
 * 
 * build() 메서드:
 * - Scaffold 사용
 * 
 * - AppBar:
 *   - title: AppConstants.appName
 *   - backgroundColor: AppColors.primary
 *   - foregroundColor: Colors.white
 * 
 * - body: Consumer<TodoProvider> 사용
 *   
 *   1. provider.isLoading이면:
 *      - Center에 CircularProgressIndicator 표시
 *   
 *   2. provider.errorMessage가 있으면:
 *      - 에러 아이콘, 메시지, Retry 버튼 표시
 *   
 *   3. provider.todos가 비어있으면:
 *      - 빈 상태 UI 표시 ('No todos yet', 'Tap + to add')
 *   
 *   4. 그 외:
 *      - Column 사용
 *        - 통계 표시 Container (Total, Active, Done)
 *        - Divider
 *        - ListView.builder (RefreshIndicator로 감싸기)
 * 
 * - floatingActionButton:
 *   - onPressed: _showAddDialog() 호출
 * 
 * _buildStatCard() 메서드:
 * - 통계 카드 위젯 반환
 * - 숫자와 라벨 표시
 */

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).loadTodos();
    });
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Todo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'What needs to be done?',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Provider.of<TodoProvider>(context, listen: false)
                    .addTodo(controller.text.trim());
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo List 2026'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.errorMessage != null) {
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
                    provider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => provider.loadTodos(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.todos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No todos yet',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add a new todo',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                      'Total',
                      provider.totalCount.toString(),
                      Colors.blue,
                    ),
                    _buildStatCard(
                      'Active',
                      provider.activeCount.toString(),
                      Colors.orange,
                    ),
                    _buildStatCard(
                      'Done',
                      provider.completedCount.toString(),
                      Colors.green,
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => provider.loadTodos(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: provider.todos.length,
                    itemBuilder: (ctx, index) {
                      return TodoItem(todo: provider.todos[index]);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String label, String count, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}