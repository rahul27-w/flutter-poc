import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_movie_db/controller/data_controller.dart';
import 'package:sample_movie_db/model/upcoming_movie_response.dart';
import 'package:sample_movie_db/utils/base_config.dart';
import 'package:sample_movie_db/widget/circular_button.dart';
import 'package:sample_movie_db/widget/custom_widget.dart';
import 'package:sample_movie_db/widget/movie_card_widget.dart';
import 'package:sample_movie_db/widget/shimmer_effect.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  final DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              "Movies DB",
              style: TextStyle(
                color: white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GetX<DataController>(
              init: DataController(),
              builder: (dataController) {
                if (dataController.isLoading.value) {
                  return buildMovieShimmer(context);
                  return ShimmerWidget();
                } else {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          getMoviesSlider('Popular Movies',
                              dataController.popularMovie.value.results),
                          getMoviesSlider('Upcoming Movies',
                              dataController.upcomingMovie.value.results),
                          getMoviesSlider('TopRated Movies',
                              dataController.topRatedMovie.value.results),
                        ],
                      ),
                      Positioned(
                        right: 20,
                        bottom: 20,
                        child: GetBuilder<DataController>(
                            builder: (snapshot) {
                              return Stack(
                                children: [
                                  Transform.translate(
                                    offset: Offset.fromDirection(3 * pi / 2,
                                        snapshot.animation.value * 100),
                                    child: CircularButton(
                                      color: Colors.blue,
                                      width: 60,
                                      height: 60,
                                      icon: Icon(
                                        Icons.group,
                                        color: Colors.white,
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset.fromDirection(5 * pi / 4,
                                        snapshot.animation.value * 100),
                                    child: CircularButton(
                                      color: Colors.green,
                                      width: 60,
                                      height: 60,
                                      icon: Icon(
                                        Icons.translate,
                                        color: Colors.white,
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset.fromDirection(
                                        pi, snapshot.animation.value * 100),
                                    child: CircularButton(
                                      color: Colors.orange,
                                      width: 60,
                                      height: 60,
                                      icon: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                  CircularButton(
                                    color: Colors.red,
                                    width: 60,
                                    height: 60,
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    onTap: () {
                                      if (snapshot
                                          .animationController.isCompleted) {
                                        snapshot.animationController.reverse();
                                      } else {
                                        snapshot.animationController.forward();
                                      }
                                    },
                                  ),
                                ],
                              );
                            }
                        ),
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget buildMovieShimmer(BuildContext context) =>
      ListTile(
        leading: CustomWidget.circular(height: 64, width: 64),
        title: Align(
          alignment: Alignment.centerLeft,
          child: CustomWidget.rectangular(height: 16,
            width: MediaQuery.of(context).size.width*0.3,),
        ),
        subtitle: CustomWidget.rectangular(height: 14),
      );

  Widget getMoviesSlider(String category, List<Result> moviesData) {
    return Column(
      children: [
        Text(
          category,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        MoviesCardWidget(moviesData: moviesData),
        SizedBox(height: 15),
      ],
    );
  }
}
