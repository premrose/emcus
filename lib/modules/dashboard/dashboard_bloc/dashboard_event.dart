import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardTabChanged extends DashboardEvent {
  final int tabIndex;
  DashboardTabChanged(this.tabIndex);
  @override
  List<Object?> get props => [tabIndex];
}
