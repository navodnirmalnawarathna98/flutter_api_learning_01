# Flutter JSON Parsing and API Integration

A beginner-friendly Flutter practical demonstrating how to load local JSON data from an asset, convert JSON into Dart model objects, display a list of students, and fetch posts from a live REST API.

## Learning objectives

By completing this practical, students will be able to:

- Explain the difference between local JSON data and data fetched from an API.
- Register and load a JSON asset in Flutter.
- Parse JSON into Dart model classes.
- Display a list of model objects using `ListView.builder`.
- Send an HTTP GET request to a REST API.
- Handle loading, error, empty, and refresh states.

## Requirements

- Flutter SDK installed
- Android Studio or Visual Studio Code
- Android emulator, Android device, or another supported Flutter target
- Internet access for the live API page

## Project structure

Create the following structure in the project root:

```text
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
└── pubspec.yaml
```

> The snippets below are a reference implementation. Ensure the file names and imports match your project exactly.

## 1. Create the project

Open a terminal and run:

```bash
flutter create flutter_api_learning
cd flutter_api_learning
flutter pub add http
```

## 2. Add 10 sample student records

Create `assets/sample_student.json`:

```json
[
  {
    "id": 1,
    "name": "Kamal Perera",
    "course": "BSc in Information Technology",
    "email": "kamal@example.com",
    "active": true
  },
  {
    "id": 2,
    "name": "Nimali Silva",
    "course": "Software Engineering",
    "email": "nimali@example.com",
    "active": true
  },
  {
    "id": 3,
    "name": "Kasun Fernando",
    "course": "Computer Science",
    "email": "kasun@example.com",
    "active": false
  },
  {
    "id": 4,
    "name": "Tharushi Perera",
    "course": "Information Systems",
    "email": "tharushi@example.com",
    "active": true
  },
  {
    "id": 5,
    "name": "Sahan Jayawardena",
    "course": "Cyber Security",
    "email": "sahan@example.com",
    "active": true
  },
  {
    "id": 6,
    "name": "Dinithi Fernando",
    "course": "Data Science",
    "email": "dinithi@example.com",
    "active": false
  },
  {
    "id": 7,
    "name": "Isuru Madushan",
    "course": "Software Engineering",
    "email": "isuru@example.com",
    "active": true
  },
  {
    "id": 8,
    "name": "Pavithra Silva",
    "course": "BSc in Information Technology",
    "email": "pavithra@example.com",
    "active": true
  },
  {
    "id": 9,
    "name": "Ravindu Lakshan",
    "course": "Computer Networks",
    "email": "ravindu@example.com",
    "active": false
  },
  {
    "id": 10,
    "name": "Sachini Wijesinghe",
    "course": "Artificial Intelligence",
    "email": "sachini@example.com",
    "active": true
  }
]
```

## 3. Register the JSON asset

In `pubspec.yaml`, add the asset under the existing `flutter:` section. Keep indentation consistent and use spaces, not tabs.

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/sample_student.json
```

If `uses-material-design: true` is already present, do not add a second `flutter:` section. Add only the `assets:` lines beneath the existing section.

## 4. Create the Student model

Create `lib/models/student.dart`:

```dart
class Student {
  final int id;
  final String name;
  final String course;
  final String email;
  final bool active;

  const Student({
    required this.id,
    required this.name,
    required this.course,
    required this.email,
    required this.active,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      name: json['name'] as String,
      course: json['course'] as String,
      email: json['email'] as String,
      active: json['active'] as bool,
    );
  }
}
```

## 5. Create the local JSON service

Create `lib/services/sample_json_service.dart`:

```dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/student.dart';

