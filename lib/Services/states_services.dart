import 'dart:convert';

import 'package:covid_19/Model/world_states.dart';
import 'package:covid_19/Services/Utilites/app_uri.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<CovidApiModel> FetchworldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.baseUri));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return CovidApiModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countrieslistapi() async {
    var data;
    final response =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('network error');
    }
  }
}
