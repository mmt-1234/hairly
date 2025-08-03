import 'dart:io';

import 'package:flutter/material.dart';
import 'HairstyleSimulation.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double vw = MediaQuery.of(context).size.width;
    if(500<vw){
      vw=500;
    }
    final double vh =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight; // AppBar 높이;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('hairly',
            style: TextStyle(
              color: Colors.black,
              fontSize: vw/12,
              fontFamily: 'Pacifico',

            ),  ),
          actions:[
             IconButton(onPressed: (){},
                 icon:Image.asset('assets/icons/premium.png',width: vw/12,height:vw*5/64,fit: BoxFit.cover,),iconSize: vw*5/64,),
            IconButton(onPressed: (){}, icon: Icon(Icons.settings,size:vw/12))
          ] ,
        ),
        body: Expanded(
          child: Container(
            width: vw,
            height: vh,
            child: Column(
              children: [
                Container(
                  color: Colors.red,
                  height: vh/5,
                  margin: EdgeInsets.fromLTRB(0, vh/20, 0, 0),
                ),
                Container(
                  width: vw*0.85,
                  height: vh*0.3,
                  child: Row(
                    spacing: vw/20,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex:1,
                        fit:FlexFit.tight,
                        child: Container(
                          width: vw,
                          height: vh*0.15,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(vw/20),
                          ),
                          child: TextButton(
                            child:Text('헤어스타일\n시뮬레이션',
                              style: TextStyle(
                              color: Color(0xFF151515),
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.bold,
                              fontSize: vw/25,
                            ),),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HairstyleSimulation()));
                            },
                          ),
                        ),
                      ),

                      Flexible(
                        fit:FlexFit.tight,
                        flex: 1,
                        child: Container(
                          height: vh*0.15,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(vw/20),
                          ),
                          child: TextButton(
                            child:Text('헤어 추천',
                            style: TextStyle(
                              color: Color(0xFF151515),
                              fontFamily: 'NotoSansKR',
                              fontSize: vw/23,
                              fontWeight: FontWeight.bold,
                            ),),
                            onPressed: (){},
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Container(
                          height: vh*0.15,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(vw/20),
                          ),
                         child: TextButton(
                            child:Text('다이어트\n시뮬레이션',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF151515),
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.bold,
                            fontSize: vw/25,
                          ),),
                            onPressed: (){},
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  color: Colors.green,
                  height: vh/4,
                  width:vw,
                  child: Column(
                    children: [
                      Text('컷'),
                      Row(

                      )
                    ],
                  ),
                )
              ],
            )
          ),
        )
      ),
    );
  }
}