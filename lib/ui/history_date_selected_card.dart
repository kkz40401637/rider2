import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HistoryDateSelectedCard extends StatefulWidget {
  const HistoryDateSelectedCard({Key? key, required this.formOrTo})
      : super(key: key);

  final String formOrTo;

  @override
  State<HistoryDateSelectedCard> createState() =>
      _HistoryDateSelectedCardState();
}

class _HistoryDateSelectedCardState extends State<HistoryDateSelectedCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(widget.formOrTo),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xA6000000),
          ),
        ),
        Container(
          height: 42,
          width: width * 0.40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            border: Border.all(color: const Color(0x33000000)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                '01/06/2022',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Color(0xA6000000),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_today,
                  color: Color(0x9900000),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}