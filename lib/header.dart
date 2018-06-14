import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'state/state.dart';
import 'state/state_provider.dart';
import 'splash.dart';

class Header extends AppBar implements StatefulWidget {
  Header({Key key})
      : super(
          elevation: 0.0,
          title: SearchBar(),
          titleSpacing: 5.0,
        );
}

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = new TextEditingController();
  StateBloc stateBloc;

  IconData _icon = Icons.search;

  @override
  void initState() {
    super.initState();

    _textController.addListener(_toggleIcon);
  }

  @override
  void dispose() {
    _textController.removeListener(_toggleIcon);
    _textController.dispose();
    super.dispose();
  }

  void _toggleIcon() {
    stateBloc.queryState.add(_textController.text);

    setState(() {
      if (_textController.text.length > 0) {
        _icon = Icons.clear;
      } else {
        _icon = Icons.search;
      }
    });
  }

  void _clearSearch() {
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    stateBloc = StateProvider.of(context);
    stateBloc.query.listen((item) {
      if (item == '') {
        _textController.clear();
      }
    });

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(_icon),
          onPressed: () {
            _clearSearch();
          },
        ),
        Flexible(
          child: new Theme(
            data: new ThemeData(splashFactory: const NoSplashFactory()),
            child: TextField(
              controller: _textController,
              style: new TextStyle(
                fontSize: 18.0,
                color: Colors.grey[200],
              ),
              decoration: new InputDecoration(
                hintText: 'Hero name...',
                hintStyle: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[300],
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
