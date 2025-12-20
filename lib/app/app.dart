import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_recorder/features/record/services/audio_effects_service.dart';
import 'package:stacked_recorder/features/record/services/audio_export_service.dart';
import 'package:stacked_recorder/features/record/services/audio_player_service.dart';
import 'package:stacked_recorder/features/record/services/audio_recorder_service.dart';
import 'package:stacked_recorder/features/record/views/audio_editor_view.dart';
import 'package:stacked_recorder/features/record/views/record_view.dart';
import 'package:stacked_services/stacked_services.dart';

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
