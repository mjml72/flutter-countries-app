import 'package:flutter/material.dart';
import 'package:flutter_countries_app/app_state_notifier.dart';
import 'package:flutter_countries_app/screens/big_card_page.dart';
import 'package:provider/provider.dart';

class CountryCard extends StatelessWidget {
  final String name;
  final String region;
  final String capital;
  final String flag;
  const CountryCard({
    super.key,
    required this.name,
    required this.region,
    required this.capital,
    required this.flag,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return InkWell(
      onTap: () {
        appState.setName(name);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const BigCardPage();
            },
          ),
        );
      },
      child: SizedBox(
        width: 230,
        height: 230,
        child: Card(
          margin: const EdgeInsets.all(10),
          color: Theme.of(context).colorScheme.secondaryContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  flag,
                  width: 120,
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Region: $region',
                      ),
                      Text(
                        'Capital: $capital',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}