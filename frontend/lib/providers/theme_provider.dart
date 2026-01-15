import 'dart:ui';

import 'package:flutter/material.dart';

enum AppThemeType {
  purple, //무료
  pink, //유료
  blue, //유료
  light,
  dark
}

// 테마가 변경됨을 전체적으로 설정하기 위해 공지하여변경하겠다 클래스를 함께 사용
// class ThemeProvider extends ChangeNotifier {
class ThemeProvider with ChangeNotifier {
  AppThemeType _currentTheme = AppThemeType.purple;

  // 구매한테마로 변경할 수 있게 구매한테마를 담아놓는 변수
  //     기본적으로 구매하지 않은 기본 테마는 누구나 항상 가질 수 있도록
  //              기본적으로 보라 테마를 포함
  // final Set<AppThemeType> _purchasedThemes = {AppThemeType.purple};
  final Set<AppThemeType> _purchasedThemes = {
    AppThemeType.purple,
    AppThemeType.light,
    AppThemeType.dark,
  };

  AppThemeType get currentTheme => _currentTheme;

  bool isThemePurchased(AppThemeType theme) => _purchasedThemes.contains(theme);

  ThemeData get themeData {
    switch (_currentTheme) {
      case AppThemeType.purple:
        return _buildTheme(
            primary: const Color(0xFF6200EE),
            secondary: const Color(0xFF03DAC6));
      case AppThemeType.pink:
        return _buildTheme(
            primary: const Color(0xFFE91E63),
            secondary: const Color(0xFF03DAC6));
      case AppThemeType.blue:
        return _buildTheme(
            primary: const Color(0xFF2196F3),
            secondary: const Color(0xFF00BCD4));
      case AppThemeType.light:
        return _buildTheme(
            primary: const Color(0xFFF5F5F5),
            secondary: const Color(0xFF9E9E9E));
      case AppThemeType.dark:
        return _buildTheme(
            primary: const Color(0xFF212121),
            secondary: const Color(0xFF424242));
    }
  }

  ThemeData _buildTheme({
    required Color primary,
    required Color secondary,
  }) {
    return ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: primary, secondary: secondary),
        scaffoldBackgroundColor:
            const Color(0xFFf3f3f3) // 0xFF = 불투명도 100%   F5F5F5 = hex
        );
  }

  void changTheme(AppThemeType theme) {
    // 만약에 구매한 테마가 있고, 구매한 테마로 변경하겠다 선택하면 전체적으로 테마 교체
    if (_purchasedThemes.contains(theme)) {
      _currentTheme = theme;
      notifyListeners();
    }
  }

  // 테마 구매 = 나중에는 토스 결제 로직이 들어가야한다.
  Future<bool> purchaseTheme(AppThemeType theme) async {
    // 실제 결제 로직 변경하는 구간

    await Future.delayed(const Duration(seconds: 1)); // 결제가 되는 듯한 시뮬레이션

    _purchasedThemes.add(theme);
    notifyListeners();
    return true;
  }

  String getThemeName(AppThemeType theme) {
    switch (theme) {
      case AppThemeType.purple:
        return 'Purple (Default)';
      case AppThemeType.pink:
        return 'Pink Theme';
      case AppThemeType.blue:
        return 'Blue Theme';
      case AppThemeType.light:
        return 'Light Theme';
      case AppThemeType.dark:
        return 'Dark Theme';
    }
  }

  String getThemePrice(AppThemeType theme) {
    switch (theme) {
      case AppThemeType.purple:
        return 'Free';
      case AppThemeType.pink:
        return '2,200';
      case AppThemeType.blue:
        return '3,300';
      case AppThemeType.light:
        return 'Free';
      case AppThemeType.dark:
        return 'Free';
    }
  }
}
