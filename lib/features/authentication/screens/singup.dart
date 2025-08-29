import 'package:flutter/material.dart';
import 'package:nishant_store/features/authentication/screens/t_signup_form.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text
              Text("Let's Create your Account", style: Theme.of(context).textTheme.headlineMedium,),
              SizedBox(height: 32,),

              // Form
              TSingUpForm(),

            ],
          ),
        ),
      ),
    );
  }
}




class TFromDivider extends StatelessWidget {
  const TFromDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Divider(color: Colors.grey, thickness: 0.5, indent: 60, endIndent: 5,)),
        Text('or sign in with',style: Theme.of(context).textTheme.labelMedium),
        Flexible(child: Divider(color: Colors.grey, thickness: 0.5, indent: 5, endIndent: 60,)),
      ],
    );
  }
}
