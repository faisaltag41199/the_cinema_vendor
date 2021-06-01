import 'package:flutter/material.dart';
import 'package:the_vendor/DataCloud/MovieData.dart';
import 'package:the_vendor/UI/BookScreen.dart';

//ignore: must_be_immutable
class MovieInfo extends StatefulWidget {
  MovieInfo({@required this.movieData});
  MovieData movieData;
  @override
  MovieInfoState createState() => MovieInfoState(movieData: movieData);
}

class MovieInfoState extends State<MovieInfo> {
  MovieInfoState({@required this.movieData});
  MovieData movieData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title:Text("Movie Info"),
      ),
      body: Center(
          child: ListView(
        children: [
          Column(
            children: [
              Text(
                movieData.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                  child: Image.network(
                movieData.image,
                width: 200.0,
                height: 200,
              ))
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.0),
                width: 600,
                child: Text(
                  movieData.description,
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                movieData.movieTime,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Column(
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookScreen(movieData)),
                  );
                },
                child: Text('show booked seats'),
                color: Colors.red,
              ),
            ],
          ),
        ],
      )),
    );
  }
}
