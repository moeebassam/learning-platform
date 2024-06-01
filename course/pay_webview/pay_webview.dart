import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning/common/routes/names.dart';
import 'package:ulearning/common/values/colors.dart';
import 'package:ulearning/pages/course/pay_webview/bloc/pay_webview_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayWebview extends StatefulWidget {
  const PayWebview({super.key});

  @override
  State<PayWebview> createState() => _PayWebviewPage();
}

class _PayWebviewPage extends State<PayWebview> {
  late final WebViewController webViewController;
  @override
  void initState() {
    super.initState();
    context.read<PayWebviewBloc>().add(UrlChanged(""));
    Future.delayed(Duration.zero, () async{
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      print(args["url"]);
      context.read<PayWebviewBloc>().add(UrlChanged(args["url"]));
    });
  }
  @override
  void dispose() {
    if(webViewController!=null){
      webViewController!.clearCache();
    }

    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   // if (Platform.isAndroid) WebView.platform = AndroidWebView();

    return BlocBuilder<PayWebviewBloc, PayWebviewState>(builder: (context, state) {
      return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.white,
        body: state.url==""?Container():WebView(
          initialUrl: state.url,
          javascriptMode:JavascriptMode.unrestricted,
          javascriptChannels: {
            JavascriptChannel(
                name: 'Pay',
                onMessageReceived: (JavascriptMessage message) {
       
                  print(message.message);
                  Navigator.of(context).pop(message.message);

                })
          },
          onWebViewCreated: (WebViewController w) {
            webViewController = w;
          },

        ),
      );
      ;
    });
  }




  AppBar _buildAppBar() {
    return AppBar(
      title: Container(
        child: Text(
          "Pay Page",
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

}
