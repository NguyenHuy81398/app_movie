import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model.dart';

CarouselSlider carouselSlider(BuildContext context, List<Video> list){
    return CarouselSlider(
      autoPlay: true,
      viewportFraction: 1.05,
      aspectRatio: 2.2,
      items: list.map((video){
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(video.avatar),
                  fit: BoxFit.cover
              )
          ),
        );
      }).toList(),
    );
  }