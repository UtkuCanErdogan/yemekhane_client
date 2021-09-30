    import 'package:flutter/material.dart';
    import 'package:intl/intl.dart';


    class Clock extends StatefulWidget {
      const Clock({Key? key}) : super(key: key);

      @override
      _ClockState createState() => _ClockState();
    }

    class _ClockState extends State<Clock> {
      @override
      Widget build(BuildContext context) {
        return Container(
          child: StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1)),
            builder: (context, snapshot) => Center(
              child: Text(
                DateFormat('MM/dd/yyyy hh:mm:ss').format(DateTime.now()),
            ),),
          ),
        );
      }
    }
