import 'package:flutter/material.dart';
import '/manager/permission_manager.dart';
import '/manager/api_manager.dart';
import '/model/weather.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/screen/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    PermissionManager.canAccessLocation().then((canAccess) {
      if (!canAccess) {
        _showSnackBar('Please allow location permission to get Weather ');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildCurrentWeatherWidget(),
            const SizedBox(height: 100),
            _build7DaysWeatherWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeatherWidget() {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<Weather>(
            future: ApiManager.getCurrentWeather(),
            builder: (_, snapShot) {
              if (snapShot.hasData) {
                final Weather weather = snapShot.data!;
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text('Current Weather'),
                      Text('Pressure : ${weather.pressure}'),
                      Text('WindSpeed : ${weather.wind.speed}'),
                      Text('Humidity : ${weather.humidity}'),
                      Text('SeaLevel : ${weather.seaLevel}'),
                      Text('Deg : ${weather.wind.deg}'),
                    ],
                  ),
                );
              } else if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapShot.hasError) {
                if (!PermissionManager().hasPermissionGiven) {
                  return TextButton(
                    onPressed: _onPermissionClick,
                    style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Give Permission'),
                  );
                }
                return Center(
                    child: Text('Something went wrong : ${snapShot.error}'));
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  Widget _build7DaysWeatherWidget() {
    return FutureBuilder(
        future: ApiManager.get7DaysWeather(),
        builder: (_, snapShot) {
          if (snapShot.hasError) {
            return const Center(
                child: Text(
                    'This api is not available because we will have to take Paid Plan',
                    textAlign: TextAlign.center));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _onPermissionClick() {
    PermissionManager.canAccessLocation().then((value) {
      if (!value) {
        _showSnackBar('Please allow location permission to get Weather');
        return;
      }
      setState(() {});
    });
  }
}
