Flutter Networking and API Integration
A beginner-friendly Flutter practical for undergraduate students to learn JSON parsing, Dart model classes, REST APIs, HTTP requests, asynchronous programming, and error handling.
1. Learning Objectives
By completing this practical, students will be able to:
Explain JSON and REST APIs.
Create Dart model classes using fromJson().
Read a local JSON asset in Flutter.
Make HTTP GET requests using the http package.
Understand Future, async, and await.
Decode JSON responses into Dart objects.
Display API data using Flutter widgets.
Handle loading, error, and empty states.
Organize a Flutter application using models, services, and screens.
Use Git and GitHub to manage and share source code.
2. Project Overview
This application contains two pages accessible through a bottom navigation bar.
Page 1: Sample JSON
Reads student information from a local JSON file bundled with the Flutter application.
Students learn how to:
Create a JSON file.
Register a JSON asset in pubspec.yaml.
Read JSON using rootBundle.loadString().
Decode JSON using jsonDecode().
Convert decoded data into a Dart model.
Display the result on the screen.
This page works offline.
Page 2: Live API Posts
Fetches posts from the JSONPlaceholder REST API.
API endpoint:
https://jsonplaceholder.typicode.com/posts
Students learn how to:
Send an HTTP GET request.
Receive an HTTP response.
Check the HTTP status code.
Decode a JSON array.
Convert JSON objects into Dart model instances.
Display posts using ListView.builder.
Handle loading, error, and empty states.
Refresh the API data.
This page requires an internet connection.
3. Technologies Used
Flutter
Dart
Material 3
http package
JSON
REST API
JSONPlaceholder
Git and GitHub
4. Prerequisites
Install the following tools:
Flutter SDK
Android Studio or Visual Studio Code
Android emulator or physical device
Git
Internet connection for the live API practical
Verify Flutter installation:
flutter doctor
5. Create the Project
Run these commands:
flutter create flutter_api_learning
cd flutter_api_learning
flutter pub add http
Open the project folder in your preferred IDE.
6. Project Structure
Create the following files and folders:
flutter_api_learning/
├── assets/
│   └── sample_student.json
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── student.dart
│   │   └── post.dart
│   ├── services/
│   │   ├── sample_json_service.dart
│   │   └── post_service.dart
│   └── screens/
│       ├── sample_json_page.dart
│       └── live_posts_page.dart
├── android/
├── pubspec.yaml
├── analysis_options.yaml
├── .gitignore
└── README.md
7. Step 1 — Create the Sample JSON
File location:
assets/sample_student.json
{
  "id": 101,
  "name": "Kamal Perera",
  "course": "BSc in Information Technology",
  "email": "kamal@example.com",
  "active": true
}
8. Step 2 — Register the JSON Asset
Open pubspec.yaml.
Under the existing flutter: section, add:
flutter:
  uses-material-design: true
  assets:
    - assets/sample_student.json
