


// Widget para mostrar botones de días en el dialogo de selección de fecha
import 'package:en_tu_puerta_front/widget_client/search_components/app_buttons.dart';
import 'package:flutter/material.dart';

class DaysWidget extends StatefulWidget {
  final int daysShown;
  final List days; 
  final List date; 
  final Function(int) onDaySelected; 
  final Function() resetDropdown;  

  const DaysWidget(
      {super.key,
      required this.daysShown,
      required this.days,
      required this.date,
      required this.onDaySelected,
      required this.resetDropdown
      });

  @override
  DaysWidgetState createState() => DaysWidgetState();
  
}

class DaysWidgetState extends State<DaysWidget> {
  String? selectedDay;
  int? indexSelectedDay;
  

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: List.generate(widget.daysShown, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 5, bottom: 5),
          child: AppButtons(
            isSelected: selectedDay == widget.days[index],
            day: widget.days[index],
            onTap: () {
              setState(() {
                selectedDay = widget.days[index];
                indexSelectedDay = index;
                widget.resetDropdown();
                print(indexSelectedDay);
                print(selectedDay);
              });
              widget.onDaySelected(indexSelectedDay ?? -1);
            },
            date: widget.date[index],
          ),
        );
      }),
    );
  }

  int? getIndexSelectedDay() {
    return indexSelectedDay ?? -1; // Return -1 if indexSelectedDay is null
  }
}


