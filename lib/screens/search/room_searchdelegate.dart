import 'package:flutter/material.dart';
import 'package:flutter_app/models/room_model.dart';
import 'package:flutter_app/screens/custom/custom_data_list_tile.dart';
import 'package:flutter_app/screens/room/room_details.dart';

class RoomSearchDelegate extends SearchDelegate {
  final List<RoomModel> rooms;

  RoomSearchDelegate(this.rooms);

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
    if (rooms.isEmpty) {
      return Container(
        child: Text("No Rooms available"),
      );
    }

    List<RoomModel> filteredRooms = rooms
        .where((room) =>
            room.roomName.toLowerCase().contains(query.toLowerCase()) ||
            room.roomDescription.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredRooms.length,
      itemBuilder: (BuildContext context, int index) {
        RoomModel currentRoom = filteredRooms[index];

        return Container(
          child: InkWell(
            splashColor: Color(0Xff334a7d),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetails(
                    room: currentRoom,
                  ),
                ),
              );
            },
            child: Hero(
              tag: currentRoom.roomImageUrl,
              child: CustomDataListTile(
                nameTitle: "Name",
                nameValue: currentRoom.roomName,
                noOfChildTitle: "No. of cabinets",
                noOfChildvalue: currentRoom.cabinets != null
                    ? currentRoom.cabinets.length.toString()
                    : "0",
                imageUrl: currentRoom.roomImageUrl,
              ),
            ),
          ),
        );
      },
    );
  }
}
