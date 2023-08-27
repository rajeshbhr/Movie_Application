import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'Screens/homePage/cubit/home_cubit.dart';
import 'Screens/homePage/ui/home_page.dart';
import 'Utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 840),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => HomeCubit(),
          child: HomePage(),
        ),
      ),
    );
  }
}
