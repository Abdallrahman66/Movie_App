<div align="center">

# 🎬 Filmo

### Discover Movies. Explore Stories. Build Your Watchlist.

A modern movie discovery application built with Flutter, powered by The Movie Database (TMDB) API.

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-Framework-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-Language-0175C2?logo=dart)](https://dart.dev/)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-6C63FF)]()
[![State Management](https://img.shields.io/badge/State%20Management-BLoC%20%2F%20Cubit-764ABC)]()
[![API](https://img.shields.io/badge/API-TMDB-01B4E4?logo=themoviedatabase)](https://www.themoviedb.org/)

<br/>

**[Watch Demo](https://github.com/user-attachments/assets/7283ead6-492a-449c-9db4-437ed821ae94)**

</div>

---

## 📖 About Filmo

Filmo is a movie discovery application developed using Flutter, designed to provide users with a smooth and engaging experience when exploring movies.

The application integrates with the TMDB API to retrieve real-time movie information, including popular movies, top-rated movies, upcoming releases, detailed movie information, and similar recommendations.

Filmo also provides a personal Watch List, allowing users to save movies and manage their collections with locally persisted data.

The project focuses on clean code practices, separation of concerns, maintainable architecture, and reusable UI components.

---

## ✨ Features

### 🏠 Home

* Explore recommended and top-rated movies.
* Discover popular movies.
* Browse upcoming movie releases.
* Interactive movie carousels and movie cards.
* Pull-to-refresh functionality.
* Loading shimmer and error handling.

### 🎥 Movie Details

* Detailed movie information.
* Movie overview and synopsis.
* Movie genres and additional information.
* Cast and crew information.
* Discover similar movies.
* Navigate between related movies.

### 🔍 Search

* Search for movies using TMDB.
* Display matching movie results.
* Interactive movie selection.

### 🔖 Watch List

* Add and remove movies from your personal collection.
* Store saved movies locally using Hive CE.
* Persistent storage between application sessions.
* Swipe-to-delete functionality.
* Dedicated empty state.

### 🎨 UI/UX

* Modern dark-themed interface.
* Animated splash screen.
* Interactive onboarding experience.
* Custom animated bottom navigation bar.
* Smooth transitions and animations.
* Cached network images.
* Loading and error states.

---

## 🛠️ Tech Stack

| Technology              | Purpose                                |
| ----------------------- | -------------------------------------- |
| Flutter                 | Cross-platform application development |
| Dart                    | Programming language                   |
| Clean Architecture      | Separation of application layers       |
| Feature-First Structure | Organizing features independently      |
| BLoC / Cubit            | State management                       |
| GetIt                   | Dependency injection                   |
| Injectable              | Dependency registration                |
| REST API                | Remote data communication              |
| TMDB API                | Movie data provider                    |
| Hive CE                 | Local database and persistence         |
| SharedPreferences       | Simple local preferences               |
| Cached Network Image    | Efficient image loading and caching    |
| Google Fonts            | Typography                             |
| Git & GitHub            | Version control                        |

---

## 🏗️ Project Architecture

Filmo follows Clean Architecture principles with a Feature-First project structure.

Each major feature is organized into independent layers:

```text
lib/
│
├── app_section/
│
├── core/
│   ├── common/
│   ├── dialogs/
│   ├── di/
│   ├── network/
│   ├── utils/
│   └── widgets/
│
├── feature/
│   │
│   ├── onboarding/
│   │   ├── data/
│   │   └── presentation/
│   │
│   ├── home/
│   │   ├── data/
│   │   │   ├── api/
│   │   │   ├── mapper/
│   │   │   ├── model/
│   │   │   └── repo/
│   │   ├── domain/
│   │   │   ├── entity/
│   │   │   ├── repo/
│   │   │   └── use_case/
│   │   └── presentation/
│   │       ├── view/
│   │       ├── view_model/
│   │       └── widget/
│   │
│   ├── details/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── search/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── watch_list/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── reels/
│   │
│   └── menu_drawer/
│
└── main.dart
```

### Architecture Layers

**Presentation Layer**

* Screens and reusable widgets.
* Cubit and state management.
* Handles user interactions and UI states.

**Domain Layer**

* Business entities.
* Repository contracts.
* Use cases containing application business logic.

**Data Layer**

* API integrations.
* Data models and DTOs.
* Data mapping.
* Repository implementations.
* Remote and local data sources.

This separation helps maintain a scalable, testable, and maintainable codebase.

---

## 🌐 API Integration

Filmo uses [The Movie Database (TMDB)](https://www.themoviedb.org/) API to retrieve movie information.

### Integrated Endpoints

| Endpoint                      | Description                |
| ----------------------------- | -------------------------- |
| `/3/movie/popular`            | Retrieve popular movies    |
| `/3/movie/top_rated`          | Retrieve top-rated movies  |
| `/3/movie/upcoming`           | Retrieve upcoming releases |
| `/3/movie/{movie_id}`         | Retrieve movie details     |
| `/3/movie/{movie_id}/similar` | Retrieve similar movies    |
| `/3/search/movie`             | Search for movies          |

Movie details also include credits through TMDB's `append_to_response` functionality.

---

## 💾 Local Data Persistence

Filmo uses Hive CE to provide local storage for the Watch List.

Users can:

* Save movies to their personal collection.
* Retrieve saved movies.
* Remove individual movies.
* Keep their collection available after restarting the application.

SharedPreferences is also used to remember the onboarding completion state.

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* A TMDB API account and API key

### Installation

**1. Clone the repository**

```bash
git clone YOUR_REPOSITORY_URL
```

**2. Navigate to the project directory**

```bash
cd movie_app
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Configure your TMDB API key**

Configure your API key through the application's configuration mechanism before running the project.

Do not commit API credentials or secrets to the repository.

**5. Run the application**

```bash
flutter run
```

---

## 🎬 Demo

Watch the application demo to explore Filmo's interface, navigation, movie discovery experience, search functionality, movie details, and Watch List.

<div align="center">

[▶ Watch Filmo Demo](https://github.com/user-attachments/assets/7283ead6-492a-449c-9db4-437ed821ae94)

</div>

---

## 👨‍💻 Developer

**Abdallrahman Mohamed Zidan**

Mobile Application Developer | Flutter Developer

Interested in building scalable mobile applications with Flutter, Clean Architecture, and maintainable software design.

---

## 🙏 Acknowledgments

* [The Movie Database (TMDB)](https://www.themoviedb.org/) for providing movie data and API services.
* Flutter and Dart communities for their documentation and resources.

---

<div align="center">

**Built with Flutter 💙**

</div>