class SampleJsonService {
  Future<List<Student>> loadStudents() async {
    final jsonString = await rootBundle.loadString(
      'assets/sample_student.json',
    );

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData
        .map((item) => Student.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
```

What happens here?

1. `rootBundle.loadString()` reads the asset file.
2. `jsonDecode()` converts the JSON text into Dart data.
3. `Student.fromJson()` converts each map into a `Student` object.
4. `map()` and `toList()` produce a `List<Student>`.

## 6. Create the Post model

Create `lib/models/post.dart`:

```dart
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
```

## 7. Create the live API service

Create `lib/services/post_service.dart`:

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  static const String _url =
      'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load posts. HTTP status: ${response.statusCode}',
      );
    }

    final List<dynamic> jsonData = jsonDecode(response.body);

    return jsonData
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
```

The JSONPlaceholder endpoint provides example posts for practice. It is a public demonstration API, not a database for private student data.

## 8. Create the local JSON page

Create `lib/screens/sample_json_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/sample_json_service.dart';

class SampleJsonPage extends StatefulWidget {
  const SampleJsonPage({super.key});

  @override
  State<SampleJsonPage> createState() => _SampleJsonPageState();
}

class _SampleJsonPageState extends State<SampleJsonPage> {
  final SampleJsonService _service = SampleJsonService();
  late Future<List<Student>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = _service.loadStudents();
  }

  void _reload() {
    setState(() {
      _studentsFuture = _service.loadStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local JSON Students'),
        actions: [
          IconButton(
            tooltip: 'Reload students',
            onPressed: _reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Student>>(
        future: _studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    Text('Could not load students:\n${snapshot.error}'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _reload,
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final students = snapshot.data ?? [];

          if (students.isEmpty) {
            return const Center(child: Text('No student records found.'));
          }

          return RefreshIndicator(
            onRefresh: () async => _reload(),
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(student.id.toString()),
                    ),
                    title: Text(student.name),
                    subtitle: Text(
                      '${student.course}\n${student.email}',
                    ),
                    isThreeLine: true,
                    trailing: Icon(
                      student.active ? Icons.check_circle : Icons.cancel,
                      color: student.active ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
```

## 9. Create the live posts page

Create `lib/screens/live_posts_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class LivePostsPage extends StatefulWidget {
  const LivePostsPage({super.key});

  @override
  State<LivePostsPage> createState() => _LivePostsPageState();
}

class _LivePostsPageState extends State<LivePostsPage> {
  final PostService _service = PostService();
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _service.fetchPosts();
  }

  Future<void> _reload() async {
    setState(() {
      _postsFuture = _service.fetchPosts();
    });
    try {
      await _postsFuture;
    } catch (_) {
      // FutureBuilder displays the error state.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live API Posts'),
        actions: [
          IconButton(
            tooltip: 'Refresh posts',
            onPressed: _reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Loading posts...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, size: 48),
                    const SizedBox(height: 12),
                    Text('Could not load posts:\n${snapshot.error}'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _reload,
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final posts = snapshot.data ?? [];

          if (posts.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Post #${post.id} • User ${post.userId}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(post.body),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
```

## 10. Set up navigation in `main.dart`

Replace the contents of `lib/main.dart` with:

```dart
import 'package:flutter/material.dart';
import 'screens/sample_json_page.dart';
import 'screens/live_posts_page.dart';

void main() {
  runApp(const ApiLearningApp());
}

class ApiLearningApp extends StatelessWidget {
  const ApiLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON and API Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const LearningHomePage(),
    );
  }
}

class LearningHomePage extends StatefulWidget {
  const LearningHomePage({super.key});

  @override
  State<LearningHomePage> createState() => _LearningHomePageState();
}

class _LearningHomePageState extends State<LearningHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    SampleJsonPage(),
    LivePostsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Local JSON',
          ),
          NavigationDestination(
            icon: Icon(Icons.cloud_outlined),
            selectedIcon: Icon(Icons.cloud),
            label: 'Live API',
          ),
        ],
      ),
    );
  }
}
```

The first page is selected by default because `_selectedIndex = 0`. This implementation builds only the selected page, so the live API request starts when the user opens the Live API tab.

## 11. Android internet permission

The local JSON page does not require internet. The live API page does.

Open `android/app/src/main/AndroidManifest.xml`. Add this permission directly inside the `<manifest>` element and before `<application>`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

Do not add a second `<manifest>` or `<application>` element.

## 12. Run the app

From the project root, run:

```bash
flutter pub get
flutter run
```

If Flutter cannot find the asset after you register it, perform a full restart:

```bash
flutter clean
flutter pub get
flutter run
```

## Troubleshooting

### `Unable to load asset: assets/sample_student.json`

Check all of the following:

- The file exists at `assets/sample_student.json`.
- The file is in the project root's `assets` folder, not inside `lib`.
- The asset path in `pubspec.yaml` is exactly `assets/sample_student.json`.
- The `assets:` section is indented under the existing `flutter:` section.
- You saved `pubspec.yaml`, ran `flutter pub get`, and restarted the app.

### `Target of URI doesn't exist: package:http/http.dart`

Run:

```bash
flutter pub add http
flutter pub get
```

### API request fails

- Check the device/emulator internet connection.
- Confirm the Android internet permission is present.
- Check that the API URL is correct.
- Try opening `https://jsonplaceholder.typicode.com/posts` in a browser.
- Read the error displayed on the Live API page.

### JSON parsing type error

Ensure that the JSON field names and types match the Dart model. For example, `active` must be a Boolean (`true` or `false`), not the text `"true"` or `"false"`.

## Practical activities

1. Change the details of one student in the JSON file and observe the result.
2. Add an `age` field to every student and update the Dart model and UI.
3. Display only active students.
4. Add a search field to filter students by name.
5. Display the number of students at the top of the local JSON page.
6. In the API page, display only the first 10 posts.
7. Add a button to show the post body in a separate details screen.
8. Compare local JSON loading with a live HTTP GET request.

## Key concepts

| Concept | Meaning |
|---|---|
| JSON | A text format for storing and exchanging structured data |
| `jsonDecode()` | Converts JSON text into Dart objects such as lists and maps |
| Model class | Represents data using Dart fields and constructors |
| `fromJson()` | Converts a JSON map into a model object |
| Asset | A file packaged with the Flutter application |
| REST API | An interface that allows software to exchange data over HTTP |
| HTTP GET | Requests data from a server |
| `Future` | Represents a result that may become available later |
| `FutureBuilder` | Builds UI based on a future's loading, success, or error state |
| `ListView.builder` | Efficiently builds a scrollable list of items |

## Push the project to GitHub

Create an empty repository on GitHub, then run these commands from the project root. Replace the URL with your own repository URL.

```bash
git init
git add .
git commit -m "Add Flutter JSON parsing and API integration practical"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/flutter_api_learning.git
git push -u origin main
```

If Git says that a remote named `origin` already exists, check it with:

```bash
git remote -v
```

Then update it if necessary:

```bash
git remote set-url origin https://github.com/YOUR-USERNAME/flutter_api_learning.git
```

## Submission checklist

- [ ] Project runs without compile errors.
- [ ] The local JSON page displays 10 students.
- [ ] The student data is parsed using a Dart model.
- [ ] The Live API page fetches and displays posts.
- [ ] Loading and error states are handled.
- [ ] Refresh actions work.
- [ ] The `pubspec.yaml` asset registration is correct.
- [ ] The project README and source code are pushed to GitHub.
- [ ] Screenshots of both pages are included in the submission if required.

## References

- Flutter documentation: https://docs.flutter.dev/
- Flutter assets and images: https://docs.flutter.dev/ui/assets/assets-and-images
- Dart JSON serialization: https://dart.dev/libraries/dart-convert
- HTTP package: https://pub.dev/packages/http
- JSONPlaceholder test API: https://jsonplaceholder.typicode.com/

---

**Practical title:** Flutter Local JSON Parsing and REST API Integration  
**Suggested level:** Beginner  
**Suggested estimated time:** 2–3 hours
