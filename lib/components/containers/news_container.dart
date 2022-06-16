import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/screens/news_description.dart';

import '../../controllers/favourite_controller.dart';

class NewsContainer extends StatelessWidget {
  FavouriteController _favController = Get.put(FavouriteController());

  Map data;

  NewsContainer(this.data);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(NewsDescription(data));
      },
      child: buildNewsContainer(context),
    );
  }

  Widget buildNewsContainer(context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text(
              "${data['title']}",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
                // margin: EdgeInsets.symmetric(vertical: 20),
                height: 150,
                child: data['urlToImage'] != null
                    ? Image.network("${data['urlToImage']}")
                    : Image.asset("assets/images/cr7.jpg")),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  textAlign: TextAlign.start,
                  data['author'] != null
                      ? "Author\n${data['author']}"
                      : "Focal Person",
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    data['publishedAt'] != null
                        ? Text("Published at\n${data['publishedAt']}}")
                        : Text("No Date"),
                    GetBuilder<FavouriteController>(builder: (_) {
                      return GetBuilder<FavouriteController>(builder: (_) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: IconButton(
                              onPressed: () {
                                _favController.checkFav(data, context);
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: _favController.containsFavNews(data)
                                    ? Color.fromARGB(255, 225, 0, 0)
                                    : Theme.of(context).colorScheme.onSecondary,
                              )),
                        );
                      });
                    }),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
