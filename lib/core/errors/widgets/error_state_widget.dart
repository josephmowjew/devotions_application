import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // SvgPicture.asset(
          //   'assets/images/no-data.svg',
          //   width: 200,
          //   height: MediaQuery.of(context).size.height * .2,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'Its not you, its us. ',
              style: TextTheme.of(context).labelLarge,
            ),
          )
        ],
      ),
    );
  }
}
