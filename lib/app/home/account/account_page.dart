import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home/models/avatar_reference.dart';
import 'package:time_tracker/common_widgets/avatar.dart';
import 'package:time_tracker/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';
import 'package:time_tracker/services/firebase_storage_service.dart';
import 'package:time_tracker/services/image_picker_service.dart';

class AccountPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Signout Failed',
        exception: e,
      );
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignout = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout ?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignout == true) {
      _signOut(context);
    }
  }

  Future<void> _chooseAvatar(BuildContext context, User user) async {
    try {
      final imagePicker =
          Provider.of<ImagePickerService>(context, listen: false);
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        final storage =
            Provider.of<FirebaseStorageService>(context, listen: false);
        final downloadUrl = await storage.uploadAvatar(file: file);
        final database = Provider.of<Database>(context, listen: false);
        await database.setAvatarReference(
          AvatarReference(downloadUrl),
          user.uid,
        );
        await file.delete();
      }
    } catch (e) {
      print(e);
      PlatformAlertDialog(
        title: e.toString(),
        content: 'Can\'t upload Image right now',
        defaultActionText: 'Ok',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: _buildUserInfo(context, user),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, User user) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final avatarReference = snapshot.data;
          return Column(
            children: <Widget>[
              Avatar(
                photoUrl: avatarReference?.downloadUrl,
                radius: 50,
                borderColor: Colors.black,
                borderWidth: 2.0,
                onPressed: () => _chooseAvatar(context, user),
              ),
              SizedBox(
                height: 10,
              ),
              if (user.displayName != null)
                Text(
                  user.displayName,
                  style: TextStyle(color: Colors.white),
                ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
