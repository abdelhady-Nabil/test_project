import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/login_screen.dart';
import 'package:project2/signup_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset('assets/heart.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('M+ ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),

                          Text('Transforming ',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),

                          Text('Healthcare ',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),

                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                            },

                            child: Container(
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blueAccent
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Sign in ',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ],
                              ),
                            ),
                          )
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                            },
                            child: Container(
                              height: 75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blueAccent
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Sign Up ',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ],
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
