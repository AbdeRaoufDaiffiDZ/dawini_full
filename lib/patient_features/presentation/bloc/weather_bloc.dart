import 'package:dawini_full/patient_features/domain/usecases/get_current_weather.dart';
import 'package:dawini_full/patient_features/presentation/bloc/weather_event.dart';
import 'package:dawini_full/patient_features/presentation/bloc/weather_state.dart';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this.getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<onCityChanged>((event, emit) async {
      emit(WeatherLoading());

      final result = await getCurrentWeatherUseCase.execute(event.cityName);
      result.fold((l) => emit(WeatherLoadedFailue(message: l.message)),
          (r) => emit(WeatherLoaded(result: r)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
