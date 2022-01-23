# generates built value assets
gen:
	flutter packages pub run build_runner build --delete-conflicting-outputs --build-filter='**.sg.g.dart'

# serves application as a web-server so it can be accessed via mobile device
webserver:
	flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
