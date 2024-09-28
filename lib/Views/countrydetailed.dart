import 'package:covid_19/Views/world_statistics.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  String name;
  String image;
  String continent;
  int totalCase,
      totalDeath,
      active,
      totalRecovered,
      test,
      critical,
      todayRecovered;
  CountryDetails({
    required this.name,
    required this.image,
    required this.totalCase,
    required this.totalDeath,
    required this.totalRecovered,
    required this.active,
    required this.test,
    required this.critical,
    required this.todayRecovered,
    required this.continent,
  });

  @override
  State<CountryDetails> createState() => _CountryState();
}

class _CountryState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .091),
                child: Card(
                    child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                    ),
                    Reusable(
                        title: 'Cases', value: widget.totalCase.toString()),
                    Reusable(
                        title: 'Recovered',
                        value: widget.totalRecovered.toString()),
                    Reusable(
                        title: 'Death', value: widget.totalDeath.toString()),
                    Reusable(
                        title: 'Critical', value: widget.critical.toString()),
                    Reusable(
                        title: 'Todaydeath',
                        value: widget.totalDeath.toString()),
                    Reusable(title: 'Continent', value: widget.continent),
                    Reusable(title: 'Test', value: widget.test.toString()),
                  ],
                )),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
