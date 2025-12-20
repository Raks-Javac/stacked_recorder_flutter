# Stacked Audio Recorder 🎙️✨

A beautiful, cute, and functional audio recorder built with Flutter using the **Stacked** architecture.

## Features 🌟

- **Cute UI**: A soft "Audio Garden" aesthetic with pastel gradients and rounded typography.
- **Waveform Visualization**: Real-time waveforms for both recording and playback.
- **Stacked Architecture**: Clean MVVM structure (Views, Viewmodels, Services).
- **Smooth Animations**: Interactive buttons with hover and pulse effects.
- **Feature-Based Structure**: Scalable organization under `lib/features/record/`.

## Preview 📸

> [!NOTE]
> Screenshots coming soon!

## Getting Started 🚀

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/stacked_recorder.git
   ```
2. Navigate to the project directory:
   ```bash
   cd stacked_recorder
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Generate code using build_runner:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
5. Run the app:
   ```bash
   flutter run
   ```

## Tech Stack 🛠️

- **Architecture**: [Stacked](https://pub.dev/packages/stacked)
- **Audio**: [audio_waveforms](https://pub.dev/packages/audio_waveforms)
- **Fonts**: [google_fonts](https://pub.dev/packages/google_fonts) (Nunito, Outfit)
- **Animations**: [flutter_animate](https://pub.dev/packages/flutter_animate)
- **State Management**: Stacked ViewModels

## Folder Structure 📂

```
lib/
├── app/                  # App configuration (Locator, Router)
├── features/
│   └── record/           # Recording Feature
│       ├── services/     # Audio services
│       ├── viewmodels/   # Business logic
│       ├── views/        # UI layer
│       └── widgets/      # Feature-specific widgets
└── main.dart             # Entry point
```

## Contributing 🤝

Feel free to fork this project and add more "magic" to the Audio Garden!
# stacked_recorder_flutter
