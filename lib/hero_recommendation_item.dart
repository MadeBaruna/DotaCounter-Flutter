import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HeroRecommendationItem extends StatelessWidget {
  final String name;
  final String codename;
  final String advantage;

  HeroRecommendationItem({Key key, this.name, this.codename, this.advantage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 3.0),
      child: new Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: <Widget>[
            new CachedNetworkImage(
              imageUrl:
                  'http://cdn.dota2.com/apps/dota2/images/heroes/${codename}_full.png',
              placeholder: new Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 34.5,
                  vertical: 15.0,
                ),
                child: new Container(
                  width: 20.0,
                  height: 20.0,
                  child: new CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.grey[500]),
                  ),
                ),
              ),
              height: 50.0,
              width: 89.0,
            ),
            new Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          color: const Color(0x882D3538),
                          child: new Text(
                            name,
                            style: new TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[100],
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        new Text(
                          advantage,
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
