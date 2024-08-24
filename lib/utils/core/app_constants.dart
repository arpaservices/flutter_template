import 'dart:io';


final bool kAutoConsume = Platform.isIOS || true;
const String kConsumableId = 'consumable';
// const String _kUpgradeId = 'upgrade';
String kSilverSubscriptionId = 'subscription_silver';
String kGoldSubscriptionId = 'subscription_gold';
String kMonthlySubscriptionId = 'ap_1999_1mo';
String kYearlySubscriptionId = 'ap_19999_1yr';
List<String> kProductIds = <String>[
  kConsumableId,
  // kUpgradeId,
  kSilverSubscriptionId,
  kGoldSubscriptionId,
  kMonthlySubscriptionId,
  kYearlySubscriptionId
];
const String BERKSHIRE_SWASH_FONT = "Berkshire_Swash";
const String RUBIK_FONT = "Rubik";
const String PP_HATTON_FONT = "PP Hatton";
