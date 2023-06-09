// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  Constants._();

  //PAGES
  static const String SPLASH = '/';
  static const String HomeScreen = '/home';
  static const String IntroScreen = '/Intro';
  static const String LoginScreen = '/loginScreen';
  static const String RegisterScreen = '/registerScreen';
  static const String LandingScreen = '/LandingScreen';
  static const String CreateNewsScreen = '/createNewsScreen';

  //APIs
  static const String URL = 'https://regentsy.com/Orgessor/api/';
  static const String LOGIN = 'auth/login';
  static const String Register = 'auth/register';
  static const String VerifyCode = 'auth/verifyCode';
  static const String GetLoadingData = 'allContent';
  static const String GetHome = 'home';
  static const String GetNews = 'news';
  static const String GetPolls = 'poll';
  static const String GetActivity = 'announcement';
  static const String Search = 'home/search';
  static const String Calender = 'Calender';

  //news and feed
  static const String CreateNews = 'feed/news';
  static const String GetNewsById = 'news/';
  static const String Feed = 'feed/';
  static const String LikeNews = 'news/newsIntract';
  static const String GetAnnouncementById = 'announcement/';
  static const String GetPollById = 'poll/';
  static const String CreatePoll = 'feed/poll';
  static const String CreateEvent = 'feed/announcement';
  static const String CreateOrg = 'organization';
  static const String AddChoicePoll = 'poll/addChoice';
  static const String AddVote = 'poll/addVote';
  static const String joinAnnouncement = 'announcement/activityJoin';

  // organization Api
  static const String GetOrganizationById = 'organization/';
  static const String RequestOrganizationById = 'Request/';
  static const String AcceptRequestOrganizationById = 'Request/edit';
  static const String DeleteMember = 'Member/';
  static const String JoinOrganization = 'Request';
  static const String ChangeRole = 'Role/editUserRole';
  static const String GroupInformation = 'GroupInformation';
  static const String EditGroupInformation = 'GroupInformation/edit';
  static const String AddRole = 'Role';
  static const String EditRole = 'Role/edit';
  static const String EditOrganization = 'organization/edit';
  static const String DeleteMedia = 'GroupInformation/';
  static const String DeleteProject = 'organizationProject/';
  static const String AddMedia = 'organizationMedia';
  static const String AddProject = 'organizationProject';


  // Shared Key
  // static late SharedPreferences pref;
  static const String TOKEN = 'token';
  static const String LANGUAGE_CODE = 'language_code';
  static const String UserId = 'UserId';
  static const String FCM = 'FCM';
  static const String OnBoarding = 'OnBoarding';
  static const String User = 'user';
  static const String AllContent = 'AllData';
}
