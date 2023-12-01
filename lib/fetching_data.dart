import 'package:flutter_countries_app/models/country.dart';
import 'package:flutter_countries_app/models/countrybigcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



class Fetch {


  Future<CountryBigCard> fetchCountry(country) async {

    var response = await http.get(
        Uri.parse(
            'https://restcountries.com/v3.1/name/$country?fields=name,region,subregion,capital,currencies,area,population,languages,flags'),
        headers: {"charset": "UTF-8"});

    if (response.statusCode == 404) {

      response = await http.get(
          Uri.parse(
              'https://restcountries.com/v3.1/translation/$country?fields=name,region,subregion,capital,currencies,area,population,languages,flags'),
          headers: {"charset": "UTF-8"});
    }
    if (response.statusCode == 200) {

      // If the server did return a 200 OK response,
      // then parse the JSON.
      // Convertir la respuesta en una lista de objetos json

      final List<dynamic> jsonList =
          jsonDecode(utf8.decode(response.bodyBytes));

// Convertir la lista de objetos json en una lista de objetos Album
      final List<CountryBigCard> countries =
          jsonList.map((json) => CountryBigCard.fromJson(json)).toList();

      var country = countries[0];

      return country;

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw ('Not Found!');
    }
  }


  Future<List<Country>> fetchCountries(filter) async {

// Hacer la petición HTTP usando el paquete http
    String url = "";

    if (filter == "all") {
      url =
          "https://restcountries.com/v3.1/all?fields=name,capital,region,subregion,flags";
    } else {
      url =
          "https://restcountries.com/v3.1/region/$filter?fields=name,capital,region,subregion,flags";
    }
    final response =
        await http.get(Uri.parse(url), headers: {"charset": "UTF-8"});

// Comprobar si la respuesta fue exitosa
    if (response.statusCode == 200) {

// Convertir la respuesta en una lista de objetos json
      final List<dynamic> jsonList =
          jsonDecode(utf8.decode(response.bodyBytes));

// Convertir la lista de objetos json en una lista de objetos Album

      final List<Country> countries =
          jsonList.map((json) => Country.fromJson(json)).toList();

      countries.sort((a, b) => a.name.compareTo(b.name));

// Devolver la lista de objetos Album

      return countries;
    } else {
// Lanzar una excepción si la respuesta fue fallida

      throw Exception('Failed to load countries');
    }
  }

}
