import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = 'Welcome to showTime';
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('美好瞬间'),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: 1000,
        child: Column(
          children: <Widget>[
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: 'MM类型',
                  helperText: '请输入你喜欢的类型'),
              autofocus: false,
            ),
            RaisedButton(
              onPressed: _choiceAction,
              child: Text('提交'),
            ),
            Text(
              showText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      )),
    ));
  }

  void _choiceAction() {
    print('开始选择你喜欢的类型............');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text('MM类型不能为空')));
    } else {
      getHttp(typeController.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String typeText) async {
    try {
      Response response;
      var data = {'name': typeText};
      String getUrl = 'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian';
      String postUrl = 'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/post_dabaojian';
      // response = await Dio().get('https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=abc');
      response = await Dio().post(postUrl, queryParameters: data);
      // return print(response);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
