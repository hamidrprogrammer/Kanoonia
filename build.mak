name :=	kanoon_$(shell date +%FT%T%Z).apk

builder:
	flutter build apk --release --split-per-abi && \
	mv /home/astra/AndroidStudioProjects/kanooniha/build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk /home/astra/Videos/$(name)

builderMac:
	flutter build apk --release --split-per-abi && \
	mv //Users/mohamad/flutterProjects/KanoonihaApp/build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk /Users/mohamad/Documents/kanoonApps/$(name)

builderWin:
	flutter build apk --release --split-per-abi && \
	mv C:\Users\Elm-Novin\StudioProjects\KanoonihaApp\build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk D:\$(name)