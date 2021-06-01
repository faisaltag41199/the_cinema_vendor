import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_vendor/DataCloud/SeatData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:the_vendor/UI//BookScreen.dart';
import 'package:the_vendor/UI/BookedSeatTicket.dart';
import 'package:the_vendor/DataCloud/TicketData.dart';
import 'package:the_vendor/DataCloud/UserData.dart';

//ignore: must_be_immutable
class Seat extends StatefulWidget {
  Seat(
      {@required this.seatnum,
      this.movieTitle,
      this.seatDate,
      this.movieID});

  String seatnum;
  String movieTitle;
  String seatDate;
  String movieID;

  @override
  State<StatefulWidget> createState() {
    return new SeatState(
        seatnum: seatnum,
        movieTitle: movieTitle,
        seatDate: seatDate,
        movieID: movieID);
  }
}

class SeatState extends State<Seat> {
  SeatState(
      {@required this.seatnum,
      this.movieTitle,
      this.seatDate,
      this.movieID});

  String seatnum, movieTitle, seatDate, movieID;
  int seatStatus = 0;
  var seatColor = Colors.red;
  var bookseatData = new SeatData();
  var bookSeatsRef = FirebaseDatabase.instance.reference().child("BookedSeats");
  var seatTicketRef = FirebaseDatabase.instance.reference().child("Tickets");
  var userRef = FirebaseDatabase.instance.reference().child("Users");


  bool isAvaliable = false ;
  DataSnapshot bookedDataSnapshot;

  @override
  void initState() {
    super.initState();

      bookSeatsRef
          .child(movieTitle + seatDate + seatnum)
          .once()
          .then((DataSnapshot dataSnapshot) {
        bookedDataSnapshot = dataSnapshot;
      }).then((value) { seatAvailableStatus();});

  }

  bookedSeatTiket(String ticketId){

    TicketData ticketData=new TicketData();
    UserData userData=new UserData();
    seatTicketRef.child(ticketId).once().then((DataSnapshot snapshot){
      ticketData.movieTitle=snapshot.value['movieTitle'];
      ticketData.movieID=snapshot.value['movieID'];
      ticketData.image=snapshot.value['image'];
      ticketData.movieDate=snapshot.value['movieDate'];
      ticketData.numOfTickts=snapshot.value['numOfTickts'];
      ticketData.seatsNum=snapshot.value['seatsNum'];
      ticketData.totalPrice=snapshot.value['totalPrice'];
      ticketData.userID=snapshot.value['userID'];
      ticketData.ticketID=snapshot.key;
    }).whenComplete((){
      userRef.child(ticketData.userID).once().then((snapshot){
        userData.firstName=snapshot.value['firstname'];
        userData.lastName=snapshot.value['lastname'];
        userData.email=snapshot.value['email'];
        userData.phoneNumber=snapshot.value['phonenumber'];

      }).whenComplete((){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookedSeatTicket(userData,ticketData)),
        );

      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        width: 50,
        height: 50,
        child: RaisedButton(
          color: seatColor,
          onPressed: () {
            print(seatnum + movieTitle + seatDate);
            if (isAvaliable == true) {

              bookSeatsRef.child(movieTitle + seatDate + seatnum).once().then((DataSnapshot snapshot){
                bookedSeatTiket(snapshot.value['ticketID']);

              });

            }else{
              return ;
            }
          },
          child: Text(
            seatnum,
            style: TextStyle(color: Colors.white, fontSize: 8),
          ),
        ),
      ),
    );
  }

  seatAvailableStatus() {
   if (bookedDataSnapshot.value != null) {

        this.setState(() {
          isAvaliable = true;
          seatColor = Colors.grey;
        });

    }
  }

}
