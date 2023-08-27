import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/colors.dart';
import '../../../Utils/constants.dart';
import '../../Widgets/custom_text.dart';
import '../../favoritesPage/cubit/favorites_cubit.dart';
import '../../favoritesPage/ui/favorites_page.dart';
import '../../searchPage/cubit/search_cubit.dart';
import '../../Widgets/movies_tile.dart';
import '../../searchPage/ui/search_page.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  HomeCubit cubit = HomeCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => FavoritesCubit(),
                      child: FavoritesPage(),
                    ),
                  ),
                ).then((value) {
                  setState(() {});
                });
              },
              child: const ListTile(
                leading: Icon(Icons.favorite),
                title: CustomText(
                  text: 'Favourites',
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Popular Movies'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 0.w),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => SearchCubit(),
                      child: const SearchPage(),
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.search,
                size: 30.w,
              ),
            ),
          ),
          PopupMenuButton(
            color: kLight,
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => context.read<HomeCubit>().sortByRating(),
                child: CustomText(
                  text: 'By Rating',
                  color: kDark,
                ),
              ),
              PopupMenuItem(
                onTap: () => context.read<HomeCubit>().sortByPopularity(),
                child: CustomText(
                  text: 'By Popularity',
                  color: kDark,
                ),
              ),
              PopupMenuItem(
                onTap: () => context.read<HomeCubit>().sortByYear(),
                child: CustomText(
                  text: 'By Year',
                  color: kDark,
                ),
              )
            ],
          ),
        ],
        leading: SizedBox(
          width: 100.w,
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: InkWell(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: Icon(
                Icons.menu,
                size: 30.w,
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: cubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeLodingState) {
            
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is HomeLodedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.90.h,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLodingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is HomeLodedState) {
                          return MoviesTile(
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
