import 'package:equatable/equatable.dart';

abstract class QuantityEvent extends Equatable {
  QuantityEvent();

  @override
  List<Object?> get props => [];
}


class IncrementQuantity extends QuantityEvent {}

class DecrementQuantity extends QuantityEvent {}

class ResetQuantity extends QuantityEvent {}
