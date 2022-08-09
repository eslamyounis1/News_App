import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

import '../../.env.dart';
import '../../modules/business/business_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  PageController pController = PageController();
  var screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
    const SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_football,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    if (index == 1) {
      getScience();
    } else if (index == 2) {
      getSports();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.isEmpty) {
      DioHelper.getData(
        methodUrl: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'business',
          'apiKey': apiKey,

        },
      ).then((value) {
        // print(value.data['articles'][0]['title']);
        business = value.data['articles'];
        print(business[0]['title']);

        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        methodUrl: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': apiKey,
        },
      ).then((value) {
        // print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        methodUrl: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': apiKey,
        },
      ).then((value) {
        // print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  bool isDark = false;

  void changeToDarkMode({fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeDarkModeState());
    } else {
      isDark = !isDark;
      CashHelper.setBooleanData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeDarkModeState());
      });
    }
  }

  // search method
  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
      methodUrl: 'v2/everything',
      query: {
        'q': value,
        'apiKey': apiKey,
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  // pull refresh function
  List<dynamic> refreshedList = [];
  Future<void> pullRefresh() async{
    // List<dynamic> refreshed
    emit(NewsGetBusinessLoadingState());

      DioHelper.getData(
        methodUrl: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'business',
          'apiKey': apiKey,
          'pageSize': 30,


        },
      ).then((value) {
        // print(value.data['articles'][0]['title']);
        business = value.data['articles'];
        business = List.from(business.reversed);
        print(business[0]['title']);

        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsGetBusinessErrorState(error.toString()));
      });
    emit(NewsRefreshState());
  }
}
