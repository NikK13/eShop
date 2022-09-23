import 'package:e_shop/domain/utils/app.dart';
import 'package:e_shop/domain/utils/appnavigator.dart';
import 'package:e_shop/domain/utils/localization.dart';
import 'package:e_shop/domain/utils/styles.dart';
import 'package:e_shop/feature/widgets/animation/show_up.dart';
import 'package:e_shop/feature/widgets/general/input.dart';
import 'package:e_shop/feature/widgets/general/loading.dart';
import 'package:e_shop/feature/widgets/general/toast.dart';
import 'package:e_shop/feature/widgets/platform/platform_button.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/material.dart';

class LoginPageMobile extends StatefulWidget {
  const LoginPageMobile({Key? key}) : super(key: key);

  @override
  State<LoginPageMobile> createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<LoginPageMobile> {
  bool _isForSignUp = false;
  bool _isInProgress = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: FittedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 170
                    ),
                    child: ShowUpAnimated(
                      delay: 300,
                      child: Text(
                        App.appName,
                        style: TextStyle(
                          fontSize: 170,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(_isForSignUp)
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: InputField(
                            controller: _nameController,
                            inputType: TextInputType.text,
                            hint: AppLocalizations.of(context, 'nickname'),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: InputField(
                        controller: _emailController,
                        inputType: TextInputType.emailAddress,
                        hint: AppLocalizations.of(context, 'email'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: InputField(
                        controller: _passwordController,
                        isPassword: true,
                        hint: AppLocalizations.of(context, 'password'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if(!_isForSignUp)
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: Text(
                                AppLocalizations.of(context, 'password_forgot'),
                                style: TextStyle(
                                  color: prefsProvider.theme.accentColor,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                      child: !_isInProgress ? Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: PlatformButton(
                            fontSize: 18,
                            text: !_isForSignUp ?
                            AppLocalizations.of(context, 'login') :
                            AppLocalizations.of(context, 'sign_up'),
                            onPressed: () async{
                              final email = _emailController.text.trim();
                              final pass = _passwordController.text.trim();
                              final name = _nameController.text.trim();
                              if(email.isNotEmpty && pass.isNotEmpty &&
                                (_isForSignUp ? name.isNotEmpty : true)){
                                setState(() => _isInProgress = true);
                                if(_isForSignUp){
                                  await firebaseBloc.createAccount(
                                    context,
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                    (){
                                      _emailController.clear();
                                      _nameController.clear();
                                      _passwordController.clear();
                                      setState(() => _isForSignUp = false);
                                    }
                                  );
                                }
                                else{
                                  await firebaseBloc.signIn(
                                    context,
                                    _emailController.text,
                                    _passwordController.text
                                  );
                                }
                                setState(() => _isInProgress = false);
                              }
                              else{
                                Toast.show(
                                  context: context,
                                  text: AppLocalizations.of(context, 'empty_fields'),
                                  icon: const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  )
                                );
                              }
                            },
                          ),
                        ),
                      ) : const LoadingView()
                    ),
                  ],
                )
              ),
              Center(
                child: TextButton(
                  onPressed: (){
                    setState(() => _isForSignUp = !_isForSignUp);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: prefsProvider.theme.accentColor,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: appFont
                    )
                  ),
                  child: Text(
                    !_isForSignUp ?
                    AppLocalizations.of(context, 'account_create') :
                    AppLocalizations.of(context, 'account_exists')
                  )
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        )
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}


