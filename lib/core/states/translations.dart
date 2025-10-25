import 'package:apparence_kit/i18n/translations.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final translationsProvider = Provider<Translations>((ref) {
  final current = LocaleSettings.currentLocale.translations;
  return current;
});

final localeProvider = Provider<AppLocale>(
  (ref) => LocaleSettings.currentLocale,
);
