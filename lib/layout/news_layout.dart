import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import '../modules/business/business_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, NewsStates state) {},
      builder: (BuildContext context, NewsStates state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                      context: context,
                      destinationScreen: const SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeToDarkMode();
                },
                icon:  Icon(
                 cubit.isDark ? Icons.dark_mode : Icons.sunny,
                ),
              ),
            ],
          ),
          body: PageView(
            controller: cubit.pController,
            children: cubit.screens,
            onPageChanged: (index){
              cubit.changeIndex(index);
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
              cubit.pController.animateToPage(cubit.currentIndex, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
