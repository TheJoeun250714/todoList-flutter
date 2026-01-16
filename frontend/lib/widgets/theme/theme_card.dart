import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/providers/theme_provider.dart';
class ThemeCard extends StatelessWidget {
  final ThemeProvider themeProvider;
  final AppThemeType theme;
  final Color color;
  final VoidCallback onPurchaseRequested;

  const ThemeCard(
      {super.key,
      required this.themeProvider,
      required this.theme,
      required this.color,
      required this.onPurchaseRequested});
  @override
  Widget build(BuildContext context) {
    final isSelected = themeProvider.currentTheme == theme;
    final isPurchased = themeProvider.isThemePurchased(theme);
    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(12),
          side: BorderSide(
              color: isSelected ? color : Colors.transparent, width: 2)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.blue.withValues(alpha: 0.3, red: 0.8, green: 0.6, blue: 0.9),
        highlightColor: Colors.grey.withValues(alpha: 0.2),
        onTap: isPurchased
            ? () => themeProvider.changTheme(theme)
            : onPurchaseRequested,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(
                width: 16,
              ),
              // 테마 정보
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    themeProvider.getThemeName(theme),
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  )
                ],
              )
              ),
              // 구매내역에 따른 상태 아이콘 표기
              Icon(
                isSelected
                    ?Icons.check_circle
                    :(isPurchased
                    ?Icons.circle_outlined
                    : Icons.lock_outline
                ),
                color: isSelected ? color : Colors.grey[400],
                size: 28,
              )
            ],
          ),
        ),
      ),
    );
  }
}
