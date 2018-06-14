import 'package:flutter/widgets.dart';
import 'state.dart';

class StateProvider extends InheritedWidget {
  final StateBloc stateBloc;

  StateProvider({
    Key key,
    StateBloc stateBloc,
    Widget child,
  })  : stateBloc = stateBloc ?? StateBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static StateBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(StateProvider) as StateProvider)
          .stateBloc;
}