Keep the existing project configuration and ensure the YAML indentation is correct.
9. Step 3 — Create the Student Model
File location:
lib/models/student.dart
The Student class represents the fields in the sample JSON file.
Its Student.fromJson() factory constructor converts a decoded JSON map into a Dart object.
10. Step 4 — Create the Sample JSON Service
File location:
lib/services/sample_json_service.dart
The service:
Reads the asset using rootBundle.loadString().
Decodes the JSON using jsonDecode().
Converts the resulting map into a Student object.
11. Step 5 — Create the Sample JSON Screen
File location:
lib/screens/sample_json_page.dart
The screen displays student details and handles loading, error, and empty states.
Students should modify the JSON file and observe how the displayed information changes.
12. Step 6 — Create the Post Model
File location:
lib/models/post.dart
The Post model represents the fields returned by the API:
userId
id
title
body
The Post.fromJson() factory constructor converts an individual JSON object into a Dart Post.
13. Step 7 — Create the API Service
File location:
lib/services/post_service.dart
API endpoint:
https://jsonplaceholder.typicode.com/posts
The service uses:
http.get() to send the request.
async and await to handle the asynchronous operation.
response.statusCode to check the result.
jsonDecode() to parse the response.
Post.fromJson() to create model objects.
throw Exception() to report unsuccessful responses.
The method returns Future<List<Post>>.
14. Step 8 — Create the Live API Screen
File location:
lib/screens/live_posts_page.dart
The screen uses FutureBuilder<List<Post>> to display:
Loading indicator while waiting for data.
Error message if the request or parsing fails.
Empty state if the API returns an empty list.
Scrollable post cards when data is available.
Refresh button to make another API request.
15. Step 9 — Connect Both Pages
File location:
lib/main.dart
The main application uses NavigationBar to switch between:
Sample JSON
Live API
The application starts with the Sample JSON page selected.
16. Step 10 — Configure Android Internet Permission
Open:
android/app/src/main/AndroidManifest.xml
Add the following inside the root manifest element, before the application element:
<uses-permission android:name="android.permission.INTERNET" />
Keep all existing manifest configuration.
17. Step 11 — Run the Application
From the project root:
flutter pub get
flutter run
Select an available Android emulator or connected device.
If you have already started the application before adding the JSON asset, perform a full restart.
18. Important Theory
JSON
JSON is a text format for exchanging structured data.
Dart Model Class
A model class represents structured data as a Dart object.
REST API
A REST API allows applications to request or manipulate resources using HTTP.
HTTP GET
GET requests retrieve information from a server.
Future
A Future represents a value or error that becomes available later.
Async and Await
async and await simplify asynchronous programming.
JSON Decode
jsonDecode() converts JSON text into Dart data structures.
FutureBuilder
FutureBuilder builds the interface based on the state of an asynchronous operation.
Loading State
Displays a progress indicator while the application is waiting.
Error State
Displays an appropriate message when an operation fails.
Empty State
Displays a suitable message when no data is available.
19. Testing Checklist
Sample JSON page works offline.
Student details are displayed correctly.
Both navigation tabs work.
Live API data loads with an internet connection.
Post titles and descriptions are displayed correctly.
Refresh button makes another request.
Error state appears when a request fails.
Empty state is handled.
Application works on the selected emulator or device.
20. Common Errors
Asset Not Found
Check the filename and asset declaration in pubspec.yaml.
HTTP Request Failure
Check internet access, the endpoint URL, and Android internet permission.
JSON Parsing Error
Check the JSON structure and expected field types.
Missing Package
Run:
flutter pub get
Incorrect Import
Verify that the imported file exists at the specified location.
21. Student Exercises
Exercise 1: Modify the Sample JSON
Change the student name, email, and course.
Exercise 2: Add a Field
Add a phone number to the JSON file, update the Student model, and display the new field on the screen.
Exercise 3: Customize the Post Cards
Change the colors, typography, spacing, and card layout.
Exercise 4: Add Search
Add a text field that filters posts by title.
Exercise 5: Test Error Handling
Temporarily change the API URL to an invalid endpoint and observe the error state. Restore the correct URL afterward.
Exercise 6: Explain the Request Flow
Explain how data moves from the API response to the Dart model and then to the Flutter UI.
22. Suggested Assessment Rubric
Assessment criterion
Marks
JSON and model classes
20
HTTP request and API integration
20
UI design and data display
20
Loading, error, and empty states
20
Code quality and explanation
20
Total
100

23. GitHub Setup
Create a new repository on GitHub named:
flutter-networking-api-integration
Initialize Git in your project folder:
git init
git add .
git commit -m "Add Flutter JSON and API integration practical"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/flutter-networking-api-integration.git
git push -u origin main
Replace YOUR_USERNAME with your actual GitHub username and use the repository URL shown by GitHub.
Do not commit passwords, secret API keys, or private credentials.
24. Learning Outcome
After completing this practical, students should understand how to read local JSON data, request data from a REST API, convert JSON into Dart objects, and build a Flutter interface that responds appropriately to loading, success, error, and empty states.
References
Flutter Networking Cookbook: https://docs.flutter.dev/cookbook/networking
Flutter Fetch Data Tutorial: https://docs.flutter.dev/cookbook/networking/fetch-data
Dart Fetch Data Guide: https://dart.dev/server/fetch-data
JSONPlaceholder: https://jsonplaceholder.typicode.com/


