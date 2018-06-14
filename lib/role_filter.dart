import 'package:flutter/material.dart';
import 'state/state.dart';
import 'state/state_provider.dart';
import 'hero_selection.dart';

class RoleFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StateBloc state = StateProvider.of(context);
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        border: new Border(top: BorderSide(color: const Color(0xFF353A3d))),
        color: Theme.of(context).primaryColor,
      ),
      child: StreamBuilder<List<HeroSelectedItem>>(
        stream: state.selectedHeroes,
        initialData: [],
        builder: (context, selected) => StreamBuilder<List<bool>>(
              stream: state.filter,
              initialData: [true, true, true, true, true],
              builder: (context, snapshot) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: selected.data.length == 0
                        ? <Widget>[
                            Text(
                              'Dota Counter for Dota 7.17',
                              style: TextStyle(color: Colors.grey[500]),
                            )
                          ]
                        : <Widget>[
                            FilterButton(
                              icon:
                                  snapshot.data[0] ? Icons.check : Icons.clear,
                              text: 'Carry',
                              onTap: () {
                                state.filterState
                                    .add(FilterValue(0, !snapshot.data[0]));
                              },
                            ),
                            FilterButton(
                              icon:
                                  snapshot.data[1] ? Icons.check : Icons.clear,
                              text: 'Support',
                              onTap: () {
                                state.filterState
                                    .add(FilterValue(1, !snapshot.data[1]));
                              },
                            ),
                            FilterButton(
                              icon:
                                  snapshot.data[2] ? Icons.check : Icons.clear,
                              text: 'Disabler',
                              onTap: () {
                                state.filterState
                                    .add(FilterValue(2, !snapshot.data[2]));
                              },
                            ),
                            FilterButton(
                              icon:
                                  snapshot.data[3] ? Icons.check : Icons.clear,
                              text: 'Initiator',
                              onTap: () {
                                state.filterState
                                    .add(FilterValue(3, !snapshot.data[3]));
                              },
                            ),
                            FilterButton(
                              icon:
                                  snapshot.data[4] ? Icons.check : Icons.clear,
                              text: 'Durable',
                              onTap: () {
                                state.filterState
                                    .add(FilterValue(4, !snapshot.data[4]));
                              },
                            ),
                          ],
                  ),
            ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  FilterButton({
    this.icon,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(3.0),
      child: InkWell(
        onTap: onTap,
        child: new Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Icon(
                  icon,
                  color: Colors.grey[300],
                  size: 14.0,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
