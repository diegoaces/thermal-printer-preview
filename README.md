<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# thermal_printer_preview
A Flutter package that provides a widget to preview thermal printer output for
Senraise Thermal Printers.

[![pub package](https://img.shields.io/pub/v/thermal_printer_preview.svg)](https://pub.dev/packages/thermal_printer_preview)
## Overview
The `thermal_printer_preview` package allows developers to easily preview the
output of thermal printers within their Flutter applications. It supports various
text alignments and formatting options, making it a versatile tool for
developers working with thermal printers.

Print to device is support for Senraise Thermal Printers using the
[senraise_thermal_printer](https://pub.dev/packages/senraise_thermal_printer)
package included in the `thermal_printer_preview` package.

## Features

- Preview thermal printer output in a Flutter application.
- Support for text alignment and formatting.
- Easy integration with existing Flutter projects.
- Customizable printer settings.
- Lightweight and efficient implementation.
  
## Getting started

To use this package, add `thermal_printer_preview` as a dependency in your
`pubspec.yaml` file: 

```yaml
dependencies:
  thermal_printer_preview: ^0.0.1
``` 
or run the following command in your terminal:

```bash
flutter pub add thermal_printer_preview
```

## Usage

Import the package in your Dart code:

```dart
import 'package:thermal_printer_preview/thermal_printer_preview.dart';
```
Then, you can use the `ThermalPrinterPreviewWidget` widget to display a preview of
the thermal printer output:

```dart
... 
final _printerEmulator = PrinterEmulator();
late final PrinterDocumentBuilder _builder;

@override
void initState() {
    super.initState();
    _builder = PrinterDocumentBuilder(_printerEmulator);
    _generatePreview();
}

Future<void> _generatePreview() async {
    _builder.reset();

    await _builder.withTextSizeNormal();
    await _builder.alignLeft();
    _builder
        .addLine('Welcome to our store!')
        .addLine('Thank you for your purchase')
        .addBlankLine()
        .addLine('Total: \$150.00')
        .addBlankLine();

    await _builder.bold();
    _builder.addLine('This should be bold');
    await _builder.bold(false);
    _builder.addBlankLine();

    // Center alignment
    await _builder.alignCenter();
    _builder.addLine('Centrado');

    // Alineación a la derecha
    await _builder.alignRight();
    _builder.addLine('A la derecha');

    // Volver a alineación izquierda
    await _builder.alignLeft();
    _builder.addBlankLines(3);

    // Tamaño grande
    await _builder.withTextSizeLarge();
    _builder.addLine('Large size');

    // Tamaño pequeño
    await _builder.withTextSizeSmall();
    _builder
        .addLine('Small size')
        .addBlankLines(3);

    setState(() {});
}

// In your widget tree 
ThermalPrinterPreviewWidget(
    fragments: _printerEmulator.getFragments()
);

// To print to device
ElevatedButton(
    onPressed: () async {
        await _printerEmulator.printToDevice();
    },
    child: Text('Print to Device'),
),

```


## Additional information

For more details, examples, and documentation, visit the [GitHub repository](https://github.com/diegoaces/thermal-printer-preview).

## Contributing
Contributions are welcome! Please open an issue or submit a pull request on the
[GitHub repository](https://github.com/diegoaces/thermal-printer-preview).