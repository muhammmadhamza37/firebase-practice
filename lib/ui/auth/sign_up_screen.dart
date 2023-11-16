
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/ui/auth/login_screen.dart';
import 'package:firebase_practice/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../widgets/round_button.dart';
class SignUpScreen extends StatefulWidget {

  const  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading =false;

  final _formKey  = GlobalKey<FormState>();
  final emailController= TextEditingController();
  final passwordController= TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
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
              title: 'Sign Up',
              loading: loading,
              onTap: (){
                if(_formKey.currentState!.validate()){
                  setState(() {
                    loading = true;
                  });
                  _auth.createUserWithEmailAndPassword(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString()).then((value){
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace){
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(error.toString());
                  });


                }
              },
            ),
            const SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have account?"),
                TextButton(onPressed: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                }, child: Column(children: const [
                  Text('Login'),
                ],))

              ],
            ),
          ],
        ),
      ),
    );
  }
}
