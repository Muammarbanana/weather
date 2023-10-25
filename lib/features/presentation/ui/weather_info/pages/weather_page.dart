import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/theme/text_style_manager.dart';
import 'package:weatherapp/features/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:weatherapp/features/presentation/ui/weather_info/widgets/weather_item_card_widget.dart';
import 'package:weatherapp/injection_container.dart';

class WeatherPage extends StatefulWidget {
  static const routeName = '/weather-page';
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherBloc _weatherBloc = sl<WeatherBloc>();

  @override
  void initState() {
    _weatherBloc.add(WeatherGotInitialData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyleManager.header2Text(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => _weatherBloc,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherSuccessState) {
              return ListView(children: [
                ...state.weatherReponse.list!.map(
                  (e) => WeatherItemCardWidget(weatherItemData: e),
                )
              ]);
            } else if (state is WeatherLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepPurple),
              );
            } else if (state is WeatherFailureState) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: TextStyleManager.mediumText(),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
