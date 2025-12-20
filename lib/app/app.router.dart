// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_recorder/features/record/views/audio_editor_view.dart'
    as _i3;
import 'package:stacked_recorder/features/record/views/record_view.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i5;

class Routes {
  static const recordView = '/';

  static const audioEditorView = '/audio-editor-view';

  static const all = <String>{
    recordView,
    audioEditorView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.recordView,
      page: _i2.RecordView,
    ),
    _i1.RouteDef(
      Routes.audioEditorView,
      page: _i3.AudioEditorView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.RecordView: (data) {
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.RecordView(),
        settings: data,
      );
    },
    _i3.AudioEditorView: (data) {
      final args = data.getArgs<AudioEditorViewArguments>(nullOk: false);
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.AudioEditorView(
            key: args.key, audioFilePath: args.audioFilePath),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AudioEditorViewArguments {
  const AudioEditorViewArguments({
    this.key,
    required this.audioFilePath,
  });

  final _i4.Key? key;

  final String audioFilePath;

  @override
  String toString() {
    return '{"key": "$key", "audioFilePath": "$audioFilePath"}';
  }

  @override
  bool operator ==(covariant AudioEditorViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.audioFilePath == audioFilePath;
  }

  @override
  int get hashCode {
    return key.hashCode ^ audioFilePath.hashCode;
  }
}

extension NavigatorStateExtension on _i5.NavigationService {
  Future<dynamic> navigateToRecordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.recordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAudioEditorView({
    _i4.Key? key,
    required String audioFilePath,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.audioEditorView,
        arguments:
            AudioEditorViewArguments(key: key, audioFilePath: audioFilePath),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRecordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.recordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAudioEditorView({
    _i4.Key? key,
    required String audioFilePath,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.audioEditorView,
        arguments:
            AudioEditorViewArguments(key: key, audioFilePath: audioFilePath),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
