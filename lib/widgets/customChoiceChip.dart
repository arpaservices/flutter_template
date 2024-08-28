import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color textColor;

  CustomChoiceChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: isSelected,
      avatar: null, // No tickmark icon
      selectedColor: selectedColor,
      backgroundColor: unselectedColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Customize border radius
        side: BorderSide(color: Colors.transparent), // No default border
      ),
      onSelected: onSelected,
    );
  }
}

class MyWidget extends StatelessWidget {
  final controller = MyController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(controller.startTimeArr.length, (index) {
        final startTimeStr = controller.startTimeArr[index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomChoiceChip(
            label: startTimeStr,
            isSelected: controller.selectedStartTime.value == startTimeStr,
            onSelected: (selected) async {
              controller.selectedStartTime.value = startTimeStr;

              DateTime todayDate = DateTime.now();
              if (controller.selectedStartTime.value == "Today") {
                controller.startTime.value = todayDate;
              } else if (controller.selectedStartTime.value == "Tomorrow") {
                DateTime newDate = DateTime(todayDate.year, todayDate.month, todayDate.day + 1);
                controller.startTime.value = newDate;
              } else if (controller.selectedStartTime.value == "Custom") {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: todayDate,
                  firstDate: todayDate,
                  lastDate: DateTime(todayDate.year + 3),
                );
                if (pickedDate != null) {
                  controller.startTime.value = pickedDate;
                }
              }
            },
            selectedColor: Colors.blue, // Color of active chip
            unselectedColor: Colors.grey[200]!, // Color of inactive chips
            textColor: controller.selectedStartTime.value == startTimeStr ? Colors.white : Colors.black,
          ),
        );
      }),
    );
  }
}

class MyController {
  // Define your controller properties and methods here
  var selectedStartTime = ValueNotifier<String>("");
  var startTimeArr = ["Today", "Tomorrow", "Custom"];
  var startTime = ValueNotifier<DateTime>(DateTime.now());
}
