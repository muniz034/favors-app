import "package:flutter/material.dart";
import "package:favors_app/pages/favors.dart";
import "package:favors_app/utils/mock.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Favors App",
      home: FavorsPage(
        key: Key("1"),
        pendingAnswerFavors: mockPendingFavors,
        completedFavors: mockCompletedFavors,
        refusedFavors: mockRefusedFavors,
        acceptedFavors: mockDoingFavors,
      ),
    );
  }
}