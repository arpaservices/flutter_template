import 'dart:developer';

import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';

enum Gender {
  male,
  female,
  other,
  blank
}
class GenderEnum {

  static String getGender(Gender gender) {
    switch (gender) {
      case Gender.male:
        return "Male";
      case Gender.female:
        return "Female";
      case Gender.other:
        return "Other";
      case Gender.blank:
        return "";
      default:
        return "";
    }
  }

}

enum SubscriptionPlans {
  MONTHLY,
  YEARLY
}
class SubscriptionPlansEnum{

  static String getPlanInString(SubscriptionPlans plan){
    switch(plan){
      case SubscriptionPlans.MONTHLY:
        return "MONTHLY";
      case SubscriptionPlans.YEARLY:
        return "YEARLY";
      default:
        return "";
    }
  }

  static SubscriptionPlans getPlanInEnum(String input){
    // log(message)("This is input from stringToType $input");
    switch (input) {
      case "MONTHLY":
        return SubscriptionPlans.MONTHLY;
      case "YEARLY":
        return SubscriptionPlans.YEARLY;
      default:
        return SubscriptionPlans.MONTHLY;
    }
  }

}

enum SubscriptionStatus {
  NONE,
  ACTIVE,
  INACTIVE,
  EXPIRED,
}

class SubscriptionStatusEnum{

  static String getSubsStatusInString(SubscriptionStatus plan){
    switch(plan){
      case SubscriptionStatus.NONE:
        return "NONE";
      case SubscriptionStatus.ACTIVE:
        return "ACTIVE";
      case SubscriptionStatus.INACTIVE:
        return "INACTIVE";
      case SubscriptionStatus.EXPIRED:
        return "EXPIRED";
      default:
        return "";
    }
  }

  static SubscriptionStatus getSubsStatusInEnum(String input){
    // log(message)("This is input from stringToType $input");
    switch (input) {
      case "NONE":
        return SubscriptionStatus.NONE;
      case "ACTIVE":
        return SubscriptionStatus.ACTIVE;
      case "INACTIVE":
        return SubscriptionStatus.INACTIVE;
      case "EXPIRED":
        return SubscriptionStatus.EXPIRED;
      default:
        return SubscriptionStatus.NONE;
    }
  }

}



enum OccurrenceType {
  DAILY,
  WEEKLY,
  MONTHLY
}
enum ChartType {
  WEEKLY,
  MONTHLY,
  YEARLY,
}

enum Days {
  SUN,
  MON,
  TUE,
  WED,
  THURS,
  FRI,
  SAT,
}


enum DailyOccurrenceType {
  MORNING,
  EVENING,
  AFTERNOON,
  NIGHT,
  ANYTIME
}

enum HabitStatusType {
  PLANNED,
  COMPLETED}

enum EntryType {
  HABIT,
  HEALTHHABIT,
  JOURNAL,
}

enum JournalType  {
  FreeText,
  RichText,
  Category,
}

class JournalTypeEnum{
  static String journalTypeToString(JournalType input){
    log("This is input from JournalType $input");
    switch (input) {
      case JournalType.FreeText:
        return "FreeText";
      case JournalType.Category:
        return "Category";
      case JournalType.RichText:
        return "RichText";
      default:
        return "FreeText";
    }
  }
  static JournalType stringToType(String input){
    // log(message)("This is input from stringToType $input");
    switch (input) {
      case "FreeText":
      // log(message)("this is ouput of stringToType JournalType.FreeText" );
        return JournalType.FreeText;
      case "Category":
      // log(message)("this is ouput of stringToType JournalType.Category" );
        return JournalType.Category;
      case "RichText":
      // log(message)("this is ouput of stringToType JournalType.RichText" );
        return JournalType.RichText;
      default:
      // log(message)("this is ouput of stringToType JournalType.FreeText" );
        return JournalType.FreeText;
    }
  }
}


class FluentDataTypeEnum{
  static String fluentDataTypeToString(FluentData input){
    log("This is input from FluentData $input");
    switch (input) {
      case Fluents.flSmilingFaceWithSunglasses:
        return "flSmilingFaceWithSunglasses";
      case Fluents.flSmilingFaceWithSmilingEyes:
        return "flSmilingFaceWithSmilingEyes";
      case Fluents.flNeutralFace:
        return "flNeutralFace";
      case Fluents.flCryingFace:
        return "flCryingFace";
      case Fluents.flPoutingFace:
        return "flPoutingFace";
      default:
        return "flSmilingFaceWithSunglasses";
    }
  }
  static FluentData stringToFluentDataType(String input){
    // log(message)("This is input from stringToType $input");
    switch (input) {
      case "flSmilingFaceWithSunglasses":
        return Fluents.flSmilingFaceWithSunglasses;
      case "flSmilingFaceWithSmilingEyes":
        return Fluents.flSmilingFaceWithSmilingEyes;
      case "flNeutralFace":
        return Fluents.flNeutralFace;
      case "flCryingFace":
        return Fluents.flCryingFace;
      case "flPoutingFace":
        return Fluents.flPoutingFace;
      default:
        return Fluents.flSmilingFaceWithSunglasses;
    }
  }
}
class HabitStatusTypeEnum{
  static HabitStatusType getHabitStatusType(String habitStatusType) {
    switch (habitStatusType) {
      case "HabitStatusType.PLANNED":
        return HabitStatusType.PLANNED;
      case "HabitStatusType.COMPLETED":
        return HabitStatusType.COMPLETED;
      default:
        return HabitStatusType.PLANNED;
    }
  }
  static String habitStatusTypetoString(HabitStatusType habitStatusType) {
    switch (habitStatusType) {
      case HabitStatusType.PLANNED:
        return "HabitStatusType.PLANNED";
      case HabitStatusType.COMPLETED:
        return "HabitStatusType.COMPLETED";
      default:
        return "HabitStatusType.PLANNED";
    }
  }
}

