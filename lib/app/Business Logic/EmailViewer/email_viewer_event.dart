import 'package:equatable/equatable.dart';

abstract class EmailViewerEvent extends Equatable {
  const EmailViewerEvent();
  @override
  List<Object> get props => [];
}

class LoadEmailEvent extends EmailViewerEvent {
  final String path;
  const LoadEmailEvent(this.path);
  @override
  List<Object> get props => [path];
}
