# stacked_recorder_flutter

A Flutter application demonstrating a clean implementation of audio recording and playback using Stacked Architecture. This project leverages `record` for lightweight audio capturing and `flutter_soloud` for high-performance audio management.

## 🚀 Overview

The goal of this repository is to provide a boilerplate or reference for developers looking to handle audio in Flutter without the "spaghetti code" often associated with hardware controllers. By using the Stacked (MVVM) approach, we ensure that the audio state is decoupled from the View.

## 🛠 Tech Stack

- **State Management**: Stacked (MVVM pattern)
- **Audio Playback**: `flutter_soloud` (C++ backed, low latency)
- **Audio Recording**: `record` (Lightweight and feature-rich)
- **Dependency Injection**: `get_it` and `stacked_services`

## 📁 Architecture Structure

The project follows the standard Stacked directory structure to maintain a clear separation of concerns:

- **Services**: Wrappers around `flutter_soloud` and `record`. This is where the raw logic lives.
- **ViewModels**: Consumes the services and exposes state (isRecording, duration, etc.) to the UI.
- **Views**: Pure UI components that react to ViewModel changes.

## ✨ Features

- [x] **Record Audio**: Start, stop, and pause recordings with real-time amplitude monitoring.
- [ ] **Low-latency Playback**: Using SoLoud for snappy audio response.
- [x] **Permission Handling**: Clean flow for microphone access.
- [x] **Reactive UI**: Automatic UI updates as audio state changes.

## 🏁 Getting Started

### Prerequisites

- Flutter SDK (Latest stable version)
- A physical device (Microphone features are often limited on emulators/simulators)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/stacked_recorder_flutter.git
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Generate the Stacked code:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## 🤝 Contributing

Feel free to open issues or submit pull requests to improve the audio handling implementation!
