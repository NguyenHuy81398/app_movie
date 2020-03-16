import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(

                  child: Center(
                    child: Text("NDH", style: TextStyle(fontSize: 40, fontFamily: "BlackOpsOne-Regular", color: Colors.amberAccent),),
                  ),
                ),

                Container(
                  width: 310.0,
                  height: 412.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 18.0, right: 18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 5.0, left: 5.0),
                        child: Text(
                          "Đăng ký",
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 13.0, fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(fontSize: 9.0),
                                    alignLabelWithHint: true),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Mật khẩu",
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Mật khẩu",
                                hintStyle: TextStyle(fontSize: 9.0),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Họ và tên",
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Họ và tên",
                                hintStyle: TextStyle(fontSize: 9.0),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Số điện thoại",
                              style: TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Số điện thoại",
                                hintStyle: TextStyle(fontSize: 9.0),
                              ),
                              keyboardType: TextInputType.phone,
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                    ],
                  ),
                ),

                Container(
                  margin:
                  const EdgeInsets.only(top: 5.0, left: 10.0, right: 25.0),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: RaisedButton(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                width: 155.0,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xfffff9c4), Color(0xffffd740)],
                                    ),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(
                                  "ĐĂNG KÝ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {

                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

