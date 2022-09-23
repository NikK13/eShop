import 'package:e_shop/domain/utils/appnavigator.dart';
import 'package:e_shop/domain/utils/localization.dart';
import 'package:e_shop/feature/bloc/bloc.dart';
import 'package:e_shop/feature/ui/home/home.dart';
import 'package:e_shop/feature/widgets/general/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseBloc implements BaseBloc{
  final _fbUser = BehaviorSubject<User?>();

  Stream<User?> get userStream => _fbUser.stream;
  Function(User?) get signUser => _fbUser.sink.add;

  late FirebaseAuth fbAuth;

  String? username;
  String? image;

  bool emailValidated(email) => email.contains("@") &&
      email.length >= 4;

  bool passwordValidated(password) => password.length >= 6;
  bool nameValidated(name) => name.length >= 2;

  FirebaseBloc() {
    load();
  }

  load() async {
    fbAuth = FirebaseAuth.instance;
    signUser(fbAuth.currentUser);
    //if (fbAuth.currentUser != null) indicateUserProfile(fbAuth.currentUser!);
  }

  signOutUser() {
    signUser(null);
    fbAuth.signOut();
  }

  Future<void> createAccount(context, name, email, password, onSuccess) async {
    if(emailValidated(email) && passwordValidated(password) && nameValidated(name)){
      try {
        final UserCredential user = await fbAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if(user.user != null){
          await user.user!.sendEmailVerification();
          await createUserProfile(user.user!, name, email);
          await fbAuth.signOut();
          Toast.show(
            context: context,
            text: AppLocalizations.of(context, 'sign_up_success'),
            icon: const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            )
          );
          onSuccess();
        }
      } on FirebaseAuthException catch (e) {
        Toast.show(
          context: context,
          text: e.message.toString(),
          icon: const Icon(
            Icons.error_outline,
            color: Colors.red,
          )
        );
      }
    }
    else{
      if(!emailValidated(email)){
        Toast.show(
          context: context,
          text: AppLocalizations.of(context, 'error_email'),
          icon: const Icon(
            Icons.error_outline,
            color: Colors.red,
          )
        );
      }
      if(!nameValidated(name)){
        Toast.show(
          context: context,
          text: AppLocalizations.of(context, 'error_name'),
          icon: const Icon(
            Icons.error_outline,
            color: Colors.red,
          )
        );
      }
      if(!passwordValidated(email)){
        Toast.show(
          context: context,
          text: AppLocalizations.of(context, 'error_password'),
          icon: const Icon(
            Icons.error_outline,
            color: Colors.red,
          )
        );
      }
    }
  }

  Future<void> signIn(context, email, password) async {
    try {
      await fbAuth.signInWithEmailAndPassword(email: email, password: password);
      if(fbAuth.currentUser != null){
        if(fbAuth.currentUser!.emailVerified){
          AppNavigator.of(context).closeThenPush(const HomePage());
        }
        else{
          await fbAuth.signOut();
          Toast.show(
            context: context,
            text: AppLocalizations.of(context, 'login_verify'),
            icon: const Icon(
              Icons.error_outline,
              color: Colors.red,
            )
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      Toast.show(
        context: context,
        text: e.message.toString(),
        icon: const Icon(
          Icons.error_outline,
          color: Colors.red,
        )
      );
    }
  }

  updateUserData({required Map<String, dynamic> data}) async {
    final db = FirebaseDatabase.instance.ref().child('users/${fbAuth.currentUser!.uid}');
    await db.once().then((child) {
      db.child(fbAuth.currentUser!.uid).parent!.update(data);
    });
  }

  createUserProfile(user, name, email) async {
    final db = FirebaseDatabase.instance.ref().child('users/${user.uid}');
    await db.once().then((child) {
      if (!child.snapshot.exists) {
        debugPrint("Value was null: ${child.snapshot.value}");
        db.child(user.uid).parent!.set(<String, dynamic>{
          "username": name,
          "email": email,
          "image": "default",
        });
      }
    });
  }

  @override
  dispose() {
    _fbUser.close();
  }
}