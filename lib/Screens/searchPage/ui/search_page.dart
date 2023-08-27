import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/constants.dart';
import '../../Widgets/movies_tile.dart';
import '../cubit/search_cubit.dart';
import '../widgets/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
        centerTitle: true,
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SearchInitial) {
            return const CustomSearchBar();
          } else if (state is SearchLodingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is SearchLodedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const CustomSearchBar(),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: height * 0.80.h,
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if (state is SearchLodedState) {
                          return MoviesTile(
                            vheight: 145,
                            state: state,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
