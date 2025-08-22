import 'package:bloc/bloc.dart';
import 'package:bulk_basket/bloc/product/quantity_event.dart';
import 'package:bulk_basket/bloc/product/quantity_state.dart';
import 'package:equatable/equatable.dart';

class QuantityBloc extends Bloc<QuantityEvent, QuantityState> {
  QuantityBloc() : super(QuantityState()) {
    on<IncrementQuantity>(_incrementQuantity);
    on<DecrementQuantity>(_decrementQuantity);
    on<ResetQuantity>(_resetQuantity);
  }

  void _incrementQuantity(
      IncrementQuantity event, Emitter<QuantityState> emit) {
    emit(QuantityState(quantity: state.quantity + 1));
  }

  void _decrementQuantity(
      DecrementQuantity event, Emitter<QuantityState> emit) {
    emit(QuantityState(quantity: state.quantity > 1 ? state.quantity - 1 : 1));
  }

  void _resetQuantity(ResetQuantity event, Emitter<QuantityState> emit) {
    emit(QuantityState(quantity: 1));
  }
}
