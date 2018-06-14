import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meta/meta.dart';

import 'state/state.dart';
import 'state/state_provider.dart';

class HeroItem extends StatelessWidget {
  final String codename;
  final String name;
  final String hero;
  final String roles;

  HeroItem({
    Key key,
    @required this.codename,
    @required this.name,
    @required this.hero,
    @required this.roles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateBloc state = StateProvider.of(context);

    return Material(
      color: Theme.of(context).primaryColor,
      child: new InkWell(
        onTap: () {
          if (!state.addHero(codename: codename, name: hero, add: true)) {
            Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You already have 5 heroes listed!'),
                  ),
                );
          }
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.grey[500]),
                        ),
                      ),
                    ),
                    height: 50.0,
                    width: 89.0,
                  ),
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            name,
                            style: new TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[100],
                            ),
                          ),
                          new Text(
                            roles,
                            style: new TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              new Divider(
                color: Theme.of(context).accentColor,
                height: 0.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
