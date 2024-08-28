
import 'dart:developer';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


extension DateTimeExt on DateTime {
  DateTime get monthStart => DateTime(year, month);
  DateTime get dayStart => DateTime(year, month, day);

  DateTime addMonth(int count) {
    return DateTime(year, month + count, day);
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool get isToday {
    return isSameDate(DateTime.now());
  }
}

class DateCalenderDialog extends StatefulWidget {
  const DateCalenderDialog({super.key});

  @override
  State<DateCalenderDialog> createState() => _DateCalenderDialogState();
}

class _DateCalenderDialogState extends State<DateCalenderDialog> {
  late DateTime selectedMonth;

  DateTime? selectedDate;


  @override
  void initState() {
    selectedMonth = DateTime.now().monthStart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scrWidth =MediaQuery.sizeOf(context).width;
    final scrHeight =MediaQuery.sizeOf(context).height;
    return Center(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          // Swiping in right direction.
          if(details.primaryVelocity !=null){
            if (details.primaryVelocity! > 0.0) {
              log("previous month");
              setState(() {
                selectedMonth = selectedMonth.addMonth(-1);
              });
            }

            // Swiping in left direction.
            if (details.primaryVelocity! < 0.0) {
              log("next month");
              setState(() {
                selectedMonth = selectedMonth.addMonth(1);
              });
            }
          }
        },
        child: Container(
          height: 800,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(
                selectedMonth: selectedMonth,
                selectedDate: selectedDate,
                onChange: (value) => setState(() => selectedMonth = value),
              ),
              Expanded(
                child: _Body(
                  selectedDateBody: selectedDate,
                  selectedMonth: selectedMonth,
                  selectDate: (DateTime value) => setState(() {
                    selectedDate = value;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  _Body({
    super.key,
    required this.selectedMonth,
    required this.selectedDateBody,
    required this.selectDate,});
  final DateTime selectedMonth;
  late DateTime? selectedDateBody;

  final ValueChanged<DateTime> selectDate;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  bool isDeactivated = false;

  @override
  Widget build(BuildContext context) {
    var data = CalendarMonthData(
      year: widget.selectedMonth.year,
      month: widget.selectedMonth.month,
    );

    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: const [
        //     Text('M'),
        //     Text('T'),
        //     Text('W'),
        //     Text('T'),
        //     Text('F'),
        //     Text('S'),
        //     Text('S'),
        //   ],
        // ),
        // const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var week in data.weeks)
              Row(
                children: week.map((d) {
                  return Expanded(
                    child: _RowItem(
                      hasRightBorder: false,
                      date: d.date,
                      isActiveMonth: d.isActiveMonth,
                      onTap: () => widget.selectDate(d.date),
                      isSelected: widget.selectedDateBody != null &&
                          widget.selectedDateBody!.isSameDate(d.date),
                      onDateSelected: (selectedDate){
                        setState(() {
                          widget.selectedDateBody= selectedDate;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ],
    );
  }
}


class _RowItem extends StatefulWidget {
  _RowItem({super.key,
    required this.hasRightBorder,
    required this.isActiveMonth,
    required this.isSelected,
    required this.date,
    required this.onTap,
    this.onDateSelected,});
  final bool hasRightBorder;
  final bool isActiveMonth;
  final VoidCallback onTap;
  final bool isSelected;
  final DateSelectionCallback? onDateSelected;
  final DateTime date;

  @override
  State<_RowItem> createState() => _RowItemState();
}

class _RowItemState extends State<_RowItem> {



  final EmotionDatePickerController emotionDatePickerController = Get.put(EmotionDatePickerController());


  FluentData selectedEmoji = Fluents.flThinkingFace;

  @override
  Widget build(BuildContext context) {
    final int number = widget.date.day;
    final isToday = widget.date.isToday;
    final bool isPassed = widget.date.isBefore(DateTime.now());

    return
      InkWell(
        onTap: () async {
          if(widget.date.isBefore(DateTime.now()))
          {
            if (widget.onDateSelected != null) {
              // Call the onDateSelected Function
              widget.onDateSelected!(widget.date);
              emotionDatePickerController.selectedDateController.value = widget.date;
            }

            bool _currentEmotion(FluentData emotion1, FluentData emotion2) {
              return emotion1 == emotion2 ;
            }

            await showModalBottomSheet(context: context,backgroundColor: Colors.white, builder: (context){
              List<Map<String,FluentData>> emojiList=[{"Great":Fluents.flSmilingFaceWithSunglasses},{"Good":Fluents.flSmilingFaceWithSmilingEyes},{"Okay":Fluents.flNeutralFace},{"Not Good":Fluents.flCryingFace},{"Bad":Fluents.flPoutingFace}];
              List<Emotion> emotionList= emotionDatePickerController.emotionList;
              FluentData selectedEmotionInPicker = Fluents.flSmilingFaceWithSunglasses;
              String selectedEmotionName = "";

              if(emotionDatePickerController.dateEmotionMap[emotionDatePickerController.selectedDateController.value] !=null){
                emotionDatePickerController.selectedEmotionController.value= emotionDatePickerController.dateEmotionMap[emotionDatePickerController.selectedDateController.value];
              }

              return  Obx (()=>
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height*0.5,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addVerticalSpace(20),
                        const Text("How is your mood today ?",style: TextStyle(fontFamily: "Rubik",fontSize: 20,fontWeight: FontWeight.bold,),),
                        // Text("$emotionList",style: TextStyle(fontFamily: "Rubik",fontSize: 20,fontWeight: FontWeight.bold,),),
                        addVerticalSpace(50),
                        emotionList.isNotEmpty?
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceAround,
                          spacing: 60.0,
                          runSpacing: 30.0,
                          children: [
                            for (final emotion in emotionList)
                              InkWell(
                                onTap: () => {
                                  emotionDatePickerController.selectedEmotionController.value = emotion,
                                },
                                child: Container(
                                  height: 100,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: emotion== emotionDatePickerController.selectedEmotionController.value?primary : transperant,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      addVerticalSpace(70 * 0.1),
                                      Center(
                                        child: FluentUiEmojiIcon(
                                          w: 80 , // Adjust icon size as needed
                                          h: 50 ,
                                          fl: FluentDataTypeEnum.stringToFluentDataType(emotion.emojiUnicode),
                                        ),
                                      ),
                                      Text(emotion.name,style: TextStyle(fontFamily: "Rubik",fontSize: 15,fontWeight: FontWeight.w500, ),)
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ):
                        CircularProgressIndicator(),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     FluentUiEmojiIcon(
                        //       w: 80,
                        //       h: 80,
                        //       fl: Fluents.
                        //       ,
                        //     ),
                        //     // EmotionWidget(
                        //     //   emoji:Fluents.flSadButRelievedFace ,
                        //     //   emotionName: "Sad",
                        //     //   selectionColor:  emoji == selectedEmoji ? Colors.blue : Colors.transparent,,
                        //     //   height: 200,
                        //     //   width: 200,
                        //     //   onEmotionSelected:(selectedEmotion) {
                        //     //     setState(() {
                        //     //       selectedEmoji = Fluents.flSadButRelievedFace ;
                        //     //     });
                        //     //   },
                        //     // ),
                        //   ],
                        // ),
                        addVerticalSpace(20),
                        ElevatedButton(
                          style: const ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(dark),
                              minimumSize:MaterialStatePropertyAll(Size(double.infinity,50)),backgroundColor: MaterialStatePropertyAll(primary) ),
                          onPressed: () async {
                            if (widget.onDateSelected != null) {
                              // await emotionDatePickerController.getEmotionsOfWeek();
                              // await emotionDatePickerController.testEmotionHistoryAtController();
                              emotionDatePickerController.submittedEmotionController.value=emotionDatePickerController.selectedEmotionController.value;
                              setState(() {
                                emotionDatePickerController.submittedDateController.value=emotionDatePickerController.selectedDateController.value;
                                this.selectedEmoji = FluentDataTypeEnum.stringToFluentDataType(emotionDatePickerController.selectedEmotionController.value.emojiUnicode);

                                emotionDatePickerController.dateEmotionMap[emotionDatePickerController.selectedDateController.value] = emotionDatePickerController.selectedEmotionController.value;

                              });
                              await emotionDatePickerController.addEmotionOfDay();
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text('I am feeling ${emotionDatePickerController.selectedEmotionController.value.name==""?"...":emotionDatePickerController.selectedEmotionController.value.name}' ,style:TextStyle(color:dark,fontFamily: RUBIK_FONT,fontSize: 18,fontWeight: FontWeight.w600) ,),
                        ),
                      ],
                    ),
                  )
              );
            }).whenComplete(() {
              emotionDatePickerController.submittedEmotionController.value= Emotion(name: "", emojiUnicode: "", subEmoji: [Emoji(name: "", emojiUnicode: "", isPremium: false, isMasked: false, isDeleted: false)], isPremium: false, isMasked: false, isDeleted: false);
              emotionDatePickerController.selectedEmotionController.value= Emotion(name: "", emojiUnicode: "", subEmoji: [Emoji(name: "", emojiUnicode: "", isPremium: false, isMasked: false, isDeleted: false)], isPremium: false, isMasked: false, isDeleted: false);;
              setState(() {

              });
            });
            // if (widget.onDateSelected != null) {
            //   setState(() {
            //     selectedEmoji = Fluents.flUmbrella;
            //   });
            // }
          }
          else{
            log("Date is after Today.");
          }
        },
        child: Container(
          width: 53,
          margin: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: widget.isSelected ? primary : Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(number.toString(),),
                Text(DateFormat("E").format(widget.date).toUpperCase(),),
                // (selectedEmoji == Fluents.flThinkingFace)  ?
                //       SvgPicture.asset(
                //         unselectedEmotion,height: 29,
                //       ):
                //       Text("${getEmoji("U+1F60E")}",style: TextStyle(fontSize: 22),)
                widget.date.isBefore(DateTime.now())?
                emotionDatePickerController.dateEmotionMap[widget.date]!=null ?
                FluentUiEmojiIcon(
                  w: 29,
                  h: 29,
                  // fl:FluentDataTypeEnum.stringToFluentDataType(submittedEmotion.emojiUnicode) ,
                  fl:FluentDataTypeEnum.stringToFluentDataType((emotionDatePickerController
                      .dateEmotionMap[widget.date] as Emotion).emojiUnicode) ,
                ):selectedEmoji == Fluents.flThinkingFace?
                SvgPicture.asset(
                  unselectedEmotion,height: 29,
                ):
                FluentUiEmojiIcon(
                  w: 29,
                  h: 29,
                  fl: selectedEmoji,
                )
                    :
                SvgPicture.asset(
                  upcomingEmotion,height: 29,
                )

                // SizedBox(height:29, child: Image.asset("assets/image/$selectedEmoji.png")),
              ],
            ),
          ),
        ),
      );
  }
}


class _Header extends StatelessWidget {
  const _Header({
    required this.selectedMonth,
    required this.selectedDate,
    required this.onChange,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;

  final ValueChanged<DateTime> onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Text(
          //     'Selected date: ${selectedDate == null ? 'non' : "${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}"}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  onChange(selectedMonth.addMonth(-1));
                },
                icon: const Icon(Icons.arrow_left_sharp),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  ' ${DateFormat("MMMM").format(selectedMonth)}',
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  onChange(selectedMonth.addMonth(1));
                },
                icon: const Icon(Icons.arrow_right_sharp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalendarMonthData {
  final int year;
  final int month;

  int get daysInMonth => DateUtils.getDaysInMonth(year, month);
  int get firstDayOfWeekIndex => 0;

  int get weeksCount => ((daysInMonth + firstDayOffset) / 7).ceil();

  const CalendarMonthData({
    required this.year,
    required this.month,
  });

  int get firstDayOffset {
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;

    return (weekdayFromMonday - ((firstDayOfWeekIndex - 1) % 7)) % 7 - 1;
  }

  List<List<CalendarDayData>> get weeks {
    final res = <List<CalendarDayData>>[];
    var firstDayMonth = DateTime(year, month, 1);
    var firstDayOfWeek = firstDayMonth.subtract(Duration(days: firstDayOffset));

    for (var w = 0; w < weeksCount; w++) {
      final week = List<CalendarDayData>.generate(
        7,
            (index) {
          final date = firstDayOfWeek.add(Duration(days: index));

          final isActiveMonth = date.year == year && date.month == month;

          return CalendarDayData(
            date: date,
            isActiveMonth: isActiveMonth,
            isActiveDate: date.isToday,
          );
        },
      );
      res.add(week);
      firstDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
    }
    return res;
  }
}

class CalendarDayData {
  final DateTime date;
  final bool isActiveMonth;
  final bool isActiveDate;

  const CalendarDayData({
    required this.date,
    required this.isActiveMonth,
    required this.isActiveDate,
  });
}