import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:med_add/MyApp.dart';
// import 'profile_screen.dart';
import 'loading_screen.dart';
import'package:med_add/MyApp.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:med_add/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:med_add/db/db_helper.dart';
import 'package:med_add/services/theme_services.dart';
import 'package:med_add/ui/homepage.dart';
import 'package:med_add/ui/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  
  runApp(const firstpage());
}

class firstpage extends StatelessWidget {
  const firstpage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Androidlarge1Widget(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}

class loading_screen extends StatefulWidget {
  const loading_screen({super.key});

  @override
  State<loading_screen> createState() => _loadingscreenState();
}

class _loadingscreenState extends State<loading_screen> {

  // Intializing firebase app
  Future<FirebaseApp>_intializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      future: _intializeFirebase(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return LoginScreen();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Login function
  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        print("No User found for that email");

      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {

    // Creating the textfield controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Padding(
      
      
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
        //   Positioned(
        // top: 300,
        // left: 200,
        Container(
        width: 120,
        height: 140,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(46),
            topRight: Radius.circular(46),
            bottomLeft: Radius.circular(46),
            bottomRight: Radius.circular(46),
          ),
      image : DecorationImage(
          image: AssetImage('images/Image2.png'),
          fit: BoxFit.fitWidth
      ),
  )
      ),
      // ),
          const Text("Medicare",
           style:TextStyle(color: Color.fromARGB(255, 216, 72, 120),
            fontSize:30.0,
            fontWeight: FontWeight.bold,),
            ),
           const Text("Login To App",
            style: TextStyle(color: Colors.black,
             fontSize: 42.0,
             fontWeight:FontWeight.bold,
             ),
             ),
            const SizedBox(
              height: 25.0,
             ),
             TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "User Email",
                prefixIcon: Icon(Icons.mail,color:Colors.black),
              ),
             ),
            const  SizedBox(
              height: 15,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "User Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            const  Text("Forgot Password?", style:TextStyle(color: Color.fromARGB(255, 79, 164, 233)) ,
              ),
            const  SizedBox(
                height:40 ,
              ),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: const Color(0xFF0069FE),
                  elevation: 0.0 ,
                  padding: const EdgeInsets.symmetric(vertical: 16.0 ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0)
                  ),
                  onPressed: () async{
                     User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                     print(user);
                     if(user !=  null){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyApp()));
                     }
                  },
                  child: const Text("Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )
                  ),
                    
                  ),
              ),
        ],
      ),
    );
  }
}