import 'package:flutter/material.dart';

import 'hero_item.dart';
import 'state/state.dart';
import 'state/state_provider.dart';

class HeroList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StateBloc state = StateProvider.of(context);

    return StreamBuilder<List<HeroItem>>(
      stream: state.searchResult,
      initialData: [],
      builder: (context, snapshot) => ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                snapshot.data[index],
            itemCount: snapshot.data.length,
          ),
    );
  }
}
