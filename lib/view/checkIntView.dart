import 'package:flutter/material.dart';
import 'package:flutter_api_learn/service/network_change_manager.dart';
import 'package:kartal/kartal.dart';

class CheckIntView extends StatefulWidget {
  CheckIntView({Key? key}) : super(key: key);

  @override
  State<CheckIntView> createState() => _CheckIntViewState();
}

class _CheckIntViewState extends State<CheckIntView> {
  late final INeworkChangeManager changeManager;
  NetworkChangeResults? _networkChangeResults;
  @override
  void initState() {
    super.initState();
    changeManager = NetworkChangeManager();
    changeManager.handleNetworkChange((results) {
      updateResults(results);
    });
  }

  Future<void> fetchFirstResult() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final _results = await changeManager.checkFirstTime();
      updateResults(_results);
    });
  }

  void updateResults(NetworkChangeResults results) {
    setState(() {
      _networkChangeResults = results;
    });
  }

  final String offLine = 'You are offline';
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: Container(
          color: Colors.red,
          height: 50,
          child: Center(
              child: Text(
            offLine,
            style: context.textTheme.labelMedium,
          )),
        ),
        secondChild: SizedBox(),
        crossFadeState: _networkChangeResults == NetworkChangeResults.on
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(seconds: 1));
  }
}
