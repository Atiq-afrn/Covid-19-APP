import 'package:covid_19/Model/world_states.dart';
import 'package:covid_19/Services/states_services.dart';
import 'package:covid_19/Views/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatistics extends StatefulWidget {
  const WorldStatistics({super.key});

  @override
  State<WorldStatistics> createState() => _WorldStatisticsState();
}

class _WorldStatisticsState extends State<WorldStatistics>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(
        seconds: 4,
      ),
      vsync: this)
    ..repeat();
  @override
  void dispose() {
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            FutureBuilder(
                future: statesServices.FetchworldStatesRecords(),
                builder: (context, AsyncSnapshot<CovidApiModel> snapshot) {
                  // print(snapshot);
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 70,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Activve":
                                double.parse(snapshot.data!.active.toString()),
                          },
                          chartRadius: MediaQuery.of(context).size.width / 2.6,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.disc,
                          colorList: colorlist,
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .01),
                          child: Card(
                            child: Column(
                              children: [
                                Reusable(
                                    title: "total",
                                    value: snapshot.data!.active.toString()),
                                Reusable(
                                    title: "todaycases",
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                Reusable(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                Reusable(
                                    title: "Todayrecovered",
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                Reusable(
                                    title: "population",
                                    value:
                                        snapshot.data!.population.toString()),
                                Reusable(
                                    title: "Active Cases",
                                    value: snapshot.data!.active.toString()),
                                Reusable(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CountrirsList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child:
                                const Center(child: Text("track  countries")),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    ));
  }
}

class Reusable extends StatelessWidget {
  String title, value;
  Reusable({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        const Divider()
      ],
    );
  }
}