class OccurrenceTypeEnum{
  static OccurrenceType getOccurrenceType(String occurrenceTypeString) {
    switch (occurrenceTypeString) {
      case "DAILY":
        return OccurrenceType.DAILY;
      case "MONTHLY":
        return OccurrenceType.MONTHLY;
      case "WEEKLY":
        return OccurrenceType.WEEKLY;
      default:
        return OccurrenceType.DAILY;
    }
  }
  static String occurenceTypetoString(OccurrenceType occurrenceType) {
    switch (occurrenceType) {
      case OccurrenceType.DAILY:
        return "DAILY";
      case OccurrenceType.MONTHLY:
        return "MONTHLY";
      case OccurrenceType.WEEKLY:
        return "WEEKLY";
      default:
        return "DAILY";
    }
  }
}

class DailyOccurrenceEnum{

  static DailyOccurrenceType getDailyOccurenceType(String type){
    print("this is the case occurrenceTypeString : $type" );
    switch(type){
      case "MORNING":
        return DailyOccurrenceType.MORNING;
      case "AFTERNOON":
        return DailyOccurrenceType.AFTERNOON;
      case "EVENING":
        return DailyOccurrenceType.EVENING;
      case "ANYTIME":
        return DailyOccurrenceType.ANYTIME;
      default:
        return DailyOccurrenceType.ANYTIME;
    }
  }
  static String dailyOccurenceTypetoString(DailyOccurrenceType inputOccurrenceType){
    switch(inputOccurrenceType){
      case DailyOccurrenceType.MORNING:
        return "MORNING";
      case DailyOccurrenceType.AFTERNOON:
        return "AFTERNOON";
      case DailyOccurrenceType.EVENING:
        return "EVENING";
      case DailyOccurrenceType.ANYTIME:
        return "ANYTIME";
      default:
        return "ANYTIME";
    }
  }


}

class DaysEnum{

  static Days getTypeFrmDay(String type){
    switch(type){
      case "Sunday":
        return Days.SUN;
      case "Monday":
        return Days.MON;
      case "Tuesday":
        return Days.TUE;
      case "Wednesday":
        return Days.WED;
      case "Thursday":
        return Days.THURS;
      case "Friday":
        return Days.FRI;
      case "Saturday":
        return Days.SAT;
      default:
        return Days.MON;
    }
  }
  static Days getTypeFrmAbbrevation(String type){
    switch(type){
      case "SUN":
        return Days.SUN;
      case "MON":
        return Days.MON;
      case "TUE":
        return Days.TUE;
      case "WED":
        return Days.WED;
      case "THURS":
        return Days.THURS;
      case "FRI":
        return Days.FRI;
      case "SAT":
        return Days.SAT;
      default:
        return Days.MON;
    }
  }

  static String getAbbrevationFrmType(Days type){
    switch(type){
      case Days.SUN:
        return  "SUN";
      case Days.MON:
        return "MON";
      case Days.TUE:
        return "TUE";
      case Days.WED:
        return "WED";
      case Days.THURS:
        return "THURS";
      case Days.FRI:
        return "FRI";
      case Days.SAT:
        return "SAT";
      default:
        return "ALL";
    }
  }


  static List<Days> getListOfDays(List<dynamic> inputList){
    List<Days> output =[];
    for(int i =0 ; i<inputList.length;i++){
      Days inputValue = getTypeFrmDay(inputList[i].toString());
      output.contains(inputValue)?null:output.add(inputValue);
    }
    return output;
  }
  static List<Days> getListOfDaysFromAbbrivation(List<String> inputList){
    List<Days> output =[];
    for(int i =0 ; i<inputList.length;i++){

      Days inputValue = Days.values.firstWhere(
            (day) => day.toString().split('.').last.toUpperCase() == inputList[i].toUpperCase(),
      );
      // Days inputValue = getTypeFrmAbbrevation(inputList[i]);
      output.add(inputValue);
    }
    return output;
  }

  static List<String> getListOfDaysInString(List<Days> inputList){
    List<String> output =[];
    for(int i =0 ; i<inputList.length;i++){
      output.add(inputList[i].toString().split('.').last);
    }
    return output;
  }



  static String occurenceTypetoString(DailyOccurrenceType inputOccurrenceType){
    switch(inputOccurrenceType){
      case DailyOccurrenceType.MORNING:
        return "DailyOccurrenceType.MORNING";
      case DailyOccurrenceType.AFTERNOON:
        return "DailyOccurrenceType.AFTERNOON";
      case DailyOccurrenceType.EVENING:
        return "DailyOccurrenceType.EVENING";
      case DailyOccurrenceType.ANYTIME:
        return "DailyOccurrenceType.ANYTIME";
      default:
        return "DailyOccurrenceType.ANYTIME";
    }
  }


}


enum MediaFormat {
  File,
  Link
}


class MediaFormatEnum{

  static MediaFormat getMediaType(String type){
    switch(type){
      case "FILE":
        return MediaFormat.File;
      case "LINK":
        return MediaFormat.Link;
      default:
        return MediaFormat.Link;
    }
  }
  static String getMediaTypeValue(MediaFormat type){
    switch(type){
      case MediaFormat.File:
        return "FILE";
      case MediaFormat.Link:
        return "LINK";
      default:
        return "LINK";
    }
  }

}