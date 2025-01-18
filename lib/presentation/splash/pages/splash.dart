// import 'package:finku/core/configs/assets/app_images.dart';
import 'package:finku/common/helper/navigation/app_navigation.dart';
import 'package:finku/core/configs/assets/app_vectors.dart';

import 'package:finku/presentation/navigation/pages/navigation.dart';
import 'package:finku/presentation/splash/bloc/splash_cubit.dart';
import 'package:finku/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
          
            AppNavigator.pushReplacement(context, const NavigationPage());
          
      },
        child: Center(
          child: SvgPicture.asset(
            // AppVectors.logo,
            AppVectors.logo,
            height: 150, 
            
            ),
        ),
      ),
    );
  }
}
