import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

class TFirebaseStorageService extends GetxController {
  static TFirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw 'Error al cargar la imagen: $e';
    }
  }

  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      print('Iniciando el proceso de subida de la imagen.');

      // Obtener el directorio temporal
      final tempDir = await getTemporaryDirectory();
      print('Directorio temporal obtenido: ${tempDir.path}');

      // Crear la ruta completa para el archivo temporal
      final tempFilePath = p.join(tempDir.path, name);
      print('Ruta del archivo temporal: $tempFilePath');

      // Crear un archivo temporal
      final tempFile = File(tempFilePath);
      print('Archivo temporal creado en la ruta: ${tempFile.path}');

      // Escribir los datos de la imagen en el archivo temporal
      await tempFile.writeAsBytes(image);
      print('Datos de la imagen escritos en el archivo temporal.');

      // Crear una referencia en Firebase Storage
      final ref = FirebaseStorage.instance.ref(path).child(name);
      print('Referencia de Firebase Storage creada: $path/$name');

      // Subir el archivo a Firebase Storage
      await ref.putFile(tempFile, SettableMetadata(contentType: 'image/png'));
      print('Archivo subido a Firebase Storage.');

      // Obtener la URL de descarga del archivo subido
      final url = await ref.getDownloadURL();
      print('URL de descarga obtenida: $url');

      return url;
    } catch (e) {
      print('Ocurrió un error: $e');

      if (e is FirebaseException) {
        throw 'Firebase Exception: $e';
      } else if (e is SocketException) {
        throw 'Network Exception: $e';
      } else if (e is PlatformException) {
        throw 'Platform Exception: $e';
      } else {
        throw 'Exception: $e';
      }
    }
  }

  Future<String> uploadImageData2(
      String path, Uint8List image, String name) async {
    try {
      // Obtener el directorio temporal
      final tempDir = await getTemporaryDirectory();
      final tempFilePath = p.join(tempDir.path, name);

      // Crear un archivo temporal
      final tempFile = File(tempFilePath);
      await tempFile.writeAsBytes(image);

      final ref = _firebaseStorage.ref(path).child(name);
      //await ref.putData(image, SettableMetadata(contentType: 'image/png'));
      await ref.putFile(tempFile, SettableMetadata(contentType: 'image/png'));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Exception: $e';
      } else if (e is SocketException) {
        throw 'Network Exception: $e';
      } else if (e is PlatformException) {
        throw 'Platform Exception: $e';
      } else {
        throw 'Exception: $e';
      }
    }
  }

  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Exception: $e';
      } else if (e is SocketException) {
        throw 'Network Exception: $e';
      } else if (e is PlatformException) {
        throw 'Platform Exception: $e';
      } else {
        throw 'Exception: $e';
      }
    }
  }

  /*Future<String> uploadImageFileAsPng(String path, XFile image) async {
    try {
      // Load the image file into a Uint8List
      final Uint8List imageBytes = await image.readAsBytes();

      // Decode the image to manipulate it
      img.Image? originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) {
        throw 'Error decoding image.';
      }

      // Encode the image to PNG format
      final Uint8List pngData =
          Uint8List.fromList(img.encodePng(originalImage));

      // Use the original filename but ensure it ends with .png
      final fileName = p.basenameWithoutExtension(image.name) + '.png';

      // Convert the Uint8List to XFile
      final xFile = await uint8ListToXFile(pngData,
          p.basename(image.name).replaceAll(p.extension(image.name), '.png'));

      // Upload the PNG data

      final ref = _firebaseStorage.ref(path).child(fileName);
      await ref.putData(pngData, SettableMetadata(contentType: 'image/png'));
      //await ref.putFile(File(xFile));
      // Get the download URL
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Exception: $e';
      } else if (e is SocketException) {
        throw 'Network Exception: $e';
      } else if (e is PlatformException) {
        throw 'Platform Exception: $e';
      } else {
        throw 'Exception: $e';
      }
    }
  } */

  Future<String> uploadPngImageData(
      String path, Uint8List image, String name) async {
    try {
      // Convertir los datos binarios a formato PNG
      final pngImageData = convertToPng(image);

      // Subir los datos PNG a Firebase Storage
      final ref = _firebaseStorage.ref(path).child('$name.png');
      await ref.putData(pngImageData);

      // Obtener la URL de descarga de la imagen cargada
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'Firebase Exception: $e';
      } else if (e is SocketException) {
        throw 'Network Exception: $e';
      } else if (e is PlatformException) {
        throw 'Platform Exception: $e';
      } else {
        throw 'Exception: $e';
      }
    }
  }

  // Función para convertir los datos binarios de imagen a PNG
  Uint8List convertToPng(Uint8List imageData) {
    // Decodificar los datos binarios en una imagen
    img.Image image = img.decodeImage(imageData)!;

    // Codificar la imagen en formato PNG
    Uint8List pngBytes = Uint8List.fromList(img.encodePng(image));

    return pngBytes;
  }

  Future<XFile> uint8ListToXFile(Uint8List uint8List, String fileName) async {
    // Obtén el directorio temporal del sistema
    final tempDir = await getTemporaryDirectory();

    // Crea una ruta para el archivo temporal
    final tempFilePath = p.join(tempDir.path, fileName);

    // Escribe el Uint8List en el archivo temporal
    final tempFile = File(tempFilePath);
    await tempFile.writeAsBytes(uint8List);

    // Crea un XFile a partir del archivo temporal
    return XFile(tempFilePath);
  }
}
