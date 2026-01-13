// lib/screens/todo_list_screen.dart
// Todo 목록 메인 화면

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/theme_setting_screen.dart';
import 'package:todo_app/widgets/todolist/add_todo_dialog.dart';
import 'package:todo_app/widgets/todolist/error_state.dart';
import 'package:todo_app/widgets/todolist/statistics_bar.dart';
import '../common/app_styles.dart';
import '../common/constants.dart';
import '../providers/todo_provider.dart';
import '../widgets/todolist/empty_state.dart';
import '../widgets/todolist/todo_item.dart';

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
    showDialog(
        context: context,
        builder: (context) => AddTodoDialog(onAdd: (text) {
              Provider.of<TodoProvider>(context, listen: false).addTodo(text);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo List 2026'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeSettingScreen()));
            
          }, icon: const Icon(Icons.palette_outlined))
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.errorMessage != null) {
            return ErrorState(
              message: provider.errorMessage!,
              onRetry: () => provider.loadTodos(),
            );
          }

          if (provider.todos.isEmpty) {
            return const EmptyState(
              icon: Icons.inbox_outlined,
              mainText: 'No todos yet',
              subText: 'Tap + to add a new todo',
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
                    StatisticsBar(
                        totalCount: provider.totalCount,
                        activeCount: provider.activeCount,
                        completedCount: provider.completedCount)
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
}
