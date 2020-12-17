import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  CustomBottomNavBar({this.defaultSelectedIndex = 0, @required this.onChange});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedItem = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedItem = widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildNavBarItem(
          Icons.home,
          0,
        ),
        buildNavBarItem(
          Icons.search,
          1,
        ),
        buildNavBarItem(
          Icons.history,
          2,
        ),
        buildNavBarItem(
          Icons.settings,
          3,
        ),
      ],
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedItem = index;
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width / 4,
        decoration: index == _selectedItem
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 4,
                    color: Theme.of(context).accentColor.withOpacity(1),
                  ),
                ),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor.withOpacity(0.4),
                    Theme.of(context).accentColor.withOpacity(0.015),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                color: Theme.of(context).primaryColor,
              )
            : BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItem
              ? Theme.of(context).iconTheme.color
              : Theme.of(context).iconTheme.color.withOpacity(0.6),
        ),
      ),
    );
  }
}
