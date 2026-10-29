<div align="center">

# 🎬 Filmo

### Your Next Movie Starts Here.

A Flutter-based movie discovery application that helps users explore movies, discover new releases, search for their favorite titles, and manage a personal watchlist.

<br/>

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-8B6CEF)
![State Management](https://img.shields.io/badge/State%20Management-Cubit-764ABC)
![API](https://img.shields.io/badge/API-TMDB-01B4E4?logo=themoviedatabase)

<br/>

**[▶ Watch Application Demo](https://github.com/user-attachments/assets/7283ead6-492a-449c-9db4-437ed821ae94)**

</div>

---

## 📌 Overview

Filmo is a movie discovery application developed using Flutter and powered by the TMDB API.

It provides an interactive experience for exploring popular and top-rated movies, discovering upcoming releases, searching for movies, and viewing detailed movie information.

Users can also build their own watchlist, save movies locally, and manage their saved collection.

The project was developed with a focus on maintainable code, separation of concerns, reusable components, and scalable application structure.

---

## ✨ Key Features

| Feature                | Description                                                   |
| ---------------------- | ------------------------------------------------------------- |
| Animated Splash Screen | Smooth logo and application introduction animations.          |
| Onboarding             | Interactive introduction with persistent completion state.    |
| Home                   | Explore top-rated, popular, and upcoming movies.              |
| Movie Details          | View movie information, overview, genres, and cast.           |
| Similar Movies         | Discover movies related to the selected title.                |
| Search                 | Find movies using the TMDB search API.                        |
| Watch List             | Save, retrieve, and remove movies from a personal collection. |
| Custom Navigation      | Animated bottom navigation with scroll-aware visibility.      |

### Additional UI Features

* Modern dark-themed interface.
* Interactive movie carousels.
* Cached network images.
* Shimmer loading effects.
* Error handling and retry actions.
* Pull-to-refresh on the Home screen.
* Empty states and user feedback notifications.

---

## 🛠️ Tech Stack

**Core Technologies**

* Flutter & Dart
* BLoC / Cubit
* Clean Architecture
* Object-Oriented Programming
* SOLID Principles

**Networking & Data**

* REST API
* TMDB API
* HTTP
* Hive CE
* SharedPreferences

**Architecture & Dependency Management**

* Feature-First Structure
* GetIt
* Injectable
* Repository Pattern
* Use Case Pattern
* Data Mapping

**UI & Experience**

* Material Design
* Cached Network Image
* Google Fonts
* Shimmer Loading
* Custom Animations

**Development Tools**

* Git
* GitHub
* Postman

---

## 🏗️ Architecture

Filmo follows Clean Architecture principles, organizing the main movie features into separate architectural layers.

```text
lib/
│
├── app_section/
│
├── core/
│   ├── common/
│   ├── di/
│   ├── dialogs/
│   ├── network/
│   ├── utils/
│   └── widgets/
│
├── feature/
│   ├── onboarding/
│   │
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── details/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── search/
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

### Architectural Principles

* **Separation of Concerns:** Each layer has a clearly defined responsibility.
* **Repository Pattern:** Separating data access from business logic.
* **Use Cases:** Encapsulating application operations.
* **Dependency Injection:** Managing dependencies through GetIt and Injectable.
* **State Management:** Managing UI states using Cubit.
* **Reusable Components:** Keeping shared UI elements inside the Core layer.

---

## 🌐 API Integration

Filmo integrates with the [TMDB API](https://developer.themoviedb.org/docs) to retrieve movie information.

| Endpoint                      | Purpose           |
| ----------------------------- | ----------------- |
| `/3/movie/top_rated`          | Top-rated movies  |
| `/3/movie/popular`            | Popular movies    |
| `/3/movie/upcoming`           | Upcoming releases |
| `/3/movie/{movie_id}`         | Movie details     |
| `/3/movie/{movie_id}/similar` | Similar movies    |
| `/3/search/movie`             | Movie search      |

Movie details are retrieved along with cast and crew information using TMDB's `append_to_response` functionality.

---

## 💾 Local Storage

Filmo uses local storage to maintain user preferences and saved movies.

**Hive CE**

* Store watchlist movies locally.
* Retrieve saved movies.
* Remove movies from the collection.
* Preserve saved data between application sessions.

**SharedPreferences**

* Persist onboarding completion status.
* Remember whether the user has completed the introduction screens.

---

## 🚀 Getting Started

### Requirements

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* TMDB API credentials

### Installation

**1. Clone the repository**

```bash
git clone YOUR_REPOSITORY_URL
```

**2. Navigate to the project directory**

```bash
cd YOUR_PROJECT_DIRECTORY
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Configure TMDB API credentials**

Configure the TMDB API key using the project's environment configuration before running the application.

Never commit API credentials to the repository.

**5. Run the application**

```bash
flutter run
```

---

## 🎥 Application Demo

Explore Filmo in action:

<div align="center">

[▶ Click Here to Watch the Full Demo](https://github.com/user-attachments/assets/7283ead6-492a-449c-9db4-437ed821ae94)

</div>

---

## 👨‍💻 About the Developer

**Abdallrahman Mohamed Zidan**

Flutter Developer | Mobile Application Developer

Interested in building maintainable and scalable mobile applications, applying Clean Architecture, SOLID principles, and writing clean, reusable code.

---

## 🙏 Acknowledgments

* [The Movie Database (TMDB)](https://www.themoviedb.org/) for providing the movie data and API.
* Flutter and Dart communities for their valuable documentation and resources.

---

<div align="center">

**Made with Flutter 💙**

</div>
