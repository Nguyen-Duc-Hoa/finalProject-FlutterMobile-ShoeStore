import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';

class AuthService{
  final FirebaseAuth _auth =FirebaseAuth.instance;
  final storage= new FlutterSecureStorage();
  Users? _userFromFirebaseUser(User? user){

    return user != null ? Users(uid:user.uid,email:user.email,name:user.displayName,avatar: user.photoURL,phone: user.phoneNumber) : null;
  }
  Stream<Users?> get user{

    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
  Future signInAnon() async
  {
    try{
      UserCredential result =await _auth.signInAnonymously();
      User ? user = result.user;
      return user;
    }
    catch(e){
      print(e);
      return null;
    }
  }
  Future registerUsingEmailPassword(String name, String email, String password) async {
    try {

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User ? user = userCredential.user;

      user = _auth.currentUser!;
      await user.sendEmailVerification();
      return user;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        print('weak');
        return 0;
      } else if (e.code == 'email-already-in-use') {
        print('already');
        return 1;
      }
      else
        {
          return 2;
        }
    } catch (e) {
      print(e);
    }
  }

  Future signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User ? user = userCredential.user;
      user = _auth.currentUser!;
      if(user.emailVerified==false)
        {
          return 3;
        }
      else
        {
          storeTokenandData(userCredential);

          return user;
        }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 0;

      } else if (e.code == 'wrong-password') {
        return 1;

      }
      else{
        print(e.code);
        return 2;
      }
    }


  }
  Future signOut() async{
    try{
       await _auth.signOut();
       await storage.delete(key: 'uid');
    }
    catch(e){
print(e);
return null;
    }
  }
  updateUserProfile(String value,String type){
    User? user  = _auth.currentUser;

    if (user != null) {
      try{
        if(type=='email')
        {
          user.updateEmail(value);
        }
        else if(type=='name')
        {
          user.updateDisplayName(value);
        }
        else
        {
          user.updatePhotoURL(value);
        }
      }
      catch(e){
        print(e);
      }
  }
  }
  Future storeTokenandData(UserCredential userCredential) async{
   
   // await storage.write(key: 'token', value: userCredential.credential!.token.toString());
   // await storage.write(key: 'userCredential', value: userCredential.toString());
    await storage.write(key: 'uid', value: userCredential.user!.uid);
  }
  // Future getToken() async{
  //   return storage.read(key: 'token');
  // }
  Future getUid() async{
    return storage.read(key: 'uid');
  }
}