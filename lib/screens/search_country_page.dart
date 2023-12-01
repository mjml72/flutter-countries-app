import 'package:flutter/material.dart';
import 'package:flutter_countries_app/app_state_notifier.dart';
import 'package:flutter_countries_app/widgets/big_card.dart';
import 'package:provider/provider.dart';

class SearchCountryPage extends StatefulWidget {
  const SearchCountryPage({super.key});

  @override
  State<SearchCountryPage> createState() => _SearchCountryPageState();
}

class _SearchCountryPageState extends State<SearchCountryPage> {
  final TextEditingController _nameCountryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    String current = appState.current;

    Widget page;
    if ((current == "")) {
      page = const NotFoundCountry(texto: "No Country!");
    } else {
      page = const BigCard();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              width: 700,
              child: TextField(
                controller: _nameCountryController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  hintText: "Search for a country...",
                ),
                onSubmitted: (String value) {
                  setState(() {
                    appState.setName(value);
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          page,
        ],
      ),
    );
  }
}

class NotFoundCountry extends StatelessWidget {
  final String texto;
  const NotFoundCountry({
    super.key, required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      height: 300,
      margin: const EdgeInsets.all(10),
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 1,
            ),
          ),
          child: Center(
              child: Text(
            texto,
            style: const TextStyle(fontSize: 50),
          ))),
    );
  }
}
