// /// Generated file. Do not edit.
// ///
// /// Original: lib/app/i18n
// /// To regenerate, run: `dart run slang`
// ///
// /// Locales: 3
// /// Strings: 7 (2 per locale)
// ///
// /// Built on 2024-10-15 at 04:36 UTC
//
// // coverage:ignore-file
// // ignore_for_file: type=lint
//
// import 'package:flutter/widgets.dart';
// import 'package:slang/builder/model/node.dart';
// import 'package:slang_flutter/slang_flutter.dart';
// export 'package:slang_flutter/slang_flutter.dart';
//
// const AppLocale _baseLocale = AppLocale.en;
//
// /// Supported locales, see extension methods below.
// ///
// /// Usage:
// /// - LocaleSettings.setLocale(AppLocale.en) // set locale
// /// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
// /// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
// enum AppLocale with BaseAppLocale<AppLocale, Translations> {
// 	en(languageCode: 'en', build: Translations.build),
// 	es(languageCode: 'es', build: _StringsEs.build),
// 	hi(languageCode: 'hi', build: _StringsHi.build);
//
// 	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element
//
// 	@override final String languageCode;
// 	@override final String? scriptCode;
// 	@override final String? countryCode;
// 	@override final TranslationBuilder<AppLocale, Translations> build;
//
// 	/// Gets current instance managed by [LocaleSettings].
// 	Translations get translations => LocaleSettings.instance.translationMap[this]!;
// }
//
// /// Method A: Simple
// ///
// /// No rebuild after locale change.
// /// Translation happens during initialization of the widget (call of t).
// /// Configurable via 'translate_var'.
// ///
// /// Usage:
// /// String a = t.someKey.anotherKey;
// /// String b = t['someKey.anotherKey']; // Only for edge cases!
// Translations get t => LocaleSettings.instance.currentTranslations;
//
// /// Method B: Advanced
// ///
// /// All widgets using this method will trigger a rebuild when locale changes.
// /// Use this if you have e.g. a settings page where the user can select the locale during runtime.
// ///
// /// Step 1:
// /// wrap your App with
// /// TranslationProvider(
// /// 	child: MyApp()
// /// );
// ///
// /// Step 2:
// /// final t = Translations.of(context); // Get t variable.
// /// String a = t.someKey.anotherKey; // Use t variable.
// /// String b = t['someKey.anotherKey']; // Only for edge cases!
// class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
// 	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);
//
// 	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
// }
//
// /// Method B shorthand via [BuildContext] extension method.
// /// Configurable via 'translate_var'.
// ///
// /// Usage (e.g. in a widget's build method):
// /// context.t.someKey.anotherKey
// extension BuildContextTranslationsExtension on BuildContext {
// 	Translations get t => TranslationProvider.of(this).translations;
// }
//
// /// Manages all translation instances and the current locale
// class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
// 	LocaleSettings._() : super(utils: AppLocaleUtils.instance);
//
// 	static final instance = LocaleSettings._();
//
// 	// static aliases (checkout base methods for documentation)
// 	static AppLocale get currentLocale => instance.currentLocale;
// 	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
// 	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
// 	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
// 	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
// 	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
// 	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
// 	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
// 		language: language,
// 		locale: locale,
// 		cardinalResolver: cardinalResolver,
// 		ordinalResolver: ordinalResolver,
// 	);
// }
//
// /// Provides utility functions without any side effects.
// class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
// 	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);
//
// 	static final instance = AppLocaleUtils._();
//
// 	// static aliases (checkout base methods for documentation)
// 	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
// 	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
// 	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
// 	static List<Locale> get supportedLocales => instance.supportedLocales;
// 	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
// }
//
// // translations
//
// // Path: <root>
// class Translations implements BaseTranslations<AppLocale, Translations> {
// 	/// Returns the current translations of the given [context].
// 	///
// 	/// Usage:
// 	/// final t = Translations.of(context);
// 	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;
//
// 	/// You can call this constructor and build your own translation instance of this locale.
// 	/// Constructing via the enum [AppLocale.build] is preferred.
// 	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
// 		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
// 		  $meta = TranslationMetadata(
// 		    locale: AppLocale.en,
// 		    overrides: overrides ?? {},
// 		    cardinalResolver: cardinalResolver,
// 		    ordinalResolver: ordinalResolver,
// 		  ) {
// 		$meta.setFlatMapFunction(_flatMapFunction);
// 	}
//
// 	/// Metadata for the translations of <en>.
// 	@override final TranslationMetadata<AppLocale, Translations> $meta;
//
// 	/// Access flat map
// 	dynamic operator[](String key) => $meta.getTranslation(key);
//
// 	late final Translations _root = this; // ignore: unused_field
//
// 	// Translations
// 	String get montra => 'Montra';
// }
//
// // Path: <root>
// class _StringsEs implements Translations {
// 	/// You can call this constructor and build your own translation instance of this locale.
// 	/// Constructing via the enum [AppLocale.build] is preferred.
// 	_StringsEs.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
// 		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
// 		  $meta = TranslationMetadata(
// 		    locale: AppLocale.es,
// 		    overrides: overrides ?? {},
// 		    cardinalResolver: cardinalResolver,
// 		    ordinalResolver: ordinalResolver,
// 		  ) {
// 		$meta.setFlatMapFunction(_flatMapFunction);
// 	}
//
// 	/// Metadata for the translations of <es>.
// 	@override final TranslationMetadata<AppLocale, Translations> $meta;
//
// 	/// Access flat map
// 	@override dynamic operator[](String key) => $meta.getTranslation(key);
//
// 	@override late final _StringsEs _root = this; // ignore: unused_field
//
// 	// Translations
// 	@override String get hello => 'Hola';
// 	@override String get how_are_you => 'Cómo estás ?';
// 	@override String get localization => 'Localización';
// 	@override String get choose_language => 'elegir idioma';
// 	@override String get default_language => 'idioma predeterminado';
// }
//
// // Path: <root>
// class _StringsHi implements Translations {
// 	/// You can call this constructor and build your own translation instance of this locale.
// 	/// Constructing via the enum [AppLocale.build] is preferred.
// 	_StringsHi.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
// 		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
// 		  $meta = TranslationMetadata(
// 		    locale: AppLocale.hi,
// 		    overrides: overrides ?? {},
// 		    cardinalResolver: cardinalResolver,
// 		    ordinalResolver: ordinalResolver,
// 		  ) {
// 		$meta.setFlatMapFunction(_flatMapFunction);
// 	}
//
// 	/// Metadata for the translations of <hi>.
// 	@override final TranslationMetadata<AppLocale, Translations> $meta;
//
// 	/// Access flat map
// 	@override dynamic operator[](String key) => $meta.getTranslation(key);
//
// 	@override late final _StringsHi _root = this; // ignore: unused_field
//
// 	// Translations
// 	@override String get montra => 'मोंट्रा';
// }
//
// /// Flat map(s) containing all translations.
// /// Only for edge cases! For simple maps, use the map function of this library.
//
// extension on Translations {
// 	dynamic _flatMapFunction(String path) {
// 		switch (path) {
// 			case 'montra': return 'Montra';
// 			default: return null;
// 		}
// 	}
// }
//
// extension on _StringsEs {
// 	dynamic _flatMapFunction(String path) {
// 		switch (path) {
// 			case 'hello': return 'Hola';
// 			case 'how_are_you': return 'Cómo estás ?';
// 			case 'localization': return 'Localización';
// 			case 'choose_language': return 'elegir idioma';
// 			case 'default_language': return 'idioma predeterminado';
// 			default: return null;
// 		}
// 	}
// }
//
// extension on _StringsHi {
// 	dynamic _flatMapFunction(String path) {
// 		switch (path) {
// 			case 'montra': return 'मोंट्रा';
// 			default: return null;
// 		}
// 	}
// }
