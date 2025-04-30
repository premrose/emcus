import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardTabChanged>((event, emit) {
      final currentState = state;
      if (currentState is DashboardLoaded) {
        emit(currentState.copyWith(tabIndex: event.tabIndex));
      } else {
        emit(DashboardLoaded(tabIndex: event.tabIndex));
      }
    });
  }
}
