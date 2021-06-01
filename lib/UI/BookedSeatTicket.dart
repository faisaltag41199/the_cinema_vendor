import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:the_vendor/DataCloud/TicketData.dart';
import 'package:the_vendor/DataCloud/UserData.dart';
import 'package:the_vendor/UI/MovieList.dart';


class BookedSeatTicket extends StatefulWidget{

  BookedSeatTicket(this.userData,this.ticketData);
  UserData userData;
  TicketData ticketData;
  @override
  State<StatefulWidget> createState() {
     return BookedSeatTicketState(userData,ticketData);
  }


}
class BookedSeatTicketState extends State<BookedSeatTicket>{

  BookedSeatTicketState(this.userData,this.ticketData);
  UserData userData;
  TicketData ticketData;

  var bookSeatsRef = FirebaseDatabase.instance.reference().child("BookedSeats");
  var seatTicketRef = FirebaseDatabase.instance.reference().child("Tickets");
  String numOfTickets='null',numOfSeats='null';




  @override
  void initState() {
    initiateNumOfSeats();
    initiateNumOfTickets();
    super.initState();
  }
  initiateNumOfTickets(){
    List numOfTicketsList=[];
    seatTicketRef.once().then((snapshot){
      Map allTickets=snapshot.value;
      allTickets.forEach((key, value) {
        if(ticketData.movieID==value['movieID']){
          numOfTicketsList.add(value['totalPrice']);
        }
      });

    }).whenComplete((){
              this.setState(() {
         numOfTickets=numOfTicketsList.length.toString();
                  });

    });
  }
  initiateNumOfSeats(){

    List numOfSeatesList=[];
    bookSeatsRef.once().then((snapshot){
      Map allSeats=snapshot.value;
      allSeats.forEach((key, value) {
        if(ticketData.movieID==value['movieID']){
          numOfSeatesList.add(ticketData.movieID);
        }
      });

    }).whenComplete((){
      this.setState(() {
        numOfSeats=numOfSeatesList.length.toString();
      });
    });

  }
  deleteTicket(){
    showDelete();
    seatTicketRef.child(ticketData.ticketID).remove().whenComplete((){

      bookSeatsRef.once().then((DataSnapshot dataSnapshot){

        Map allSeatsRemove=dataSnapshot.value;
        allSeatsRemove.forEach((key, value) {
         if(value['ticketID']==ticketData.ticketID){

        bookSeatsRef.child(key).remove();

         }
        });

      }).whenComplete((){
        Navigator.pop(context);
        showDeleteAccept();
      });

    });


  }

  Future<void> showDelete() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('delete Ticket'),
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

  Future<void> showDeleteAccept() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          content: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 7), child: Text('Ticket deleted successfully')),
            ],
          ),
          actions: [
            TextButton(onPressed: (){

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  MovieList()), (Route<dynamic> route) => false);

            }, child: Text('Ok'))
          ],
        );
      },
    );
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Card(
          color: Colors.white,
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                  child: Image.network(
                    ticketData.image,
                    width: 150.0,
                    height: 150.0,
                  )),
              Text(
                '${ticketData.movieTitle}',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              Text(
                '${ticketData.movieDate}',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              Text(
                'user name: \n ${userData.firstName+' '+userData.firstName} ',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              Center(child: Text(
                'user email:',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),),
              Center(child: Text(
                '${userData.email}',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),),
              Text(
                'user number:\n ${userData.phoneNumber}',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              Text(
                '${ticketData.numOfTickts} seats',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              Text(
                'seats:${ticketData.seatsNum}',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              Text(
                '${ticketData.totalPrice} LE',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              IconButton(icon: Icon(Icons.delete,color:Colors.black ,), onPressed:(){deleteTicket();})
              ,
              Container(
                  margin: EdgeInsets.only(left: 75.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'tickets num :$numOfTickets',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 30.0)),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Seats num :$numOfSeats',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                      ),
                    ],
                  ))

            ],
          ),
        ),
      ),
    );
  }


}

