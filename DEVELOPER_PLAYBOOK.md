# 📘 Developer Playbook: Stacked Recorder

> A comprehensive guide to building a Flutter audio recording and editing app with Stacked architecture

## 🎯 Project Overview

**Goal**: Create a beautiful audio recorder app with voice effects, editing capabilities, and export functionality using clean MVVM architecture.

**Key Requirements**:

- Clean architecture with Stacked (MVVM)
- High-quality audio recording
- Real-time waveform visualization
- Voice effects (chipmunk, deep voice)
- Audio editing and export
- Beautiful, animated UI

## 📋 Phase 1: Project Setup

### 1.1 Create Flutter Project

```bash
flutter create stacked_recorder
cd stacked_recorder
```

### 1.2 Add Dependencies

Add to `pubspec.yaml`:

```yaml
dependencies:
  # Architecture
  stacked: ^3.4.1
  stacked_services: ^1.3.0

  # Audio
  record: ^6.1.2
  flutter_soloud: ^3.4.7
  audio_waveforms: ^1.0.4

  # Permissions & Storage
  permission_handler: ^11.0.1
  path_provider: ^2.1.1

  # UI
  google_fonts: ^6.1.0
  flutter_animate: ^4.5.0

  # Export & Share
  share_plus: ^7.2.1
  path: ^1.8.3

dev_dependencies:
  build_runner: ^2.4.6
  stacked_generator: ^1.5.0
```

### 1.3 iOS Permissions

Add to `ios/Runner/Info.plist`:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Required for the user to record their audio</string>
```

### 1.4 Create Directory Structure

```
lib/
├── app/
│   └── app.dart
├── features/
│   └── record/
│       ├── services/
│       ├── viewmodels/
│       ├── views/
│       └── widgets/
└── main.dart
```

## 📋 Phase 2: Stacked Configuration

### 2.1 Create App Configuration

`lib/app/app.dart`:

```dart
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_recorder/features/record/views/record_view.dart';
import 'package:stacked_recorder/features/record/views/audio_editor_view.dart';
import 'package:stacked_recorder/features/record/services/audio_recorder_service.dart';
import 'package:stacked_recorder/features/record/services/audio_player_service.dart';
import 'package:stacked_recorder/features/record/services/audio_effects_service.dart';
import 'package:stacked_recorder/features/record/services/audio_export_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: RecordView, initial: true),
    MaterialRoute(page: AudioEditorView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AudioRecorderService),
    LazySingleton(classType: AudioPlayerService),
    LazySingleton(classType: AudioEffectsService),
    LazySingleton(classType: AudioExportService),
  ],
)
class App {}
```

### 2.2 Generate Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📋 Phase 3: Services Layer

### 3.1 Audio Recorder Service

**Key Implementation Points**:

- Use `record` package for audio capture
- Configure sample rate (16kHz-44.1kHz)
- Handle microphone permissions
- Save to WAV format for compatibility

**Critical Config**:

```dart
RecordConfig(
  encoder: AudioEncoder.pcm16bits,
  numChannels: 1,
  sampleRate: 24000,
  noiseSuppress: true,
  echoCancel: true,
)
```

### 3.2 Audio Player Service

**Key Implementation Points**:

- Use `flutter_soloud` for low-latency playback
- Implement buffer streaming (NOT file loading - causes crashes)
- Read file as bytes and stream to SoLoud
- Use `audio_waveforms` PlayerController for visualization only

**Critical Pattern**:

```dart
// Read file
final bytes = await File(path).readAsBytes();

// Create buffer stream
final stream = await SoLoud.instance.setBufferStream(
  bufferingType: BufferingType.released,
  format: BufferType.s16le,
);

// Play stream
final handle = await SoLoud.instance.play(stream);

// Add data
SoLoud.instance.addAudioDataStream(stream, bytes);
SoLoud.instance.setDataIsEnded(stream);
```

### 3.3 Audio Effects Service

**Implementation Strategy**:

- Manipulate WAV file headers for pitch shifting
- Adjust sample rate in header (bytes 24-27)
- Resample audio data:
  - **Chipmunk**: Skip samples (ratio > 1.0)
  - **Deep Voice**: Duplicate samples (ratio < 1.0)

**Key Algorithm**:

```dart
// For chipmunk: skip samples
for (int i = 0; i < audioData.length; i += 2) {
  if (i % ratio.round() == 0) {
    result.add(audioData[i]);
    result.add(audioData[i + 1]);
  }
}

