import 'package:senraise_printer/senraise_printer.dart';

/// Constantes para configuración de impresora térmica
class PrinterConfig {
  // Tamaños de texto predefinidos
  static const double textSizeSmall = 16.0;
  static const double textSizeNormal = 24.0;
  static const double textSizeMedium = 32.0;
  static const double textSizeLarge = 48.0;

  // Alineación
  static const int alignmentLeft = 0;
  static const int alignmentCenter = 1;
  static const int alignmentRight = 2;

  // Valores por defecto
  static const double defaultTextSize = textSizeNormal;
  static const bool defaultBold = false;
  static const int defaultAlignment = alignmentLeft;
}

/// **Command Pattern Implementation**
///
/// `TextFragment` representa un comando de impresión encapsulado.
/// Almacena toda la información necesaria para ejecutar una operación
/// de impresión de texto con formato específico.
///
/// Estructura del Command:
/// - **Command**: `TextFragment` - Encapsula la operación y sus parámetros
/// - **Receiver**: `SenraisePrinter` - Ejecuta la operación real
/// - **Invoker**: `PrinterEmulator.printToDevice()` - Invoca los comandos
///

class TextFragment {
  /// Contenido de texto a imprimir
  final String text;

  /// Tamaño de fuente para este fragmento
  final double textSize;

  /// Si el texto debe imprimirse en negrita
  final bool isBold;

  /// Alineación del texto (0=izq, 1=centro, 2=der)
  final int alignment;

  /// Crea un comando de impresión con todos sus parámetros
  TextFragment({
    required this.text,
    required this.textSize,
    required this.isBold,
    required this.alignment,
  });

  @override
  String toString() {
    return 'TextFragment(text: "$text", size: $textSize, bold: $isBold, align: $alignment)';
  }
}

/// **Proxy Pattern Implementation**
///
/// `PrinterEmulator` actúa como un Proxy para `SenraisePrinter`,
/// proporcionando funcionalidad adicional sin modificar la clase original:
///
/// - **Control de acceso**: Intercepta las operaciones antes de llegar a la impresora real
/// - **Lazy execution**: Acumula comandos (Command Pattern) antes de ejecutarlos
/// - **Preview**: Permite visualizar sin imprimir (funcionalidad extra)
/// - **Buffering**: Almacena fragmentos de texto para procesamiento posterior
///
/// Estructura del Proxy:
/// - Subject (Interface implícita): Operaciones de impresión
/// - RealSubject: `SenraisePrinter` - La impresora física
/// - Proxy: `PrinterEmulator` - Intermediario con funcionalidad adicional
class PrinterEmulator {
  // RealSubject - La impresora física real
  final SenraisePrinter _realPrinter = SenraisePrinter();

  // Estado actual del proxy (configuración de formato)
  double textSize = PrinterConfig.defaultTextSize;
  bool isBold = PrinterConfig.defaultBold;
  int alignment = PrinterConfig.defaultAlignment;

  // Buffer de comandos (Command Pattern integrado)
  final List<TextFragment> _commandBuffer = [];

  // === Métodos del Proxy (interceptan y almacenan estado) ===

  /// Configura el tamaño de texto sin enviar a la impresora real
  Future<void> setTextSize(double size) async {
    textSize = size;
  }

  /// Configura negrita sin enviar a la impresora real
  Future<void> setTextBold(bool bold) async {
    isBold = bold;
  }

  /// Configura alineación sin enviar a la impresora real
  Future<void> setAlignment(int align) async {
    alignment = align;
  }

  /// Agrega texto al buffer de comandos (Command Pattern)
  /// No imprime inmediatamente - permite preview
  void addText(String text) {
    _commandBuffer.add(TextFragment(
      text: text,
      textSize: textSize,
      isBold: isBold,
      alignment: alignment,
    ));
  }

  // === Delegación al RealSubject ===

  /// Ejecuta todos los comandos almacenados en la impresora real
  /// Este es el único punto donde el Proxy delega al RealSubject
  Future<void> printToDevice() async {
    for (var fragment in _commandBuffer) {
      // Configurar el RealSubject con los parámetros del comando
      await _realPrinter.setTextSize(fragment.textSize);
      await _realPrinter.setTextBold(fragment.isBold);
      await _realPrinter.setAlignment(fragment.alignment);

      // Ejecutar el comando en el RealSubject
      await _realPrinter.printText(fragment.text);
    }
  }

  // === Funcionalidad adicional del Proxy ===

  /// Obtiene los comandos almacenados para preview (funcionalidad extra del Proxy)
  List<TextFragment> getFragments() {
    return List.unmodifiable(_commandBuffer);
  }

  /// Limpia el buffer de comandos
  void clearBuffer() {
    _commandBuffer.clear();
  }

  /// Acceso directo al RealSubject (para operaciones avanzadas)
  SenraisePrinter get realPrinter => _realPrinter;
}