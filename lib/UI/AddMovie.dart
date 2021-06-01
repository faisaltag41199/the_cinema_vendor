import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class AddMovie extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new AddMovieState();
  }
}

class AddMovieState extends State<AddMovie> {

  //movie data variables
  String movieID;
  String movieTitle;
  String movieDescription;
  String numOfSeats;
  String movieDate;
  String movieImageUrl;

  //variables of functions
  File imageAsFile;
  String pickedDate;
  String pickedTime;

  var moviesRef = FirebaseDatabase.instance.reference().child("Movies");
  var firebaseStorageRef=FirebaseStorage.instance.ref().child("MoviesImages");

  @override
  void initState() {
    imageAsFile=null;
    movieDate=null;

  }

  Future<void> _showMovieExist() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('this id already exist'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  
    Future<void> _selectImageDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      getGalleryImage();
                    },
                    child: Container(
                      child: const Text('Gallery',style: TextStyle(fontSize:20)),
                    ),
                  ),
                  Padding(padding:EdgeInsets.only(bottom: 20.0)),
                  GestureDetector(
                    onTap: () {
                      getCameraImage();
                    },
                    child: Container(
                      child: const Text('Camera',style: TextStyle(fontSize:20)),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed:() {
                Navigator.pop(context);
              }, child: Text('ok',style: TextStyle(fontSize:20)),)
            ],
          );
        },
      );
    }


  getGalleryImage() async {
    PickedFile selectedFile = await ImagePicker().getImage(source:ImageSource.gallery);
    File selected = File(selectedFile.path);
  this.setState(() {
    imageAsFile=selected;
  });
  }
  getCameraImage()async{
    PickedFile selectedFile = await ImagePicker().getImage(source:ImageSource.camera);
    File selected = File(selectedFile.path);
    this.setState(() {
      imageAsFile=selected;
    });
  }

  getMovieDate(BuildContext context) async {

  DateTime dateNow=DateTime.now();
  String fromatedDate;

  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: dateNow,
    firstDate: DateTime(DateTime.now().year),
    lastDate: DateTime(DateTime.now().year+25),
  );

    if (picked != null && picked != dateNow) {
      fromatedDate =DateFormat('dd-MMMM-yyyy').format(picked);
      setState(() {
        pickedDate = fromatedDate;
        getMovieTime(context);
        print(pickedDate);
      });
    }


  }

   getMovieTime(BuildContext context) async{

    TimeOfDay timeNow=new TimeOfDay.now();
    final TimeOfDay picked= await showTimePicker(
      initialTime: timeNow,
      context: context,
    );

    if (picked != null && picked != timeNow) {
      String time=(picked.hour).toString()+':'+(picked.minute).toString();
      setState(() {
        pickedTime = time;
        movieDate =pickedDate+" "+pickedTime;
        print(movieDate);

      });
    }

  }

  saveImageToFirebase() async {

    if(movieID==null || movieID.isEmpty ){

      errorMessage('please enter movie id');

    }else if(movieTitle==null || movieTitle.isEmpty){

      errorMessage('please enter movie title');

    }else if(movieDescription==null || movieDescription.isEmpty){

      errorMessage('please enter movie description');

    }else if(numOfSeats==null || numOfSeats.isEmpty){

      errorMessage('please enter numOfSeats');

    } else if(imageAsFile==null){

      errorMessage('please select image');

    }else if(movieDate==null){

      errorMessage('please select date');

    }else {

      showCircularProgress();
      moviesRef.child(movieID).once().then((snapshot){
        if(snapshot.value != null){
           Navigator.pop(context);
           _showMovieExist();

        }else{
          firebaseStorageRef.child(movieID+movieTitle).putFile(imageAsFile).whenComplete(() {
            firebaseStorageRef.child(movieID+movieTitle).getDownloadURL().then((fileURL) {
              setState(() {
                movieImageUrl = fileURL;
              });
            }).whenComplete(() {
              addMovieToFirebase();
            });
          });
        }

      });

    }
  }

  addMovieToFirebase(){

    moviesRef.child(movieID).set({
      
     "description":movieDescription,
      'image':movieImageUrl,
      'movieTime':movieDate,
      'numberOfSeats':numOfSeats,
      'title':movieTitle
      
    }).whenComplete((){
      Navigator.pop(context);
      confirmMessage();
     
    });

  }


  Future<void> confirmMessage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(width: 100,height: 100,child: Image.asset(
                  'assets/true-mark.png',
                  height: 150,
                  width: 150,
                ),)
                ,
                Text('Movie added successfully')
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context,'/movieList', (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
  
  Future<void> errorMessage(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showCircularProgress() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('adding movie'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Movie'),backgroundColor: Colors.red,),
      body: Container(
        child:ListView(
          children: [
            // id
            Padding(padding: EdgeInsets.only(top: 40.0)) ,
            imageAsFile==null ? Text(' '):
                Container(width: 120,height: 120,child: Image.file(imageAsFile),)
            ,

            Padding(padding: EdgeInsets.only(top: 10.0)) ,

            Row(children: [
              Padding(padding: EdgeInsets.only(left: 5.0)) ,
              Text('ID : ',style: TextStyle(fontSize: 15.0),),
              Container(width: 265.0,child: TextField(
                onChanged: (String idInput){
                  this.setState(() {
                    movieID=idInput;
                  });
                },
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  hintText: 'Enter Movie ID',
                ),
              ) ,)
             ,

            ],),
            // movie title
            Padding(padding: EdgeInsets.only(top: 20.0)) ,
            Row(children: [
              Padding(padding: EdgeInsets.only(left: 5.0)) ,
              Text('Title : ',style: TextStyle(fontSize: 15.0),),
              Container(width: 250.0,child: TextField(
                onChanged: (String titleInput){
                  this.setState(() {
                    movieTitle=titleInput;
                  });
                },
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  hintText: 'Enter Movie Title',
                ),
              ) ,)
              ,

            ],),
            //Description
            Padding(padding: EdgeInsets.only(top: 20.0)) ,
            Row(children: [
              Padding(padding: EdgeInsets.only(left: 5.0)) ,
              Text('Description : ',style: TextStyle(fontSize: 15.0),),
              Container(width: 205.0,child: TextField(
                onChanged: (String descriptionInput){
                  this.setState(() {
                    movieDescription=descriptionInput;
                  });
                },
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  hintText: 'Enter Movie Description',
                ),
              ) ,)
              ,

            ],),
            //Num. of Seats
            Padding(padding: EdgeInsets.only(top: 20.0)) ,
            Row(children: [
              Padding(padding: EdgeInsets.only(left: 5.0)) ,
              Text('Num. of Seats  : ',style: TextStyle(fontSize: 15.0),),
              Container(width: 190.0,child: TextField(
                onChanged: (String seatsNumInput){
                  this.setState(() {
                    numOfSeats=seatsNumInput;
                  });
                },
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  hintText: 'Enter Number of seats',
                ),
              ) ,)
              ,

            ],),
            Padding(padding: EdgeInsets.only(top: 15.0)) ,
            Center(child: Container(width: 150.0,child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () { _selectImageDialog();},
              child: Text('select image'),
            ),),),

            Padding(padding: EdgeInsets.only(top: 15.0)) ,
            Center(child: Container(width: 150.0,child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () { getMovieDate(context); },
              child: Text('select date'),
            ) ,),),

            Padding(padding: EdgeInsets.only(top: 15.0)) ,
            Center(child: Container(width: 150.0,child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () { saveImageToFirebase(); },
              child: Text('add movie'),
            ),),),





          ],

        ) ,

      ),

    );

  }

}