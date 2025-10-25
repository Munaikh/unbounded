///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsHomeEn home = TranslationsHomeEn.internal(_root);
	late final TranslationsRatePopupEn rate_popup = TranslationsRatePopupEn.internal(_root);
	late final TranslationsPremiumEn premium = TranslationsPremiumEn.internal(_root);
	late final TranslationsPaywallWithSwitchEn paywallWithSwitch = TranslationsPaywallWithSwitchEn.internal(_root);
	late final TranslationsRequestNotificationPermissionEn request_notification_permission = TranslationsRequestNotificationPermissionEn.internal(_root);
	late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn.internal(_root);
	late final TranslationsFeatureRequestsEn feature_requests = TranslationsFeatureRequestsEn.internal(_root);
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'ApparenceKit example'
	String get title => 'ApparenceKit example';
}

// Path: rate_popup
class TranslationsRatePopupEn {
	TranslationsRatePopupEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Would you have 15s to rate us?'
	String get title => 'Would you have 15s to rate us?';

	/// en: 'It's fast and very helpful! Thanks a lot!'
	String get description => 'It\'s fast and very helpful! Thanks a lot!';

	/// en: 'Maybe later'
	String get cancel_button => 'Maybe later';

	/// en: 'Yes, with pleasure!'
	String get rate_button => 'Yes, with pleasure!';
}

// Path: premium
class TranslationsPremiumEn {
	TranslationsPremiumEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unlock full access'
	String get title_1 => 'Unlock full access';

	/// en: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
	String get description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

	/// en: 'Lorem ipsum dolor sit ame lorem'
	String get feature_1 => 'Lorem ipsum dolor sit ame lorem';

	/// en: 'Lorem ipsum dolor sit ame lorem'
	String get feature_2 => 'Lorem ipsum dolor sit ame lorem';

	/// en: 'Lorem ipsum dolor sit ame lorem'
	String get feature_3 => 'Lorem ipsum dolor sit ame lorem';

	/// en: 'Weak'
	String get duration_weekly => 'Weak';

	/// en: 'Year'
	String get duration_annual => 'Year';

	/// en: 'Save 50%'
	String get duration_annual_description => 'Save 50%';

	/// en: 'Month'
	String get duration_monthly => 'Month';

	/// en: 'Cancel anytime'
	String get duration_monthly_description => 'Cancel anytime';

	/// en: 'Lifetime'
	String get duration_lifetime => 'Lifetime';

	/// en: 'One time payment'
	String get duration_lifetime_description => 'One time payment';

	/// en: 'Restore my subscription'
	String get restore_action => 'Restore my subscription';

	/// en: 'Easy 1-click cancel, always'
	String get payment_cancel_reassurance => 'Easy 1-click cancel, always';

	/// en: 'Start free trial'
	String get payment_action => 'Start free trial';

	/// en: '7-day free trial, then $money'
	String payment_action_trial({required Object money}) => '7-day free trial, then ${money}';
}

// Path: paywallWithSwitch
class TranslationsPaywallWithSwitchEn {
	TranslationsPaywallWithSwitchEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPaywallWithSwitchWithTrialEn withTrial = TranslationsPaywallWithSwitchWithTrialEn.internal(_root);
	late final TranslationsPaywallWithSwitchNoTrialEn noTrial = TranslationsPaywallWithSwitchNoTrialEn.internal(_root);
	List<String> get features => [
		'Lorem feature 1',
		'Lorem feature 2',
		'Lorem feature 3',
		'Cancel anytime',
	];
}

// Path: request_notification_permission
class TranslationsRequestNotificationPermissionEn {
	TranslationsRequestNotificationPermissionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Don't miss anything'
	String get title => 'Don\'t miss anything';

	/// en: 'Allow us to send you notifications to stay up to date with the latest news...'
	String get description => 'Allow us to send you notifications to stay up to date with the latest news...';

	/// en: 'Allow notifications'
	String get continue_button => 'Allow notifications';

	/// en: 'Maybe later'
	String get skip_button => 'Maybe later';
}

// Path: onboarding
class TranslationsOnboardingEn {
	TranslationsOnboardingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsOnboardingFeature1En feature_1 = TranslationsOnboardingFeature1En.internal(_root);
	late final TranslationsOnboardingFeature2En feature_2 = TranslationsOnboardingFeature2En.internal(_root);
	late final TranslationsOnboardingFeature3En feature_3 = TranslationsOnboardingFeature3En.internal(_root);
	late final TranslationsOnboardingAgeQuestionEn ageQuestion = TranslationsOnboardingAgeQuestionEn.internal(_root);
	late final TranslationsOnboardingGenderQuestionEn genderQuestion = TranslationsOnboardingGenderQuestionEn.internal(_root);
	late final TranslationsOnboardingNotificationsEn notifications = TranslationsOnboardingNotificationsEn.internal(_root);
	late final TranslationsOnboardingLoadingEn loading = TranslationsOnboardingLoadingEn.internal(_root);
}

