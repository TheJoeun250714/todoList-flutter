
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/theme_provider.dart';
import 'common/app_styles.dart';
import 'common/constants.dart';
import 'providers/todo_provider.dart';
import 'screens/todo_list_screen.dart';

/*
 * TODO: main() 함수 작성
 * - runApp(const MyApp()) 호출
 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: themeProvider.themeData,
            home: const TodoListScreen(),
          );
        },
      ),
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TodoProvider())
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme:  ThemeData(
          useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            scaffoldBackgroundColor: AppColors.background
        ),
          home: const TodoListScreen()
      ),
    );
  }
}


 */