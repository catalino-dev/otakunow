import 'package:flutter/material.dart';
import 'package:otakunow/config/palette.dart';
import 'package:otakunow/widgets/content_item.dart';
import 'package:otakunow/widgets/no_results.dart';

class ContentScroll<T extends ContentItem> extends StatelessWidget {
  final List<T> items;
  final String title;
  final double boxHeight;
  final double boxWidth;
  final Function press;

  ContentScroll({
    this.items,
    this.title,
    this.boxHeight,
    this.boxWidth,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => print('Scroll to the right...'),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
        items.length > 0 ? Container(
          height: boxHeight,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => press(index),
                child: Hero(
                  tag: "background-${items[index].index}",
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    width: boxWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Palette.primaryBg,
                          offset: Offset(0.0, 4.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${items[index].title}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ) : NoResults(),
      ],
    );
  }
}