// Path: feature_requests
class TranslationsFeatureRequestsEn {
	TranslationsFeatureRequestsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your opinion matters!'
	String get title => 'Your opinion matters!';

	/// en: 'Vote or suggest new features. We listen everyone of you to create the best possible app.'
	String get description => 'Vote or suggest new features.\nWe listen everyone of you to create the best possible app.';

	late final TranslationsFeatureRequestsVoteSuccessEn vote_success = TranslationsFeatureRequestsVoteSuccessEn.internal(_root);
	late final TranslationsFeatureRequestsVoteErrorEn vote_error = TranslationsFeatureRequestsVoteErrorEn.internal(_root);
	late final TranslationsFeatureRequestsAddFeatureEn add_feature = TranslationsFeatureRequestsAddFeatureEn.internal(_root);
}

// Path: paywallWithSwitch.withTrial
class TranslationsPaywallWithSwitchWithTrialEn {
	TranslationsPaywallWithSwitchWithTrialEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Try Free for $days days'
	String title({required Object days}) => 'Try Free for ${days} days';

	/// en: 'Try for free'
	String get btnAction => 'Try for free';

	/// en: '$days days free, then $price'
	String details({required Object days, required Object price}) => '${days} days free, then ${price}';

	/// en: '$days-day free trial'
	String trial_switch_title({required Object days}) => '${days}-day free trial';
}

// Path: paywallWithSwitch.noTrial
class TranslationsPaywallWithSwitchNoTrialEn {
	TranslationsPaywallWithSwitchNoTrialEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enjoy Your Premium Experience'
	String get title => 'Enjoy Your Premium Experience';

	/// en: 'Continue'
	String get btnAction => 'Continue';

	/// en: 'Not sure yet?'
	String get trial_switch_title => 'Not sure yet?';

	/// en: 'Enable free trial'
	String get trial_switch_subtitle => 'Enable free trial';
}

// Path: onboarding.feature_1
class TranslationsOnboardingFeature1En {
	TranslationsOnboardingFeature1En.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Subscriptions module'
	String get title => 'Subscriptions module';

	/// en: 'Manage subscriptions with premade paywalls'
	String get description => 'Manage subscriptions with premade paywalls';

	/// en: 'Continue'
	String get action => 'Continue';
}

// Path: onboarding.feature_2
class TranslationsOnboardingFeature2En {
	TranslationsOnboardingFeature2En.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Authentication module'
	String get title => 'Authentication module';

	/// en: 'Manage authentication with premade screens for (login, register, forgot password, etc.)'
	String get description => 'Manage authentication with premade screens for (login, register, forgot password, etc.)';

	/// en: 'Continue'
	String get action => 'Continue';
}

// Path: onboarding.feature_3
class TranslationsOnboardingFeature3En {
	TranslationsOnboardingFeature3En.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications module'
	String get title => 'Notifications module';

	/// en: 'Receive push notifications, show in-app notifications, manage permissions, notifications list with status...'
	String get description => 'Receive push notifications, show in-app notifications, manage permissions, notifications list with status...';

	/// en: 'Continue'
	String get action => 'Continue';
}

// Path: onboarding.ageQuestion
class TranslationsOnboardingAgeQuestionEn {
	TranslationsOnboardingAgeQuestionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What is your age?'
	String get title => 'What is your age?';

	/// en: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
	String get description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

	Map<String, String> get options => {
		'age18_30': '[18 - 30] years old',
		'age31_40': '[31 - 40] years old',
		'age41_50': '[41 - 50] years old',
		'age51_60': '50 years and above',
		'none': 'I prefer not to answer',
	};

	/// en: 'Continue'
	String get action => 'Continue';
}

// Path: onboarding.genderQuestion
class TranslationsOnboardingGenderQuestionEn {
	TranslationsOnboardingGenderQuestionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What is your gender?'
	String get title => 'What is your gender?';

	/// en: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
	String get description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

	Map<String, String> get options => {
		'male': 'Male',
		'female': 'Female',
		'none': 'I prefer not to answer',
	};

