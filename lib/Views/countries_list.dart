import 'package:covid_19/Services/states_services.dart';
import 'package:covid_19/Views/countrydetailed.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountrirsList extends StatefulWidget {
  const CountrirsList({super.key});

  @override
  State<CountrirsList> createState() => _CountrirsListState();
}

class _CountrirsListState extends State<CountrirsList> {
  TextEditingController searchcontroller = TextEditingController();
  StatesServices statesServices = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),

            // this  code for searching of the country
            child: TextFormField(
              controller: searchcontroller,
              keyboardType: TextInputType.text,
              onChanged: (vlaue) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Search country name",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesServices.countrieslistapi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ));
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchcontroller.text.isEmpty) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountryDetails(
                                    name: name,
                                    image: snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    totalCase: snapshot.data![index]['cases'],
                                    totalDeath: snapshot.data![index]['deaths'],
                                    totalRecovered: snapshot.data![index]
                                        ['recovered'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    critical: snapshot.data![index]['critical'],
                                    todayRecovered: snapshot.data![index]
                                        ['todayRecovered'],
                                    continent: snapshot.data![index]
                                        ['continent'],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                )
                              ],
                            ),
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchcontroller.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountryDetails(
                                        name: name,
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        totalCase: snapshot.data![index]
                                            ['cases'],
                                        totalDeath: snapshot.data![index]
                                            ['deaths'],
                                        totalRecovered: snapshot.data![index]
                                            ['recovered'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        continent: snapshot.data![index]
                                            ['continent'],
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