// For deep voice: duplicate samples
for (int i = 0; i < audioData.length; i += 2) {
  for (int j = 0; j < duplicateFactor; j++) {
    result.add(audioData[i]);
    result.add(audioData[i + 1]);
  }
}
```

### 3.4 Export Service

**Features**:

- Copy audio files to app documents
- Share via system share sheet
- Handle file cleanup

## 📋 Phase 4: ViewModels

### 4.1 RecordViewModel

**Responsibilities**:

- Manage recording state
- Handle playback state
- Navigate to editor
- Expose controllers for waveforms

**Critical**: Don't use `onCompletion` listeners - they cause crashes!

### 4.2 AudioEditorViewModel

**Responsibilities**:

- Manage playback in editor
- Apply effects (pause audio first!)
- Handle export/share
- Track selected effect

## 📋 Phase 5: Views & UI

### 5.1 RecordView

**UI Components**:

- Pastel gradient background
- Recording waveform display
- Playback waveform display
- Action buttons (Record, Play)
- Status indicator
- "Proceed to Edit" button (conditional)

**Design Tips**:

- Use Google Fonts (Outfit, Nunito)
- Rounded corners everywhere
- Soft shadows
- Smooth animations

### 5.2 AudioEditorView

**UI Components**:

- Header with back button
- Waveform display
- Play/pause button
- Current effect indicator
- "Apply Effects" button
- Export button
- Share icon

### 5.3 Widgets

**ActionButton**:

- Animated pulse effect
- Color-coded (pink for record, blue for play)
- Icon + label

**WaveformDisplay**:

- RecordingWaveform (live visualization)
- PlayingWaveform (playback visualization)

**EffectsPanel**:

- Bottom sheet modal
- Effect chips with icons
- Selected state indication

## 🎨 Design System

### Colors

```dart
// Gradients
Colors.pink.shade50 → Colors.white → Colors.blue.shade50
Colors.purple.shade50 → Colors.white → Colors.pink.shade50

// Accents
Colors.pinkAccent (Record)
Colors.blueAccent (Play)
Colors.purpleAccent (Effects/Edit)
```

### Typography

```dart
GoogleFonts.outfit() // Headers
GoogleFonts.nunito() // Body text
```

## ⚠️ Common Pitfalls

### 1. **SoLoud File Loading Crashes**

❌ Don't use: `SoLoud.instance.loadFile(path)`
✅ Use: Buffer streaming with `setBufferStream()`

### 2. **Dual Playback Issue**

❌ Don't call both: `SoLoud.play()` AND `playerController.startPlayer()`
✅ Use SoLoud for audio, PlayerController for waveform only

### 3. **Echo/Tiny Voice Artifacts**

❌ Don't enable: `echoCancel: true` + `noiseSuppress: true`
✅ Test both on/off based on use case

### 4. **Completion Listener Crashes**

❌ Don't use: `playerController.onCompletion.listen()`
✅ Let audio play to completion or use manual stop

### 5. **Sample Rate Mismatch**

❌ Recording at 16kHz, playing at 44.1kHz
✅ Match sample rates in recorder and player services

## 🔧 Configuration Recommendations

### For Voice Recording

```dart
sampleRate: 16000-24000  // Good quality, smaller files
numChannels: 1           // Mono sufficient for voice
noiseSuppress: false     // Avoid artifacts
echoCancel: false        // Avoid tiny voice echo
```

### For Music Recording

```dart
sampleRate: 44100        // CD quality
numChannels: 2           // Stereo
noiseSuppress: false
echoCancel: false
```

## 📊 Testing Checklist

- [ ] Record audio on physical device
- [ ] Play back recorded audio
- [ ] Apply chipmunk effect
- [ ] Apply deep voice effect
- [ ] Reset to normal
- [ ] Export audio file
- [ ] Share via system sheet
- [ ] Navigate between screens
- [ ] Handle permissions properly
- [ ] Test on iOS and Android

## 🚀 Deployment

### iOS

1. Update `Info.plist` with microphone permission
2. Run `pod install` in ios directory
3. Test on physical device
4. Build: `flutter build ios`

### Android

1. Ensure permissions in `AndroidManifest.xml`
2. Test on physical device
3. Build: `flutter build apk`

## 📚 Key Learnings

1. **Architecture Matters**: Stacked MVVM keeps code organized
2. **Service Layer**: Encapsulate all audio logic in services
3. **Buffer Streaming**: More stable than file loading for SoLoud
4. **Sample Rate Manipulation**: Simple but effective for pitch shifting
5. **UI Polish**: Animations and gradients make a huge difference

## 🎓 Advanced Features (Future)

- [ ] Audio trimming with draggable handles
- [ ] More effects (reverb, echo)
- [ ] Multiple file management
- [ ] Cloud storage integration
- [ ] Waveform editing
- [ ] Real-time pitch correction

---

**Success Criteria**: A beautiful, functional audio recorder with clean architecture that doesn't crash and produces high-quality recordings with fun voice effects!
