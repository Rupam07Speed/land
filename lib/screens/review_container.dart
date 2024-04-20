import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:land_registration/constant/app_color.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ReviewsContainer extends StatelessWidget {
  final double pixel;
  const ReviewsContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      // mobile: (BuildContext context) => MobileHomeContainer(),
      desktop: (BuildContext context) => DeskTopReviewContainer(
        pixel: pixel,
      ),
    );
  }
}

class DeskTopReviewContainer extends StatelessWidget {
  final double pixel;
  const DeskTopReviewContainer({super.key, required this.pixel});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h,
      width: w,
      padding: EdgeInsets.symmetric(horizontal: w / 10, vertical: 30),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: pixel >= 3655 ? 1.0 : 0.0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Feedback",
                style: TextStyle(
                  fontSize: w / 20,
                  fontWeight: FontWeight.bold,
                  height: 3,
                ),
              ),
              AnimatedPadding(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.only(left: pixel >= 3866 ? 0 : w / 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customReviewCard(
                      w: w,
                      review:
                          "“I'm a testimonial. Click to edit me and add text that says something nice about you and your services.”",
                      username: "Joan Marks",
                      rating: 4,
                    ),
                    customReviewCard(
                      w: w,
                      review:
                          "“I'm a testimonial. Click to edit me and add text that says something nice about you and your services.”",
                      username: "Raymond Souza",
                      rating: 2.5,
                    ),
                    customReviewCard(
                      w: w,
                      review:
                          "“I'm a testimonial. Click to edit me and add text that says something nice about you and your services.”",
                      username: "Maggie Stalk",
                      rating: 5,
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}

class customReviewCard extends StatelessWidget {
  const customReviewCard({
    super.key,
    required this.w,
    required this.review,
    required this.username,
    required this.rating,
  });

  final double w;
  final String review;
  final String username;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: w * 0.2,
      width: w * 0.2,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              color: AppColors.color1,
              blurRadius: 10,
            ),
            BoxShadow(
                offset: Offset(-1, -1),
                color: AppColors.color1,
                blurRadius: 10),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "แ",
            style: TextStyle(fontSize: 40, color: AppColors.color2),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review,
                style: TextStyle(fontSize: 12, color: AppColors.greyColor),
              ),
              Text(
                username,
                style: TextStyle(fontSize: 16),
              ),
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: rating,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 25,
                itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: AppColors.color2,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
