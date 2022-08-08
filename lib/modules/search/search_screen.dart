import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  20.0,
                ),
                child: defaultFormField(
                  context: context,
                    controller: searchController,
                    hintTxt: 'Search',
                    type: TextInputType.text,
                    preIcon: Icons.search,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    onChange: (value) {
                      cubit.getSearch(value);
                    }),

              ),
              Expanded(
                child: articleBuilder(cubit.search,isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
