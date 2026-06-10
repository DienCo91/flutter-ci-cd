run:
	flutter run

build:
	flutter build apk

clean:
	flutter clean && flutter pub get

lint:
	flutter analyze

build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs