
import 'dart:async';


import 'package:expence_tracker/homepage.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
class Firstpage extends StatefulWidget {
  const Firstpage({super.key});
  @override
  State<Firstpage> createState()=> _FirstpageState();
}
class _FirstpageState extends State<Firstpage>{
  void initState(){
    Timer(const Duration(seconds: 5),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>  Homepage(),));
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      
      body: Container(
        
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/im(hj).jpeg"),fit: BoxFit.cover)),
        child: Center(
          child: Lottie.asset("assets/images/Animation - 1732801383559.json",
          width: 350,
          height: 350,
          fit: BoxFit.fill),
          
        ) ,
      )
     
    );
  }
}