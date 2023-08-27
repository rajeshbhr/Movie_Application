import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/colors.dart';
import '../../Utils/constants.dart';
import '../descriptionPage/ui/description_page.dart';
import '../favoritesPage/cubit/favorites_cubit.dart';
import '../homePage/cubit/home_cubit.dart';
import '../searchPage/cubit/search_cubit.dart';
import 'custom_text.dart';

class MoviesTile extends StatefulWidget {
  const MoviesTile({
    super.key,
    this.vheight = 153,
    required this.state,
  });
  final double? vheight;
  // ignore: prefer_typing_uninitialized_variables
  final state;

  @override
  State<MoviesTile> createState() => _MoviesTileState();
}

class _MoviesTileState extends State<MoviesTile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(0),
      itemCount: widget.state.movies.length,
      itemBuilder: (context, index) {
        final current = widget.state.movies[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DescriptionPage(currentMovie: current),
                ));
          },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 7.h, bottom: 7.h),
                height: height * 0.153.h,
                width: width * 1.w,
                child: Row(
                  children: [
                    Container(
                      height: height * widget.vheight!.h,
                      width: width * 0.35.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: current.backdropPath != null
                                ? NetworkImage(imageUrl + current.posterPath!)
                                : const NetworkImage(
                                    'https://forums.autodesk.com/t5/image/serverpage/image-id/125177iE9EFA6CFE2DD73AE/image-size/medium?v=mpbl-1&px=-1'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.45.w,
                            child: CustomText(
                              text: current.title ?? '',
                              fontSize: 20,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * 0.35.w,
                                child: CustomText(
                                    text: '⭐ ${current.voteAverage ?? 0}'),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                width: width * 0.47.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.35.w,
                                      child: CustomText(
                                        text: current.releaseDate == ''
                                            ? 'Release Year - NA'
                                            : 'Release Year - ${current.releaseDate?.substring(0, 4)}',
                                        maxLines: 3,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (widget.state is HomeLodedState) {
                                          current.isChecked ?? false
                                              ? context
                                                  .read<HomeCubit>()
                                                  .removeMovie(current, index)
                                              : context
                                                  .read<HomeCubit>()
                                                  .addMovie(current, index);
                                        } else if (widget.state
                                            is SearchLodedState) {
                                          current.isChecked ?? false
                                              ? context
                                                  .read<SearchCubit>()
                                                  .removeMovie(current, index)
                                              : context
                                                  .read<SearchCubit>()
                                                  .addMovie(current, index);
                                        } else if (widget.state
                                            is FavoritesInitial) {
                                          current.isChecked ?? false
                                              ? context
                                                  .read<FavoritesCubit>()
                                                  .removeMovie(current, index)
                                              : context
                                                  .read<FavoritesCubit>()
                                                  .addMovie(current, index);
                                        }
                                      },
                                      child: current.isChecked ?? false
                                          ? const Icon(Icons.favorite)
                                          : const Icon(
                                              Icons.favorite_border_outlined),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: width,
                color: kLight,
                height: 0.35.h,
              )
            ],
          ),
        );
      },
    );
  }
}
