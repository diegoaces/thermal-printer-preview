import 'package:flutter/material.dart';
import 'package:thermal_printer_preview/src/printer_emulator.dart';
import 'package:thermal_printer_preview/src/text_alignment.dart';

/// Constantes para el widget de preview de impresora térmica
class PrinterPreviewConstants {
  // Dimensiones del papel
  static const double paperWidthPixels = 580.0;
  static const double paperBorderWidth = 2.0;

  // Padding
  static const double paperPaddingHorizontal = 8.0;
  static const double paperPaddingVertical = 8.0;

  // Sombra
  static const double shadowBlurRadius = 8.0;
  static const double shadowOpacity = 0.1;
  static const Offset shadowOffset = Offset(0, 2);

  // Texto
  static const String textFontFamily = 'Courier';
  static const double textLineHeight = 0.7;
  static const double fontSizeScale = 0.7;

  // Alineación (valores de impresora térmica)
  static const int alignmentLeft = 0;
  static const int alignmentCenter = 1;
  static const int alignmentRight = 2;
}

class ThermalPrinterPreviewWidget extends StatelessWidget {
  final List<TextFragment> fragments;

  const ThermalPrinterPreviewWidget({super.key, required this.fragments});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: PrinterPreviewConstants.paperWidthPixels,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
            width: PrinterPreviewConstants.paperBorderWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: PrinterPreviewConstants.shadowOpacity,
              ),
              blurRadius: PrinterPreviewConstants.shadowBlurRadius,
              offset: PrinterPreviewConstants.shadowOffset,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PrinterPreviewConstants.paperPaddingHorizontal,
              vertical: PrinterPreviewConstants.paperPaddingVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: fragments.map((fragment) {
                return _buildTextFragment(fragment);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFragment(TextFragment fragment) {
    // Usar Strategy Pattern para obtener la alineación
    final TextAlignmentInterface alignmentStrategy =
        TextAlignmentStrategyFactory.fromCode(fragment.alignment);

    final double previewFontSize = _mapPrinterSizeToPreviewSize(
      fragment.textSize,
    );

    return Text(
      fragment.text,
      textAlign: alignmentStrategy.flutterTextAlign,
      style: TextStyle(
        fontFamily: PrinterPreviewConstants.textFontFamily,
        fontSize: previewFontSize,
        color: Colors.black,
        height: PrinterPreviewConstants.textLineHeight,
        fontWeight: fragment.isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  /// Mapea el tamaño de fuente de la impresora al tamaño de preview
  double _mapPrinterSizeToPreviewSize(double printerSize) {
    return printerSize * PrinterPreviewConstants.fontSizeScale;
  }
}
