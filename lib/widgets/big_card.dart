import 'package:flutter_countries_app/app_state_notifier.dart';
import 'package:flutter_countries_app/fetching_data.dart';
import 'package:flutter_countries_app/models/countrybigcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countries_app/screens/search_country_page.dart';
import 'package:provider/provider.dart';

class BigCard extends StatefulWidget {
  const BigCard({super.key});

  @override
  State<BigCard> createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  @override
  Widget build(BuildContext context) {
    var mainAxisAlignment = MainAxisAlignment.spaceEvenly;
    var appState = context.watch<MyAppState>();
    String country = appState.current;

    Axis direction;
    double width;
    double imageWidth;
    double padding;

    if (MediaQuery.of(context).size.width > 700) {
      direction = Axis.horizontal;
      mainAxisAlignment = MainAxisAlignment.spaceEvenly;
      width = 700;
      imageWidth = 300;
      padding = 30;
    } else {
      mainAxisAlignment = MainAxisAlignment.start;
      direction = Axis.vertical;
      width = 300;
      imageWidth = 230;
      padding = 10;
    }

    return SizedBox(
      width: width,
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Center(
            child: FutureBuilder<CountryBigCard>(
                future: Fetch().fetchCountry(country),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Flex(
                      direction: direction,
                      mainAxisAlignment: mainAxisAlignment,
                      children: [
                        Image.network(
                          snapshot.data!.flag,
                          width: imageWidth,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                snapshot.data!.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child:
                                  Text("Capital : ${snapshot.data!.capital}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Region : ${snapshot.data!.region}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                  "Subregion : ${snapshot.data!.subregion}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                  "Population : ${snapshot.data!.population}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Area : ${snapshot.data!.area} km²"),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    padding = 0;
                    return NotFoundCountry(texto: "${snapshot.error}");
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
