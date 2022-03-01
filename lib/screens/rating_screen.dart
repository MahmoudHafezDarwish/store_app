import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';

import '../data/app_review_database_helper.dart';
import '../models/AppReview.dart';
import '../widgets/app_review_dialog.dart';

class RatingScreen extends StatelessWidget {
   RatingScreen({Key key}) : super(key: key);
  dynamic result = 0 ;
   AppReview appReview = AppReview(FirebaseAuth.instance.currentUser.uid,);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text('Payment Successful'),
      ),
      body: Center(
        child: Container(
          width: 319,
          height: 320,
          color: Colors.white,
          margin: EdgeInsetsDirectional.only(start: 28, end: 28, top: 40),
          child: Column(
            children: [
              Text(
                "How was your order",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 22,
                  fontFamily: "Besley-Regular",
                  color: Colors.black,
                ),
              ),
              Text(
                "experiences from it Momma?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 22,
                  fontFamily: "Besley-Regular",
                  color: Colors.black,
                ),
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.blueAccent,
                ),
                onRatingUpdate: (rating) {
                  result = rating;
                  appReview.feedback = "$rating";
                  print(rating);
                },
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsetsDirectional.all(20),
                  onPressed: ()async {

                    submitRting(context, appReview);
                    // submitAppReview(context);
                    // Navigator.pushNamed(context, "/HistoryOrderScreen");
                  },
                  color: Colors.lightBlue,
                  textColor: Colors.white70,
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      fontFamily: "Besley-Regular",
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              FlatButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'Not now!',

                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: "Besley-Bold",
                    color: Colors.black.withOpacity(0.5),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> submitRting(BuildContext context ,AppReview result )async{
    bool reviewAdded = false;

    if (result != null){
      String snackbarMessage;
      try {
        reviewAdded = await AppReviewDatabaseHelper().editAppReview(result);
        if (reviewAdded == true) {
          snackbarMessage = "Feedback submitted successfully";
        } else {
          throw "Coulnd't add feeback due to unknown reason";
        }
      } on FirebaseException catch (e) {
        Logger().w("Firebase Exception: $e");
        snackbarMessage = e.toString();
      } catch (e) {
        Logger().w("Unknown Exception: $e");
        snackbarMessage = e.toString();
      } finally {
        Logger().i(snackbarMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage),
          ),
        );
      }
    }

    return reviewAdded;
  }


  Future<void> submitAppReview(BuildContext context,
      {bool liked = true}) async {
    AppReview prevReview;
    try {
      prevReview = await AppReviewDatabaseHelper().getAppReviewOfCurrentUser();
    } on FirebaseException catch (e) {
      Logger().w("Firebase Exception: $e");
    } catch (e) {
      Logger().w("Unknown Exception: $e");
    } finally {
      if (prevReview == null) {
        prevReview = AppReview(
          FirebaseAuth.instance.currentUser.uid,
          liked: liked,
          feedback: "",
        );
      }
    }

    final AppReview result = await showDialog(
      context: context,
      builder: (context) {
        return AppReviewDialog(
          appReview: prevReview,
        );
      },
    );
    if (result != null) {
      result.liked = liked;
      bool reviewAdded = false;
      String snackbarMessage;
      try {
        reviewAdded = await AppReviewDatabaseHelper().editAppReview(result);
        if (reviewAdded == true) {
          snackbarMessage = "Feedback submitted successfully";
        } else {
          throw "Coulnd't add feeback due to unknown reason";
        }
      } on FirebaseException catch (e) {
        Logger().w("Firebase Exception: $e");
        snackbarMessage = e.toString();
      } catch (e) {
        Logger().w("Unknown Exception: $e");
        snackbarMessage = e.toString();
      } finally {
        Logger().i(snackbarMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage),
          ),
        );
      }
    }
  }
}
