class AppTitles {
  //String Sign_Up
  static const String app_name = "Absaly";
  static const String app_subtitle = "your mental health companion";
  static const String app_journey_title = "Choose one of the options to start your journey";
  static const String termsAndConditionMsg="By continuing, you agree to $app_name's";
  static const String termsAndCondition="Terms & Condition";
  static const String termsAndConditionUrl="Terms & Condition";
  static const String privacyPolicy="Privacy Policy";


  static const String signup_title = "Sign in for peace of mind";
  static const String signup_sub_title = "Back up your data, sync it between multiple devices and save your progress to cloud";

  //String SignUp WIth Mobile Number
  static const String signup_mobile_title = "Enter Your Phone Number";
  static const String signup_mobile_subTitle = "Please confirm your country code and enter your phone number";
  // static const String signup_mobile_hintText ="xxxx xxx xx";
  static const String signup_mobile_hintText ="Phone Number";
  static const String signup_mobile_valid ="Enter Valid Mobile Number";

  //String OTP for Mobile Number
  static const String otp_mobile_title = "Enter Code";
  static const String otp_mobile_subTitle = "We have sent you an SMS with the code to";
  static const String otp_mobile_valid ="Enter Valid OTP";

  //String For Profile
  static const String firstName="First Name";
  static const String firstNameHint="First Name (Required)";
  static const String lastName="Last Name";
  static const String lastNameHint ="Last Name (Optional)";
  static const String emailAddress="Email Address";
  static const String emailAddressHint="Email";
  static const String phoneNumber="Mobile NUmber";
  static const String phoneNumberHint="Mobile NUmber";
  static const String pasSpecification=" (8+ characters)";
  static const String mobileNumber="Mobile Number";
  static const String mobileNumberHint="xxxx xxx xx";
  static const String genderText="Gender";
  static const String dateOfBirthText="Date of Birth";
  static const String other="other";

  //String For Setting
  static const String ProfileSettings="Profile Settings";
  static const String Notification="Notification";
  static const String Subscription="Subscription";
  static const String Help="Help";
  static const String InviteYourFriends ="Invite Your Friends";
  static const String MadewithlovebyARPA ="Made with love by ARPA";
  static const String Logout ="Logout";

  //Subscription Plan
  static const String Upgrade_Plan="Upgrade Plan";
  static const String Absaly_Premium="Absaly Premium";
  static const String Plan_Premium_title1="I commit to tracking my habits daily 📅";
  static const String Plan_Premium_title2="I promise to prioritize my well-being 🧘‍";
  static const String Plan_Premium_title3="I will strive for consistency and progress🌟";
  static const String Plan_Premium_title4="I understand that change takes time andeffort 💪";
  static const String Plan_Premium_title5="placeholder text btw";



  //String For Notification_Permission
  static const String notification_title = "Would you like to be reminded to do your";
  static const String notification_title_name = "habits";
  static const String notificationSubtitle = "In order to build lasting habits, we highly recommend you to enable your notifications. Never forget or miss a task again";

//Divider
  static const String tagDivider="  ";
  static const String divider=" ";

  //String For Journal
  static const String journal_title="Journal";
  static const String journal_sub_title="";

  //String For Journal
  static const String chart_title="Chart";
  static const String chart_sub_title="";

  //String For Tip
  static const String tip_title="Tips";
  static const String tip_sub_title="How is your mood today ?";
}

class AppValidations {

  //String For Journal
  static const String journal_entry_error="Kindly enter proper details";

}

class AppUrls {
  static const String termsAndConditionUrl='https://www.hiswillapp.com/terms-of-service';
  static const String websiteUrl='https://www.hiswillapp.com';
  static const String privacyPolicyUrl='https://www.hiswillapp.com/privacy-policy';
}

class AppArg {
  //String Constants
  static const String verification_Id = "verificationId";
  static const String mobile_country_code = "mobile_country_code";
  static const String mobile_number = "mobile_number";
  static const String login_user = "login_user";

}

class Preference {
  //String Preference

  // Login Status
  static const String is_GoogleSignIn = "is_GoogleSignIn";
  static const String is_MobileSignIn = "is_MobileSignIn";
  static const String is_AppleSignIn = "is_AppleSignIn";
  static const String is_OnboardingComplete = "is_OnboardingComplete";

  static const String fcm_token = "fcm_token";
  static const String verificationId = "verificationId";

