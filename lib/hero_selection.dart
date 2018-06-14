import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meta/meta.dart';

import 'state/state.dart';
import 'state/state_provider.dart';

class HeroSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StateBloc state = StateProvider.of(context);

    return StreamBuilder<List<HeroSelectedItem>>(
      stream: state.selectedHeroes,
      initialData: [],
      builder: (context, snapshot) => Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 5.0,
            runSpacing: 5.0,
            children: snapshot.data,
          ),
    );
  }
}

class HeroSelectedItem extends StatelessWidget {
  final String codename;
  final String name;

  HeroSelectedItem({
    Key key,
    @required this.codename,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StateBloc state = StateProvider.of(context);

    return InkWell(
      onTap: () {
        state.heroState.add(
          HeroAddition(
            add: false,
            codename: codename,
            hero: name,
          ),
        );
      },
      child: Container(
        color: const Color(0xFF222528),
        child: new Padding(
          padding: const EdgeInsets.all(5.0),
          child: CachedNetworkImage(
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
        ),
      ),
    );
  }
}
