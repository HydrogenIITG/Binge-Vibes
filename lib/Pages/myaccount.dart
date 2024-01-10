import 'package:bingevibes/Pages/homepage.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:bingevibes/Pages/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var nameValue ='No values saved';
  var passValue = 'No Password saved';
  @override
  void initState() {
    super.initState();
    getValues();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        title: const Text('Binge Vibes',style:TextStyle(
            fontFamily: 'GreatVibes',
            fontSize: 28,
            fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MyHome(),
              ),
              (route) => false),
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NeumorphicIcon(
                Icons.account_circle_sharp,
                size: 100,
                style: const NeumorphicStyle(
                  depth: 5,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('User Credentials',style: TextStyle(
                      fontFamily: 'Solitreo',
                      fontSize: 18,
                      color: Colors.black),),
                      const SizedBox(height: 10,),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10), right: Radius.circular(10))),
                child: Padding(
                  padding:  const EdgeInsets.all(8.0),
                  child: Text('Username : $nameValue', style: const TextStyle(
                      fontFamily: 'Solitreo',
                      fontSize: 18,
                      color: Colors.black),),
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10), right: Radius.circular(10))),
                child: Padding(
                  padding:  const EdgeInsets.all(8.0),
                  child: Text('Password : $passValue', style: const TextStyle(
                      fontFamily: 'Solitreo',
                      fontSize: 18,
                      color: Colors.black),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  void getValues()async {
var pref =await SharedPreferences.getInstance();
var getUser = pref.getString(SignInState.usernameKey);
var getpass= pref.getString(SignInState.passwordKey);
 nameValue = getUser ?? "No values saved";
 passValue = getpass?? "No Passwords saved";
 setState(() {
   
 });
  }
}
