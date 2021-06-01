import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_vendor/UI/MovieList.dart';
import 'package:the_vendor/UI/AddMovie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(new MaterialApp(

      home: MovieList(),
      routes:{
        '/addmovie':(context) =>  AddMovie(),
        '/movieList':(context) =>  MovieList(),
      }
  ));
}


