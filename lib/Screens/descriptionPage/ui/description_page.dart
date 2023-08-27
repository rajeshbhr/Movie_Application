import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../Model/movie_model.dart';
import '../../../Utils/constants.dart';
import '../../Widgets/custom_text.dart';

// ignore: must_be_immutable
class DescriptionPage extends StatelessWidget {
  MovieModel currentMovie;
  DescriptionPage({Key? key, required this.currentMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          SizedBox(
            height: 350.h,
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: 350.h,
                    width: width,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${currentMovie.backdropPath!}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: CustomText(
                  text: currentMovie.title!,
                  fontSize: 20.h,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomText(
                text: ' ⭐ Average Rating - ${currentMovie.voteAverage!}',
                fontSize: 17.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${currentMovie.posterPath!}',
                      ),
                    )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: CustomText(
                      text: currentMovie.overview!,
                      fontSize: 15.h,
                      maxLines: 18,
                    ),
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}
