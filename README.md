# flutter_spaceshooter
porting spaceshooter from golang to flutter, mainly a learning project for me.


In order to run in vscode spaces, will need to disable security

```bash
flutter/bin/flutter run -d web-server --web-hostname=0.0.0.0 --web-port=3000
chrome.exe --user-data-dir="C://Chrome dev session" --disable-web-security
C:\Program Files\Google\Chrome\Application\chrome.exe --user-data-dir="C://Chrome dev session" --disable-web-security
```