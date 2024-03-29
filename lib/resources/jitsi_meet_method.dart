import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:zoom_app_clone/resources/firebase_method.dart';

import 'auth_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestore = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      String name =
          username.isEmpty ? _authMethods.user.displayName! : username;
      Map<String, Object> featureFlags = {};
      if (isAudioMuted) {
        featureFlags.putIfAbsent('startWithAudioMuted', () => true);
      }

      // Disable password requirement:
      // featureFlags.putIfAbsent('password', () => '');

      var options = JitsiMeetingOptions(
        roomNameOrUrl: 'my-name',
        serverUrl: 'https://meet.jit.si',
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "subject": "Zoom Clone Meeting",
          "displayName": name,
          "email": _authMethods.user.email,
          "avatar":
              "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
        },
        featureFlags: featureFlags,
      );

      _firestore.addToMeetingHistory(roomName);
      await JitsiMeetWrapper.joinMeeting(
        options: options,
        listener: JitsiMeetingListener(
          onConferenceWillJoin: (url) =>
              print("onConferenceWillJoin: url: $url"),
          onConferenceJoined: (url) => print("onConferenceJoined: url: $url"),
          onConferenceTerminated: (url, error) =>
              print("onConferenceTerminated: url: $url, error: $error"),
        ),
      );
    } catch (error) {
      print("error: $error");
    }
  }
}
