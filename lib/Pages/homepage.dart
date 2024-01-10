import 'package:bingevibes/Pages/myaccount.dart';
import 'package:bingevibes/Pages/search.dart';
import 'package:bingevibes/Pages/sign_in.dart';
import 'package:bingevibes/Pages/watchlist.dart';
import 'package:bingevibes/Pages/welcome.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:bingevibes/Pages/index.dart';
import 'package:bingevibes/Pages/notifications.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with TickerProviderStateMixin {
  void sidebar() {}
  // TabController _tabController;
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade100,
        shadowColor: Colors.grey.shade300,
        centerTitle: true,
        title: const Text(
          'Binge Vibes',
          style: TextStyle(
            fontFamily: 'GreatVibes',
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: SidebarX(
        theme: const SidebarXTheme(
          itemDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          itemMargin: EdgeInsets.only(left: 0),
          width: 150,
          selectedTextStyle: TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
          hoverColor: Colors.grey,
          hoverTextStyle: TextStyle(color: Colors.red),
          selectedIconTheme: IconThemeData(color: Colors.red, size: 30),
          textStyle: TextStyle(fontSize: 16, color: Colors.black),
        ),
        controller: SidebarXController(
          selectedIndex: 0,
        ),
        items: [
          SidebarXItem(
            icon: Icons.account_circle_sharp,
            label: 'My Account',
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MyAccount(),
                ),
                (route) => false),
          ),
          SidebarXItem(
            icon: Icons.notifications_sharp,
            label: 'Notifications',
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const Notifications(),
                ),
                (route) => false),
          ),
          SidebarXItem(
            icon: Icons.settings_sharp,
            label: 'Settings',
            onTap: () => showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Text(
                  'Settings',
                  style: TextStyle(fontFamily: 'Solitreo'),
                ),
                content: Text(
                    'Nothing to show right now in app settings. we will be adding soon!'),
              ),
            ),
          ),
        ],
        footerItems: [
          SidebarXItem(
            icon: Icons.logout_sharp,
            label: 'logout',
            onTap: () async {
              var sharedPref = await SharedPreferences.getInstance();
              sharedPref.setBool(WelcomepageState.KEYLOGIN, false);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignIn(),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Home",
        labels: const ["Home", "Search", "Watchlist"],
        icons: const [
          Icons.home,
          Icons.search_sharp,
          Icons.play_circle_outline_sharp
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: 'Solitreo',
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.red[400],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.red[400],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.red.shade100,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: SafeArea(
        child: TabBarView(
          physics:
              const BouncingScrollPhysics(), // swipe navigation handling is not supported
          controller: _motionTabBarController,
          children: <Widget>[
            MyHomePage(
                title: "Home", controller: _motionTabBarController!),
            searchbarfun(
                title: "Search", controller: _motionTabBarController!),
            FavoriateMovies(
                title: "Watchlist", controller: _motionTabBarController!),
          ],
        ),
      ),
    );
  }
}
