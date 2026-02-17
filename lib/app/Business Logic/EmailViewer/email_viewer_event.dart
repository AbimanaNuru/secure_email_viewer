import 'package:equatable/equatable.dart';

abstract class EmailViewerEvent extends Equatable {
  const EmailViewerEvent();
  @override
  List<Object> get props => [];
}

class LoadEmailEvent extends EmailViewerEvent {
  const LoadEmailEvent(this.path);
  final String path;
  @override
  List<Object> get props => [path];
}
