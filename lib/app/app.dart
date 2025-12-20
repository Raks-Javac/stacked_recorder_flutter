import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_recorder/features/record/services/audio_player_service.dart';
import 'package:stacked_recorder/features/record/services/audio_recorder_service.dart';
import 'package:stacked_recorder/features/record/views/record_view.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [MaterialRoute(page: RecordView, initial: true)],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AudioRecorderService),
    LazySingleton(classType: AudioPlayerService),
  ],
)
class App {}
