import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:the_vendor/DataCloud/MovieData.dart';
import 'package:the_vendor/UI/MovieInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  var movieRef = FirebaseDatabase.instance.reference().child("Movies");
  var bookedTicketRef = FirebaseDatabase.instance.reference().child("Tickets");
  var bookedSeatsRef = FirebaseDatabase.instance.reference().child("BookedSeats");

  List<MovieData> AllMoviesList;
  StreamSubscription<Event> onMovieAddedEvent;

  @override
  void initState() {
    super.initState();

    AllMoviesList =[] ;
    onMovieAddedEvent = FirebaseDatabase.instance
        .reference()
        .child('Movies')
        .onChildAdded
        .listen(_onMovieAdded);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    onMovieAddedEvent.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Avaliable Movies",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: new Center(
        child: ListView.builder(
            itemCount: AllMoviesList.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, position) {
              if (AllMoviesList.isNotEmpty) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Image.network(AllMoviesList[position].image,
                            width: 200, height: 200),
                      ),
                      Container(
                         margin:EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              new Text(
                                AllMoviesList[position].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Padding(padding: EdgeInsets.only(top: 8.0)),
                              new Text(
                                AllMoviesList[position].movieTime,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Padding(padding: EdgeInsets.only(top: 8.0)),
                              Row(children: [
                                OutlineButton(
                                    child: new Text("More"),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MovieInfo(
                                                movieData:
                                                AllMoviesList[position])),
                                      );
                                    },
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(30.0))),
                                IconButton(icon: Icon(Icons.delete), onPressed: (){
                                  deleteMovie(position);
                                },color: Colors.red,)

                              ],)
                            ],
                          ))
                    ],
                  ),
                );
              }
              return Text('waiting....');
            }),
      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/addmovie');
          },
          label: const Text('Add Movie'),
          icon: const Icon(Icons.movie),
          backgroundColor: Colors.red,
        )

    );
  }

  _onMovieAdded(Event event) {
    var movieobj = new MovieData();
    movieobj.title = event.snapshot.value['title'];
    movieobj.description = event.snapshot.value['description'];
    movieobj.movieTime = event.snapshot.value['movieTime'];
    movieobj.image = event.snapshot.value['image'];
    movieobj.numberOfSeats = event.snapshot.value['numberOfSeats'];
    movieobj.id = event.snapshot.key;

    this.setState(() {
      AllMoviesList.add(movieobj);
    });
  }

  deleteMovie(int position)async{
    showCircularProgress();
//delete the tickets
    bookedTicketRef.once().then((DataSnapshot dataSnapshot) {
      if(dataSnapshot.value!=null){
      Map<dynamic, dynamic> ticketValue = dataSnapshot.value;
      ticketValue.forEach((key, value) {
        if (value['movieID'] == AllMoviesList[position].id) {
          bookedTicketRef.child(key).remove();
        }
      });
    }
    }).whenComplete((){

      //delete booked seats
      bookedSeatsRef.once().then((DataSnapshot dataSnapshot) {
        if(dataSnapshot.value!=null){
        Map<dynamic, dynamic> seatsValue = dataSnapshot.value;
        seatsValue.forEach((key, value) {
          if (value['movieID'] == AllMoviesList[position].id) {
            bookedTicketRef.child(key).remove();
          }
        });
      }
      }).whenComplete((){

        movieRef.child(AllMoviesList[position].id).remove().whenComplete((){

          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(context,'/movieList', (Route<dynamic> route) => false);
        });

      });
    });
  }

  Future<void> showCircularProgress() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('delete movie'),
          content: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
              CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

}
