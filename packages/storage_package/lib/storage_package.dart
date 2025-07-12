import 'package:injectable/injectable.dart';
export 'src/secure_storage.dart';
export 'src/persistent_storage.dart';

@InjectableInit.microPackage()
void storageInit() {}
