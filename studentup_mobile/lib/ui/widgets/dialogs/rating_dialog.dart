import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class StarRatingDialog {
  Future<double> show(
    BuildContext context,
    String premise,
    IconData icon,
  ) async {
    return await showDialog<double>(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) {
        var ratingDialog = RatingDialog(
          icon: Icon(
            icon,
            size: 100,
          ),
          title: premise,
          description:
              "Tap a star to set your rating. Add more description here if you want.",
          submitButton: "SUBMIT",
          alternativeButton: "Contact us instead?", // optional
          positiveComment: "We are so happy to hear :)", // optional
          negativeComment: "We're sad to hear :(", // optional
          accentColor: Colors.red, // optional
          onSubmitPressed: (int rating) =>
              print("onSubmitPressed: rating = $rating"),
          onAlternativePressed: () =>
              print("onAlternativePressed: do something"),
        );
        return ratingDialog;
      },
    );
  }
}
