# flutter_spaceshooter
porting spaceshooter from golang to flutter, mainly a learning project for me.


In order to run in vscode spaces, will need to disable security

```bash
flutter/bin/flutter run -d web-server --web-hostname=0.0.0.0 --web-port=3000
chrome.exe --user-data-dir="C://Chrome dev session" --disable-web-security
"C:\Program Files\Google\Chrome\Application\chrome.exe" --user-data-dir="C://Chrome dev session" --disable-web-security
```


Install fastlane

```bash
sudo gem install fastlane
cd android
fastlane init
```

Base64 data
```bash
cat key.properties | base64 -w 0
```

This will base64 encode files without newlines for you to copy as you see fit.

This project is made for fun and an attempt to make money on apps through ads (won't work).