import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(
            context: context,
            destinationScreen: WebViewScreen(
              url: article['url'].toString(),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      article['urlToImage'].toString(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),

                    // SizedBox(

                    //   height: 5.0,

                    // ),

                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget businessArticleBuilder(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return RefreshIndicator(
            onRefresh: cubit.businessPullRefresh,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItem(list[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: list.length,
            ),
          );
        },
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );
Widget scienceArticleBuilder(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return RefreshIndicator(
            onRefresh: cubit.sciencePullRefresh,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItem(list[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: list.length,
            ),
          );
        },
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );
Widget sportsArticleBuilder(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return RefreshIndicator(
            onRefresh: cubit.sportsPullRefresh,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItem(list[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: list.length,
            ),
          );
        },
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required String hintTxt,
   Function? validator,
  required Function onChange,
  IconData? suffIcon,
  IconData? preIcon,
  TextInputType? type,
  required BuildContext context,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      suffixIcon: Icon(
        suffIcon,
      ),
      prefixIcon: Icon(
        preIcon,
        color: Theme.of(context).hintColor,
      ),
      focusColor: Colors.deepOrange,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35.0),
        borderSide: const BorderSide(width: 0.8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35.0),
        borderSide: const BorderSide(
          width: 2.0,
          color: Colors.deepOrange,
        ),
      ),
      hintText: hintTxt,
      hintStyle: TextStyle(
        color: Theme.of(context).hintColor,
      ),
      fillColor: Theme.of(context).primaryColor,
      filled: true,

    ),
    validator: (value) {
      return validator!(value);
    },
    onChanged: (value) {
      onChange(value);
    },
    style: TextStyle(
      color: Theme.of(context).hintColor,
    ),
  );
}

void navigateTo({
  required BuildContext context,
  required Widget destinationScreen,
}) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => destinationScreen));
}
