
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/ui/auth/sign_up_screen.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../widgets/round_button.dart';
import '../posts/post_screen.dart';
class LoginScreen extends StatefulWidget {

  const  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false ;
  final _formkey = GlobalKey<FormState>();
  final emailController= TextEditingController();
  final passwordController= TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void login(){
    setState(() {
      loading= true ;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text.toString()).then((value){
          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const PostScreen()
          ));
          setState(() {
            loading= false ;
          });

    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    });
    setState(() {
      loading= false ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
                child:
                Column(
                  children: [
                    TextFormField(
                      obscureText: false,
                      controller: emailController,
                      decoration:  const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: (Icon(Icons.email_rounded))
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'enter email';
                        }
                        return null;
                      }
                    ),

                     const  SizedBox(height: 10,),

                    TextFormField(
                      obscureText: false,
                      controller: passwordController,
                      decoration: const InputDecoration(
                          hintText: 'password',
                          prefixIcon: (Icon(Icons.lock_outline_rounded))
                      ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'enter password';
                          }
                          return null;
                        }
                    ),


                  ],
                )
            ),
            const SizedBox(height: 50,),

            RoundButton(
              title: 'Login',
              loading: loading,
              onTap: (){
                if(_formkey.currentState!.validate()){
                  login();

                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                }, child: const Text('Sign Up'))

              ],
            ),
          ],
        ),
      ),
    );
  }
}
