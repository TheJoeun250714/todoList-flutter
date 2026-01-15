import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/providers/theme_provider.dart';
/*
onTap = 제스처 감지 위젯 -> 모든 위젯을 클릭 가능하게 만들 수 있음 <a>
     => 개발자가 만든 커스텀 위젯을 클릭 가능하게 만들기 위해서 사용
GestureDetector = 다양한 제스처 감지, 기본 효과 없음
- onTap: () => print("클릭 한 번")         // Button 형태의 위젯이 아니라 커스텀 위젯
- onDoubleTap: () => print("클릭 두 번")
- onLongPress: () => print("길게 누름")
- onPanUpdate: () => print("드래그 중")

====-> Button 태그에는 존재하지 않음
GestureDetector(
  onDoubleTap : 버튼 글자를 두 번 클릭하면 이런 효과를 추가하겠다
  onPanUpdate : 버튼 글자 쪽을 드래그 하면 이런 효과를 주겠다.

   child: ElevatedButton( child:Text("버튼")) # 버튼에서 드래그나 클릭 두번 과 같은 기능 존재하지 않음

)


GestureDetector(
  onTap       : 한 번 클릭   -> Button 이 내부에 존재할 때 사용 지양
  onDoubleTap : 버튼 글자를 두 번 클릭하면 이런 효과를 추가하겠다
  onPanUpdate : 버튼 글자 쪽을 드래그 하면 이런 효과를 주겠다.

   child: ElevatedButton( child:Text("버튼"), onPressed: 한 번 클릭) # 버튼에서 드래그나 클릭 두번 과 같은 기능 존재하지 않음
)

단순 기본 글자가 버튼이 되는 역사적인 순간
GestureDetector(
  onTap       : 한 번 클릭
  onDoubleTap : 버튼 글자를 두 번 클릭하면 이런 효과를 추가하겠다
  onPanUpdate : 버튼 글자 쪽을 드래그 하면 이런 효과를 주겠다.

   child: Container( child:Text("버튼")) 
)

GestureDetector = InkWell = 동일하게 작동하나 InkWell은 splash 효과를 함께 제공 탭 더블탭 길게누르기
InkWell(
  onTap       : 한 번 클릭
  onDoubleTap : 버튼 글자를 두 번 클릭하면 이런 효과를 추가하겠다
  onPanUpdate : 버튼 글자 쪽을 드래그 하면 이런 효과를 주겠다.

   child: Container( child:Text("버튼")) 
)

-> 위와 같이 onTap과 onPressed를 같이 사용할 경우 -> 충돌 발생 -> 둘다 무시되거나, onPressed이 우선적으로 동작

InkWell = 클릭 시 물결 효과, Material Design 스타일

리스트나 카드 같은 UI에는 InkWell 복잡한 제스처 GestureDetector 사용



onPress = 버튼 계열 위젯
TextButton ElevatedButton IconButton 버튼 계열 위젯 사용
*/
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
      required this.onPurchaseRequested}); // void = 반환없이 실행만 Callback 가지고온거 사용

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
        //  테마 선택할 때 구매한 거면 적용 , 구매전이면 구매하기 버튼 호출
        // splashColor: Colors.blue.withOpacity(0.3),
        splashColor: Colors.blue.withValues(alpha: 0.3, red: 0.8, green: 0.6, blue: 0.9),
        // highlightColor: Colors.grey.withOpacity(0.2),
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
