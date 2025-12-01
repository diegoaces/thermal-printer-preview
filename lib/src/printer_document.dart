import 'package:thermal_printer_preview/src/printer_emulator.dart';

class PrinterDocumentBuilder {
  final PrinterEmulator _emulator;

  PrinterDocumentBuilder(this._emulator);

  /// Inicia un nuevo documento limpiando el buffer
  PrinterDocumentBuilder reset() {
    _emulator.clearBuffer();
    return this;
  }

  /// Configura el tamaño de texto para los siguientes fragmentos
  Future<PrinterDocumentBuilder> withTextSize(double size) async {
    await _emulator.setTextSize(size);
    return this;
  }

  /// Configura el tamaño de texto usando valores predefinidos
  Future<PrinterDocumentBuilder> withTextSizeSmall() async {
    await _emulator.setTextSize(PrinterConfig.textSizeSmall);
    return this;
  }

  Future<PrinterDocumentBuilder> withTextSizeNormal() async {
    await _emulator.setTextSize(PrinterConfig.textSizeNormal);
    return this;
  }

  Future<PrinterDocumentBuilder> withTextSizeMedium() async {
    await _emulator.setTextSize(PrinterConfig.textSizeMedium);
    return this;
  }

  Future<PrinterDocumentBuilder> withTextSizeLarge() async {
    await _emulator.setTextSize(PrinterConfig.textSizeLarge);
    return this;
  }

  /// Activa o desactiva el texto en negrita
  Future<PrinterDocumentBuilder> bold([bool enabled = true]) async {
    await _emulator.setTextBold(enabled);
    return this;
  }

  /// Configura la alineación del texto
  Future<PrinterDocumentBuilder> align(int alignment) async {
    await _emulator.setAlignment(alignment);
    return this;
  }

  /// Alinea el texto a la izquierda
  Future<PrinterDocumentBuilder> alignLeft() async {
    await _emulator.setAlignment(PrinterConfig.alignmentLeft);
    return this;
  }

  /// Alinea el texto al centro
  Future<PrinterDocumentBuilder> alignCenter() async {
    await _emulator.setAlignment(PrinterConfig.alignmentCenter);
    return this;
  }

  /// Alinea el texto a la derecha
  Future<PrinterDocumentBuilder> alignRight() async {
    await _emulator.setAlignment(PrinterConfig.alignmentRight);
    return this;
  }

  /// Agrega una línea de texto
  PrinterDocumentBuilder addLine(String text) {
    _emulator.addText('$text\n');
    return this;
  }

  /// Agrega texto sin salto de línea
  PrinterDocumentBuilder addText(String text) {
    _emulator.addText(text);
    return this;
  }

  /// Agrega una línea en blanco
  PrinterDocumentBuilder addBlankLine() {
    _emulator.addText('\n');
    return this;
  }

  /// Agrega múltiples líneas en blanco
  PrinterDocumentBuilder addBlankLines(int count) {
    for (int i = 0; i < count; i++) {
      _emulator.addText('\n');
    }
    return this;
  }

  /// Agrega una línea divisoria
  PrinterDocumentBuilder addDivider([String char = '-', int length = 32]) {
    _emulator.addText('${char * length}\n');
    return this;
  }

  /// Retorna el emulador para operaciones finales
  PrinterEmulator build() {
    return _emulator;
  }
}