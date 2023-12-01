import 'package:flutter_countries_app/fetching_data.dart';
import 'package:flutter_countries_app/widgets/country_card.dart';
import 'package:flutter_countries_app/models/country.dart';
import 'package:flutter/material.dart';

class AllCountriesPage extends StatefulWidget {
  const AllCountriesPage({
    super.key,
  });

  @override
  State<AllCountriesPage> createState() => _AllCountriesPageState();
}

class _AllCountriesPageState extends State<AllCountriesPage> {
  final TextEditingController regionController = TextEditingController();
  String filter = "all";


  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry> dropdownMenuEntries = const [
      DropdownMenuEntry(value: 'all', label: "All"),
      DropdownMenuEntry(value: 'africa', label: "Africa"),
      DropdownMenuEntry(value: 'america', label: "America"),
      DropdownMenuEntry(value: 'asia', label: "Asia"),
      DropdownMenuEntry(value: 'europe', label: "Europe"),
      DropdownMenuEntry(value: 'oceania', label: "Oceania"),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 80),
              child: Column(
                children: [
                  const Text(
                    "Filter by Region",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownMenu(
                    dropdownMenuEntries: dropdownMenuEntries,
                    initialSelection: "all",
                    label: const Text("Region"),
                    controller: regionController,
                    onSelected: (value) {
                      setState(() {
                        filter = value;
                      });
                    },
                  ),
                ],
              )),
          Center(
            child: FutureBuilder<List<Country>>(
              future: Fetch().fetchCountries(filter),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                    children: [
                      for (int i = 0; i < snapshot.data!.length; i++)
                        CountryCard(
                          name: snapshot.data![i].name,
                          region: snapshot.data![i].region,
                          capital: snapshot.data![i].capital,
                          flag: snapshot.data![i].flag,
                        ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error al cargar datos'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
