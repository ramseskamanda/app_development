import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/ui/home/chat_screen/conversation.dart';
import 'package:studentup_mobile/ui/home/chat_screen/new_message.dart';
import 'package:studentup_mobile/ui/leaderboard/prize_screen.dart';
import 'package:studentup_mobile/ui/profile/other_profile.dart';
import 'package:studentup_mobile/ui/profile/sections/new_education_route.dart';
import 'package:studentup_mobile/ui/profile/sections/new_experience_route.dart';
import 'package:studentup_mobile/ui/profile/sections/new_skill_route.dart';
import 'package:studentup_mobile/ui/projects/new_project_root.dart';
import 'package:studentup_mobile/ui/projects/project_page.dart';
import 'package:studentup_mobile/ui/startup_page/startup_page.dart';
import 'package:studentup_mobile/ui/think_tank/new_comment_route.dart';
import 'package:studentup_mobile/ui/think_tank/new_think_tank_route.dart';
import 'package:studentup_mobile/ui/user_content/user_projects.dart';
import 'package:studentup_mobile/ui/user_content/user_saved_profiles.dart';
import 'package:studentup_mobile/ui/user_content/user_think_tanks.dart';

class Router {
  static const String home = '/';
  static const String newMessage = '/newMessage';
  static const String otherProfile = '/otherProfile';
  static const String conversation = '/conversation';
  static const String newThinkTank = '/newThinkTank';
  static const String startupPage = '/startupPage';
  static const String prizeScreen = '/prizeScreen';
  static const String newEducation = '/newEducation';
  static const String newExperience = '/newExperience';
  static const String newSkill = '/newSkill';
  static const String newProject = '/newProject';
  static const String projectPage = '/projectPage';
  static const String newCommentRoute = '/newCommentRoute';
  static const String userProjects = '/userProjects';
  static const String userThinkTanks = '/userThinkTanks';
  static const String userSavedProfiles = '/userSavedProfiles';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Map<String, dynamic> args = settings.arguments ?? {};
    switch (settings.name) {
      case newMessage:
        return MaterialPageRoute(
          builder: (_) => NewMessage(
            model: args['model'],
            fromSearch: args['fromSearch'] ?? false,
          ),
        );
      case otherProfile:
        return MaterialPageRoute(
          builder: (_) => OtherProfile(
            infoModel: args['infoModel'],
            fromMessaging: args['fromMessaging'],
          ),
        );
      case conversation:
        return MaterialPageRoute(
          builder: (_) => Conversation(chat: args['chat']),
        );
      case newThinkTank:
        return MaterialPageRoute<bool>(
          builder: (_) => NewThinkTankRoute(),
        );
      case startupPage:
        return MaterialPageRoute(
          builder: (_) => StartUpPageRoot(model: args['model']),
        );
      case prizeScreen:
        return MaterialPageRoute(
          builder: (context) => PrizeScreen(model: args['model']),
        );
      case newEducation:
        return MaterialPageRoute(
          builder: (_) => NewEducationRoute(),
        );
      case newExperience:
        return MaterialPageRoute(
          builder: (_) => NewExperienceRoute(),
        );
      case newSkill:
        return MaterialPageRoute(
          builder: (_) => NewSkillRoute(),
        );
      case newProject:
        return MaterialPageRoute<bool>(
          builder: (_) => NewProjectRoot(),
        );
      case projectPage:
        return MaterialPageRoute<bool>(
          builder: (_) => ProjectPage(model: args['model']),
        );
      case newCommentRoute:
        return MaterialPageRoute(
          builder: (_) => NewCommentRoute(notifier: args['notifier']),
        );
      case userProjects:
        return MaterialPageRoute(
          builder: (_) => UserProjects(),
        );
      case userThinkTanks:
        return MaterialPageRoute(
          builder: (_) => UserThinkTanks(),
        );
      case userSavedProfiles:
        return MaterialPageRoute(
          builder: (_) => UserSavedProfiles(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: const Text('Unknown Route'),
              automaticallyImplyLeading: true,
            ),
            body: Center(
              child: const Text('You just entered the unkown...'),
            ),
          ),
        );
    }
  }
}

class InnerRouter {
  int _profileTab;
  CupertinoTabController _navBarController;
  PageController _homeController;

  InnerRouter({int initialNavBarTab}) {
    _profileTab = 0;
    _navBarController =
        CupertinoTabController(initialIndex: initialNavBarTab ?? 0);
    _homeController = PageController(
      keepPage: true,
      initialPage: !(initialNavBarTab == -1) ? 0 : 1,
    );
  }

  void dispose() {
    _navBarController.dispose();
    _homeController.dispose();
  }

  CupertinoTabController get navBar => _navBarController;
  PageController get homeView => _homeController;
  set profileTab(int value) => _profileTab = value;

  void resetRouter() => _homeController.jumpToPage(0);
  void goToProfile() => _navBarController.index = _profileTab ?? 0;
  void resetHomePage() => _homeController.jumpToPage(0);
  void goToPage(int index) => _homeController.animateToPage(
        index,
        duration: kTabScrollDuration,
        curve: Curves.easeInOutQuad,
      );
}
