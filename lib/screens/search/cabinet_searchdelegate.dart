import 'package:flutter/material.dart';
import 'package:flutter_app/models/cabinet_model.dart';
import 'package:flutter_app/screens/cabinet/cabinet_details_data.dart';
import 'package:flutter_app/screens/custom/custom_data_list_tile.dart';

class CabineSearchDelegate extends SearchDelegate {
  final List<CabinetModel> cabinets;

  CabineSearchDelegate(this.cabinets);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close_outlined),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return getSearchResult();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return getSearchResult();
  }

  StatelessWidget getSearchResult() {
    if (cabinets.isEmpty) {
      return Container(
        child: Text("No Cabinet available"),
      );
    }

    List<CabinetModel> filteredCabinets = cabinets
        .where((cabinet) =>
            cabinet.cabinetName.toLowerCase().contains(query.toLowerCase()) ||
            cabinet.cabinetDescription
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredCabinets.length,
      itemBuilder: (BuildContext context, int index) {
        CabinetModel currentCabinet = filteredCabinets[index];

        return Container(
          child: InkWell(
            splashColor: Color(0Xff334a7d),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CabinetDetailsData(
                    cabinet: currentCabinet,
                  ),
                ),
              );
            },
            child: Hero(
              tag: currentCabinet.cabinetImageUrl,
              child: CustomDataListTile(
                nameTitle: "Name",
                nameValue: currentCabinet.cabinetName,
                noOfChildTitle: "No. of Drawers",
                noOfChildvalue: currentCabinet.drawers != null
                    ? currentCabinet.drawers.length.toString()
                    : "0",
                imageUrl: currentCabinet.cabinetImageUrl,
              ),
            ),
          ),
        );
      },
    );
  }
}
