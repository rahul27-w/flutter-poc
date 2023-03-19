import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sample_movie_db/model/upcoming_movie_response.dart';
import 'package:sample_movie_db/utils/base_config.dart';
import 'package:sample_movie_db/utils/constant.dart';

class MoviesCardWidget extends StatelessWidget {
  final List<Result> moviesData;

  const MoviesCardWidget({this.moviesData});

  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: moviesData != null ? moviesData.length : 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 240,
                  width: 160,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '$kImagePath${moviesData[index].posterPath}',
                    placeholder: (context, url) =>
                        Center(child: new CircularProgressIndicator()),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Container(
                  width: 140,
                  child: Text(
                    moviesData[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 17,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
                RatingBarIndicator(
                  rating: moviesData[index].voteAverage / 2,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 25.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