	/// en: 'Continue'
	String get action => 'Continue';
}

// Path: onboarding.notifications
class TranslationsOnboardingNotificationsEn {
	TranslationsOnboardingNotificationsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Allow notifications'
	String get title => 'Allow notifications';

	/// en: 'We will only send you important notifications'
	String get description => 'We will only send you important notifications';

	/// en: 'Allow notifications'
	String get continue_button => 'Allow notifications';

	/// en: 'Maybe later'
	String get skip_button => 'Maybe later';
}

// Path: onboarding.loading
class TranslationsOnboardingLoadingEn {
	TranslationsOnboardingLoadingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Creating your profile'
	String get title => 'Creating your profile';

	/// en: 'Wait a few seconds'
	String get subtitle => 'Wait a few seconds';
}

// Path: feature_requests.vote_success
class TranslationsFeatureRequestsVoteSuccessEn {
	TranslationsFeatureRequestsVoteSuccessEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Thank you!'
	String get title => 'Thank you!';

	/// en: 'Your vote has been taken into account'
	String get description => 'Your vote has been taken into account';
}

// Path: feature_requests.vote_error
class TranslationsFeatureRequestsVoteErrorEn {
	TranslationsFeatureRequestsVoteErrorEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error'
	String get title => 'Error';

	/// en: 'You already voted for a feature'
	String get description => 'You already voted for a feature';
}

// Path: feature_requests.add_feature
class TranslationsFeatureRequestsAddFeatureEn {
	TranslationsFeatureRequestsAddFeatureEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Suggest a feature'
	String get title => 'Suggest a feature';

	/// en: 'What feature would you like to see in the app?'
	String get description => 'What feature would you like to see in the app?';

	/// en: 'Send'
	String get save_button => 'Send';

	/// en: 'Feature title'
	String get title_label => 'Feature title';

	/// en: 'Enter a short descriptive title'
	String get title_hint => 'Enter a short descriptive title';

	/// en: 'Description'
	String get description_label => 'Description';

	/// en: 'Describe the feature or the improvement you would like to see in the app'
	String get description_hint => 'Describe the feature or the improvement you would like to see in the app';

	late final TranslationsFeatureRequestsAddFeatureToastSuccessEn toast_success = TranslationsFeatureRequestsAddFeatureToastSuccessEn.internal(_root);
}

// Path: feature_requests.add_feature.toast_success
class TranslationsFeatureRequestsAddFeatureToastSuccessEn {
	TranslationsFeatureRequestsAddFeatureToastSuccessEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Thank you!'
	String get title => 'Thank you!';

