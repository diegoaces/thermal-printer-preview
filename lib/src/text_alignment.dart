import 'package:flutter/material.dart';

/// **Strategy Pattern Implementation**
///
/// Define diferentes estrategias de alineación de texto para la impresora térmica.
///
/// Estructura del Strategy:
/// - **Strategy**: `TextAlignmentStrategy` - Interface (clase abstracta)
/// - **ConcreteStrategy**: `LeftAlignmentStrategy`, `CenterAlignmentStrategy`, etc.
/// - **Context**: `PrinterPreviewWidget` - Usa la estrategia
///
/// Interface del patrón Strategy para alineación de texto
abstract class TextAlignmentInterface {
  /// Código de alineación usado por la impresora térmica
  int get alignmentCode;

  /// Obtiene el TextAlign de Flutter correspondiente a esta estrategia
  TextAlign get flutterTextAlign;

  /// Nombre descriptivo de la estrategia
  String get name;
}

/// Estrategia de alineación a la izquierda
class LeftAlignmentImplement implements TextAlignmentInterface {
  const LeftAlignmentImplement();

  @override
  int get alignmentCode => 0;

  @override
  TextAlign get flutterTextAlign => TextAlign.left;

  @override
  String get name => 'Left';
}

/// Estrategia de alineación al centro
class CenterAlignmentImplement implements TextAlignmentInterface {
  const CenterAlignmentImplement();

  @override
  int get alignmentCode => 1;

  @override
  TextAlign get flutterTextAlign => TextAlign.center;

  @override
  String get name => 'Center';
}

/// Estrategia de alineación a la derecha
class RightAlignmentImplement implements TextAlignmentInterface {
  const RightAlignmentImplement();

  @override
  int get alignmentCode => 2;

  @override
  TextAlign get flutterTextAlign => TextAlign.right;

  @override
  String get name => 'Right';
}

/// Estrategia de alineación justificada (para futuras extensiones)
class JustifyAlignmentImplement implements TextAlignmentInterface {
  const JustifyAlignmentImplement();

  @override
  int get alignmentCode => 3;

  @override
  TextAlign get flutterTextAlign => TextAlign.justify;

  @override
  String get name => 'Justify';
}

/// Factory para obtener la estrategia correcta según el código de alineación
class TextAlignmentStrategyFactory {
  static const _leftStrategy = LeftAlignmentImplement();
  static const _centerStrategy = CenterAlignmentImplement();
  static const _rightStrategy = RightAlignmentImplement();
  static const _justifyStrategy = JustifyAlignmentImplement();

  /// Obtiene la estrategia correspondiente al código de alineación
  static TextAlignmentInterface fromCode(int alignmentCode) {
    switch (alignmentCode) {
      case 0:
        return _leftStrategy;
      case 1:
        return _centerStrategy;
      case 2:
        return _rightStrategy;
      case 3:
        return _justifyStrategy;
      default:
        return _leftStrategy; // Default a izquierda
    }
  }

  /// Obtiene todas las estrategias disponibles
  static List<TextAlignmentInterface> getAllStrategies() {
    return [_leftStrategy, _centerStrategy, _rightStrategy, _justifyStrategy];
  }
}
