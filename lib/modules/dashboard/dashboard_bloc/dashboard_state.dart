import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  final int tabIndex;
  const DashboardState({this.tabIndex = 0});
  @override
  List<Object?> get props => [tabIndex];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  const DashboardLoaded({super.tabIndex});
  @override
  List<Object?> get props => [tabIndex];
  DashboardLoaded copyWith({int? tabIndex}) =>
      DashboardLoaded(tabIndex: tabIndex ?? this.tabIndex);
}
