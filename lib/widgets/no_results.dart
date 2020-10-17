import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight / 3,
      child: const FlareActor(
        'assets/no_result.flr',
        alignment: Alignment.topCenter,
        fit: BoxFit.scaleDown,
        animation: 'Untitled',
      ),
    );
  }
}
