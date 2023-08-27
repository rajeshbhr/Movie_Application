import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/colors.dart';
import '../cubit/search_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: kScaffoldBackgroundColor,
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 200.w,
            child: TextFormField(
              onFieldSubmitted: (value) {
                context.read<SearchCubit>().getSearchMovie(value);
              },
              style: TextStyle(
                  decorationThickness: 0, color: kScaffoldBackgroundColor),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
