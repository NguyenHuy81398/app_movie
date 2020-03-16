import 'package:app_movie/main.dart';
import 'package:app_movie/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[

              SizedBox(height: 24.0,),

              Container(
                margin: const EdgeInsets.only(top: 2.0, left: 2.0),
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) {
                          return HomePage();
                        }));
                  },
                ),
              ),

              Container(
                child: Center(
                  child: Text("NDH", style: TextStyle(fontSize: 40, fontFamily: "BlackOpsOne-Regular", color: Colors.amberAccent),)
                ),
              ),

              Container(
                width: 310.0,
                height: 260.0,
                margin: const EdgeInsets.only(top: 30.0),
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
                        "Đăng nhập",
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

                    const SizedBox(height: 12.0,),

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
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 12.0,
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            width: 165.0,
                          ),
                          Text(
                            "Quên mật khẩu?",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.amberAccent
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Container(
                margin:
                const EdgeInsets.only(top: 5.0, left: 10.0, right: 20.0),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: false,
                                  onChanged: null,
                                  activeColor: Colors.amberAccent,
                                ),
                                Text(
                                  "Remember me",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.amberAccent),
                                )
                              ],
                            )),
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
                                "ĐĂNG NHẬP",
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
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ;
                                  }));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 100.0,),
                height: 1.0,
                width: 160.0,
                color: Colors.amberAccent,
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return RegisterPage();
                  }));
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text("Đăng ký tài khoản", style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 13.0),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