	/// en: 'We will review your suggestion'
	String get description => 'We will review your suggestion';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return _flatMapFunction$0(path);
	}

	dynamic _flatMapFunction$0(String path) {
		switch (path) {
			case 'home.title': return 'ApparenceKit example';
			case 'rate_popup.title': return 'Would you have 15s to rate us?';
			case 'rate_popup.description': return 'It\'s fast and very helpful! Thanks a lot!';
			case 'rate_popup.cancel_button': return 'Maybe later';
			case 'rate_popup.rate_button': return 'Yes, with pleasure!';
			case 'premium.title_1': return 'Unlock full access';
			case 'premium.description': return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
			case 'premium.feature_1': return 'Lorem ipsum dolor sit ame lorem';
			case 'premium.feature_2': return 'Lorem ipsum dolor sit ame lorem';
			case 'premium.feature_3': return 'Lorem ipsum dolor sit ame lorem';
			case 'premium.duration_weekly': return 'Weak';
			case 'premium.duration_annual': return 'Year';
			case 'premium.duration_annual_description': return 'Save 50%';
			case 'premium.duration_monthly': return 'Month';
			case 'premium.duration_monthly_description': return 'Cancel anytime';
			case 'premium.duration_lifetime': return 'Lifetime';
			case 'premium.duration_lifetime_description': return 'One time payment';
			case 'premium.restore_action': return 'Restore my subscription';
			case 'premium.payment_cancel_reassurance': return 'Easy 1-click cancel, always';
			case 'premium.payment_action': return 'Start free trial';
			case 'premium.payment_action_trial': return ({required Object money}) => '7-day free trial, then ${money}';
			case 'paywallWithSwitch.withTrial.title': return ({required Object days}) => 'Try Free for ${days} days';
			case 'paywallWithSwitch.withTrial.btnAction': return 'Try for free';
			case 'paywallWithSwitch.withTrial.details': return ({required Object days, required Object price}) => '${days} days free, then ${price}';
			case 'paywallWithSwitch.withTrial.trial_switch_title': return ({required Object days}) => '${days}-day free trial';
			case 'paywallWithSwitch.noTrial.title': return 'Enjoy Your Premium Experience';
			case 'paywallWithSwitch.noTrial.btnAction': return 'Continue';
			case 'paywallWithSwitch.noTrial.trial_switch_title': return 'Not sure yet?';
			case 'paywallWithSwitch.noTrial.trial_switch_subtitle': return 'Enable free trial';
			case 'paywallWithSwitch.features.0': return 'Lorem feature 1';
			case 'paywallWithSwitch.features.1': return 'Lorem feature 2';
			case 'paywallWithSwitch.features.2': return 'Lorem feature 3';
			case 'paywallWithSwitch.features.3': return 'Cancel anytime';
			case 'request_notification_permission.title': return 'Don\'t miss anything';
			case 'request_notification_permission.description': return 'Allow us to send you notifications to stay up to date with the latest news...';
			case 'request_notification_permission.continue_button': return 'Allow notifications';
			case 'request_notification_permission.skip_button': return 'Maybe later';
			case 'onboarding.feature_1.title': return 'Subscriptions module';
			case 'onboarding.feature_1.description': return 'Manage subscriptions with premade paywalls';
			case 'onboarding.feature_1.action': return 'Continue';
			case 'onboarding.feature_2.title': return 'Authentication module';
			case 'onboarding.feature_2.description': return 'Manage authentication with premade screens for (login, register, forgot password, etc.)';
			case 'onboarding.feature_2.action': return 'Continue';
			case 'onboarding.feature_3.title': return 'Notifications module';
			case 'onboarding.feature_3.description': return 'Receive push notifications, show in-app notifications, manage permissions, notifications list with status...';
			case 'onboarding.feature_3.action': return 'Continue';
			case 'onboarding.ageQuestion.title': return 'What is your age?';
			case 'onboarding.ageQuestion.description': return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
			case 'onboarding.ageQuestion.options.age18_30': return '[18 - 30] years old';
			case 'onboarding.ageQuestion.options.age31_40': return '[31 - 40] years old';
			case 'onboarding.ageQuestion.options.age41_50': return '[41 - 50] years old';
			case 'onboarding.ageQuestion.options.age51_60': return '50 years and above';
			case 'onboarding.ageQuestion.options.none': return 'I prefer not to answer';
			case 'onboarding.ageQuestion.action': return 'Continue';
			case 'onboarding.genderQuestion.title': return 'What is your gender?';
			case 'onboarding.genderQuestion.description': return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
			case 'onboarding.genderQuestion.options.male': return 'Male';
			case 'onboarding.genderQuestion.options.female': return 'Female';
			case 'onboarding.genderQuestion.options.none': return 'I prefer not to answer';
			case 'onboarding.genderQuestion.action': return 'Continue';
			case 'onboarding.notifications.title': return 'Allow notifications';
			case 'onboarding.notifications.description': return 'We will only send you important notifications';
			case 'onboarding.notifications.continue_button': return 'Allow notifications';
			case 'onboarding.notifications.skip_button': return 'Maybe later';
			case 'onboarding.loading.title': return 'Creating your profile';
			case 'onboarding.loading.subtitle': return 'Wait a few seconds';
			case 'feature_requests.title': return 'Your opinion matters!';
			case 'feature_requests.description': return 'Vote or suggest new features.\nWe listen everyone of you to create the best possible app.';
			case 'feature_requests.vote_success.title': return 'Thank you!';
			case 'feature_requests.vote_success.description': return 'Your vote has been taken into account';
			case 'feature_requests.vote_error.title': return 'Error';
			case 'feature_requests.vote_error.description': return 'You already voted for a feature';
			case 'feature_requests.add_feature.title': return 'Suggest a feature';
			case 'feature_requests.add_feature.description': return 'What feature would you like to see in the app?';
			case 'feature_requests.add_feature.save_button': return 'Send';
			case 'feature_requests.add_feature.title_label': return 'Feature title';
			case 'feature_requests.add_feature.title_hint': return 'Enter a short descriptive title';
			case 'feature_requests.add_feature.description_label': return 'Description';
			case 'feature_requests.add_feature.description_hint': return 'Describe the feature or the improvement you would like to see in the app';
			case 'feature_requests.add_feature.toast_success.title': return 'Thank you!';
			case 'feature_requests.add_feature.toast_success.description': return 'We will review your suggestion';
			default: return null;
		}
	}
}

