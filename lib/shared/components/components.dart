import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
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

Widget articleBuilder(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required String hintTxt,
  required Function validator,
  required Function onChange,
  IconData? suffIcon,
  IconData? preIcon,
  TextInputType? type,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      suffix: Icon(
        suffIcon,
      ),
      prefixIcon: Icon(
        preIcon,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      hintText: hintTxt,
    ),
    validator: (value) {
      return validator(value);
    },
    onChanged: (value) {
      onChange(value);
    },
  );
}

void navigateTo({
  required BuildContext context,
  required Widget destinationScreen,
}) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => destinationScreen));
}
