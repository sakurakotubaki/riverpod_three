.PHONY: setup
setup:
	fvm flutter clean
	fvm flutter pub get

.PHONY: watch
watch:
	fvm flutter pub run build_runner watch --delete-conflicting-outputs