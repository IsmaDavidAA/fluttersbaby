import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';
import '../sidebar/menu_item.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: isSideBarOpenedAsync.data ? 0 : -screenHeight,
          bottom: isSideBarOpenedAsync.data ? 280 : screenHeight - 60,
          left: 0,
          right: 0,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  color: Color(0xFF0f4c81),
                  child: Column(
                    children: <Widget>[
                      MenuItem(
                        icon: Icons.home,
                        title: "Home",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.people,
                        title: "My Employees",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.business,
                        title: "My Projects",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyOrdersClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.calendar_today,
                        title: "Calendario",
                        onTap: () => _selectDate(context),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(1, 0),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: 60,
                      height: 35,
                      color: const Color(0xFF0f4c81),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void _selectDate(BuildContext context) async{
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2023),
    );
  }
}

