import 'package:bingevibes/Pages/homepage.dart';
import 'package:bingevibes/Pages/welcome.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:bingevibes/components/square_tiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final username =TextEditingController();
  final password = TextEditingController();
  static const String usernameKey ='Username';
  static const String passwordKey ='Password';
  void goToHome() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Binge Vibes',
                  style: TextStyle(
                      fontFamily: 'GreatVibes',
                      fontSize: 80,
                      color: Colors.black),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('lib/Images/authentication icon.jpeg',
                      width: 200),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Welcome!, Let\'s get started by signing in first.',
                  style: TextStyle(
                      fontFamily: 'Solitreo',
                      fontSize: 18,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  width: 300,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          controller: username,
                          hintText: 'Username or Email',
                          obscureText: false),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          controller: password,
                          hintText: 'Password',
                          obscureText: true),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Solitreo',
                        ),
                      ),
                    ],
                  ),
                ),
                NeumorphicButton(
                  onPressed: () async {
                    var sharedPref = await SharedPreferences.getInstance();
                    sharedPref.setBool(WelcomepageState.KEYLOGIN, true);
                    var pref = await SharedPreferences.getInstance();
                    pref.setString(usernameKey, username.text.toString());
                    pref.setString(passwordKey, password.text.toString());

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHome(),
                      ),
                    );
                  },
                  style: const NeumorphicStyle(depth: 5),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        fontFamily: 'Solitreo',
                        fontSize: 24,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 2.5,
                          color: Color.fromARGB(255, 7, 1, 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontFamily: 'Solitreo',
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 2.5,
                          color: Color.fromARGB(255, 7, 1, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                      onPressed: () => goToHome(),
                      style: const NeumorphicStyle(depth: 5),
                      child:
                          const SquareTile1(imagePath: 'lib/Images/Google.jpg'),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    NeumorphicButton(
                        onPressed: () => goToHome(),
                        style: const NeumorphicStyle(depth: 5),
                        child: const SquareTile1(
                            imagePath: 'lib/Images/Apple.jpg')),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member ?',
                      style: TextStyle(
                          fontFamily: 'Solitreo',
                          fontSize: 15,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Register Now ',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontFamily: 'Solitreo',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10),
                right: Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
                right: Radius.circular(10),
              ),
            ),
            fillColor: Colors.grey.shade100,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
