import 'package:easy_localization/easy_localization.dart';

class PsinderException implements Exception {
  factory PsinderException.network(Exception exception) =>
      PsinderException('exception.network', underlying: exception);
  factory PsinderException.parse(String field) =>
      PsinderException('exception.parse', suffix: field);
  factory PsinderException.unknown() => PsinderException('exception.unknown');

  final String key;
  final String suffix;
  final Exception underlying;

  PsinderException(this.key, {this.suffix, this.underlying});

  @override
  String toString() {
    if (key == null) {
      return 'Exception';
    } else if (suffix != null) {
      return '${tr(key)} $suffix';
    } else {
      return tr(key);
    }
  }
}
