import 'package:bloc/bloc.dart';
import 'package:fluttersbaby/src/pages/Choose_Projects.dart';
import 'package:fluttersbaby/src/pages/List_Employees_page.dart';
import 'package:fluttersbaby/src/pages/List_Proyects_page.dart';
import 'package:fluttersbaby/src/pages/home_page.dart';


enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => Boxx();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield Boxx();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield Employees();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield Projects();
        break;
    }
  }
}
