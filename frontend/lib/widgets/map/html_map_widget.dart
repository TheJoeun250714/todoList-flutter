import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 어플이라해서 chrome 이나 edge 에서 못보는 것이 아님! 방법은 있으나 반대로 app 에서는 안보임
import 'dart:ui_web' as ui_web; // dart:ui_web 기본 모듈을 줄여서 ui_web 변수로 사용하겠다.
import 'dart:html' as html;

class HtmlMapWidget extends StatefulWidget {
  const HtmlMapWidget({super.key});

  @override
  State<HtmlMapWidget> createState() => _HtmlMapWidgetState();
}

class _HtmlMapWidgetState extends State<HtmlMapWidget> {
  final String viewId = 'google-maps-iframe';

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _getMapHtml();
    }
  }

  void _getMapHtml() {
    ui_web.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
      final iframe = html.IFrameElement()
        ..src = ''
        ..style.border = "none"
        ..style.width = '100%'
        ..style.height = '100%'
        ..allowFullscreen = true
        ..setAttribute('loading', 'lazy')
        ..setAttribute('referrerpolicy', 'no-referrer-when-downgrade');
      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey[300]!))),
        child: kIsWeb
            ? HtmlElementView(viewType: viewId)
            : const Center(
                child: Text(
                  "웹 브라우저에서만 지도를 볼 수 있다.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ));
  }
}
