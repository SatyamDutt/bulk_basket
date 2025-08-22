import 'package:equatable/equatable.dart';

class QuantityState extends Equatable {
  final int quantity;
  QuantityState({this.quantity = 1});

  QuantityState copyWith({int? quantity}) {
    return QuantityState(quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [quantity];
}
