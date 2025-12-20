# 📸 Screenshot & Demo Guide

This guide helps you capture screenshots and demo videos for the README.

## 📱 Required Screenshots

Place all screenshots in the `screenshots/` directory with these exact names:

### 1. Recording Screen (`recording_screen.png`)

**What to capture**:

- Main screen showing the recording interface
- Both waveform sections visible
- Record and Play buttons
- Status indicator showing "Idle" or "Recording"

**How to capture**:

1. Open the app
2. Take a screenshot (iOS: Volume Up + Power, Android: Volume Down + Power)
3. Crop to show just the app (no status bar if possible)
4. Save as `recording_screen.png`

### 2. Audio Editor (`editor_screen.png`)

**What to capture**:

- Audio editor screen
- Waveform display
- Play/pause button
- "Apply Effects" and "Export Audio" buttons
- Current effect indicator

**How to capture**:

1. Record some audio
2. Tap "Proceed to Edit"
3. Take a screenshot
4. Save as `editor_screen.png`

### 3. Effects Panel (`effects_panel.png`)

**What to capture**:

- Bottom sheet with effects
- All three effect options (Normal, Chipmunk, Deep Voice)
- One effect selected (highlighted)

**How to capture**:

1. In the editor, tap "Apply Effects"
2. Select an effect (e.g., Chipmunk)
3. Take a screenshot
4. Save as `effects_panel.png`

### 4. Demo GIF/Video (`demo.gif` or `demo.mov`)

**What to record**:

- Complete user flow:
  1. Tap Record button
  2. Speak into mic (show waveform animating)
  3. Stop recording
  4. Tap "Proceed to Edit"
  5. Tap "Apply Effects"
  6. Select "Chipmunk"
  7. Tap Play to preview
  8. Tap "Export Audio"

**How to record**:

- **iOS**: Use built-in screen recording (Control Center)
- **Android**: Use built-in screen recorder or AZ Screen Recorder
- Keep video under 30 seconds
- Convert to GIF using online tool (e.g., ezgif.com) or keep as .mov

## 🎨 Screenshot Tips

### Sizing

- **Width**: 300-400px for README (will be resized in markdown)
- **Format**: PNG for screenshots, GIF/MOV for demos
- **Quality**: High resolution (retina/2x if possible)

### Editing

1. **Crop**: Remove unnecessary UI elements
2. **Resize**: Use Preview (Mac) or Paint (Windows)
   - Target width: ~1080px (will display at 300px in README)
3. **Compress**: Use TinyPNG or similar to reduce file size

### Tools

- **Mac**: Preview for editing, QuickTime for screen recording
- **Windows**: Paint for editing, Xbox Game Bar for recording
- **Online**: ezgif.com for GIF conversion, tinypng.com for compression

## 📁 File Organization

```
screenshots/
├── recording_screen.png    # Main recording interface
├── editor_screen.png       # Audio editor view
├── effects_panel.png       # Effects selection panel
└── demo.gif               # Complete user flow demo
```

## ✅ Checklist

Before committing:

- [ ] All 3 screenshots captured
- [ ] Demo video/GIF created
- [ ] Files properly named
- [ ] Images compressed (<500KB each)
- [ ] Demo GIF under 5MB
- [ ] Screenshots show the app in a good state (no errors)
- [ ] UI looks polished in screenshots

## 🔄 Updating README

After adding screenshots, the README will automatically display them:

```markdown
<img src="screenshots/recording_screen.png" width="300" alt="Recording Screen"/>
```

The `width="300"` ensures images aren't too large in the README.

---

**Note**: If you don't have screenshots yet, you can commit the README with placeholder paths. Add actual screenshots later when you have the app running on a device.