  static const String user_Firebase_id = "user_Firebase_id";
  static const String user_FirstName = "user_FirstName";
  static const String user_LastName = "user_LastName";
  static const String user_Name = "user_Name";
  static const String user_CountryCode = "user_CountryCode";
  static const String user_Mobile = "user_Mobile";
  static const String user_PhoneNumber = "user_PhoneNumber";
  static const String user_EmailAddress = "user_EmailAddress";
  static const String user_Gender = "user_Gender";
  static const String user_ProfileImage = "user_ProfileImage";

  // Data
  static const String user_AuditFields = "user_AuditFields";
  static const String habit_InstanceList = "habit_InstanceList";
  static const String healthabit_InstanceList = "habit_InstanceList";

}
/*
class FirebaseCollection {
  //String FirebaseCollection
  static const String users = "users";
  static const String userTranscations = "userTranscations";
  static const String emojis = "emojis";
  static const String emotions = "emotions";
  static const String emotionsHistory = "emotionsHistory";
  static const String habits = "habits";
  static const String habitsHistory = "habitsHistory";
  static const String journals = "journals";
  static const String journalCategories = "journalCategories";
  static const String tips = "tips";
  static const String tipCategories = "tipCategories";
  static const String tipSubCategories = "tipSubCategories";
  static const String userInfo = "usersInfo";

}
*/
class FirebaseCollection {
  //String FirebaseCollection
  static const String users = "users";
  static const String userTranscations = "userTranscations";
  static const String emojis = "emojis";
  static const String emotions = "emotions";
  static const String emotionsHistory = "emotionsHistory";
  static const String habits = "habits";
  static const String habitsHistory = "habitsHistory";
  static const String journals = "journals";
  static const String journalCategories = "journalCategories";
  static const String tips = "tips";
  static const String tipCategories = "tipCategories";
  static const String tipSubCategories = "tipSubCategories";
  static const String userInfo = "usersInfo";

}
class FirebaseQueryCollection {
  static const String checkCreatedByInAuditFields = 'auditFields.createdBy';
  static const String createdDateTimeInAuditFields = 'auditFields.createdDateTime';
  static const String dateRefInEmotionHistory = 'dateRef';
  static const String habitRefInHabitHistory = 'habitRef';
  static const String occurencesInHabitHistory = 'occurences';
  static const String userRef = 'userRef';
  static const String startFromTimeStamp = 'startTime';
  static const String preferredDaysArray = 'preferredDays';
  static const String isDeleted = 'isDeleted';
  static const String isPremium = 'isPremium';
  static const String isMasked = 'isMasked';
  static const String parentCategory = 'parentCategory';
  static const String subCategory = 'subCategory';
  static const String categoryDetails = 'categoryDetails';
}

class States {
  static const String LOADING = "loading";
  static const String NO_INTERNET = "no_internet";
  static const String SUCCESS = "success";
  static const String FAILED = "failed";
}

class PostNotification {
  static const String ADD_HABITS = "Add_Habits";
  static const String ADD_JOURNAL = "Add_Journal";
  static const String ADD_JOURNAL_FORM = "Add_Journal_FORM";
  static const String ADD_JOURNAL_QNA = "Add_Journal_QNA";
}



//Splash Screen
const loadingTxt="Loading...";
const splashScreenText="Take a Deep Breath";


const emailAddressHIntTxt="Enter your email Address";
const mobileNumberHintTxt="Enter your mobile number";
const mobileNumberValidTxt="Enter valid mobile number";
const termsAndPrivacy="Terms & Privacy Policy";





//Dashboard
const bottomNavigationTxt=["Overview","Journal","Add","Community","Settings"];
const bottomNavUnSelectedImage=[
  "assets/image/icons/home_unselected.svg",
  "assets/image/icons/journal_unselected.svg",
  "assets/image/icons/add_selected.svg",
  // "assets/image/icons/history_unselected.svg",
  "assets/image/icons/quiz_unselected.svg",
  "assets/image/icons/settings_unselected.svg"];
const bottomNavSelectedImage=[
  "assets/image/icons/home_selected.svg",
  "assets/image/icons/journal_selected.svg",
  "assets/image/icons/add_selected.svg",
  // "assets/image/icons/history_selected.svg",
  "assets/image/icons/quiz_selected.svg",
  "assets/image/icons/settings_selected.svg"];

const adjustIcon = "assets/image/icons/adjust_icon.svg";
const splashLogoIcon = "assets/image/splash_logo_sticker.png";
const planningListIcon = "assets/image/icons/planning_list_icon.svg";
const completedListIcon ="assets/image/icons/completed_list_icon.svg";
const unselectedEmotion ="assets/image/icons/unselected_emotion_icon.svg";
const upcomingEmotion ="assets/image/icons/upcoming_emotion_icon.svg";
const bellIcon ="assets/image/icons/bell_icon.svg";




