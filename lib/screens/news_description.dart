import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_flutter_hackathon/controllers/home_controller.dart';

import '../controllers/favourite_controller.dart';

class NewsDescription extends StatelessWidget {
  Map newsObj;
  NewsDescription(this.newsObj);
  HomeController _homeController = Get.put(HomeController());
  FavouriteController _favController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    // print("News Desc____________>${newsObj}");

    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Container(
          height: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: IntrinsicHeight(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      "${newsObj['title']}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: newsObj['urlToImage'] != null
                          ? Image.network(newsObj['urlToImage'])
                          : Image.asset(
                              "assets/images/cr7.jpg",
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text("Description")),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: newsObj['content'] != null
                              ? Text("${newsObj['content']}")
                              : Text("No Description Given"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text("Author")),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          child: newsObj['author'] != null
                              ? Text("${newsObj['author']}")
                              : Text("Focal Person"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.primary,
                          thickness: 3,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              newsObj['publishedAt'] != null
                                  ? Text(
                                      "Published at\n${newsObj['publishedAt']}}")
                                  : Text("No Date Given"),
                              GetBuilder<FavController>(builder: (_) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                          .withOpacity(.1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: IconButton(
                                      onPressed: () {
                                        _favController.checkFav(
                                            newsObj, context);
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: _favController
                                                .containsFavNews(newsObj)
                                            ? Color.fromARGB(255, 225, 0, 0)
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                      )),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
