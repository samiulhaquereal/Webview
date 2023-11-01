import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse('https://www.prothomalo.com'));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        var isLastPage = controller.canGoBack();
        if(await isLastPage){
          controller.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(child: Scaffold(
        appBar: AppBar(title: Text('Webview'),),
        body: WebViewWidget(controller: controller),
      )),
    );
  }
}
