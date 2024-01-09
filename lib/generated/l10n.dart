// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get projects {
    return Intl.message(
      'Projects',
      name: 'projects',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message(
      'Contacts',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks {
    return Intl.message(
      'Tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Additionally`
  String get additional {
    return Intl.message(
      'Additionally',
      name: 'additional',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Average Offer`
  String get avgOffer {
    return Intl.message(
      'Average Offer',
      name: 'avgOffer',
      desc: '',
      args: [],
    );
  }

  /// `Average discount`
  String get avgDiscount {
    return Intl.message(
      'Average discount',
      name: 'avgDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `OPPORTUNITY`
  String get opportunity {
    return Intl.message(
      'OPPORTUNITY',
      name: 'opportunity',
      desc: '',
      args: [],
    );
  }

  /// `CONFIRMED`
  String get confirmed {
    return Intl.message(
      'CONFIRMED',
      name: 'confirmed',
      desc: '',
      args: [],
    );
  }

  /// `CLOSED`
  String get closed {
    return Intl.message(
      'CLOSED',
      name: 'closed',
      desc: '',
      args: [],
    );
  }

  /// `ARCHIVE`
  String get archive {
    return Intl.message(
      'ARCHIVE',
      name: 'archive',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get logIn {
    return Intl.message(
      'Login',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the password`
  String get confirmPassword {
    return Intl.message(
      'Confirm the password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Password recovery`
  String get recoverPassword {
    return Intl.message(
      'Password recovery',
      name: 'recoverPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register now`
  String get signUp {
    return Intl.message(
      'Register now',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get recover {
    return Intl.message(
      'Restore',
      name: 'recover',
      desc: '',
      args: [],
    );
  }

  /// `Should not be empty`
  String get mustNotBeEmpty {
    return Intl.message(
      'Should not be empty',
      name: 'mustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Attention`
  String get attention {
    return Intl.message(
      'Attention',
      name: 'attention',
      desc: '',
      args: [],
    );
  }

  /// `Authorization failed. Incorrect login or password.\nLogin is name.surname as per ID.\nLogin should not contain @kazminerals.com.\nTo reset login or password, please push "Restore".`
  String get incorrectness {
    return Intl.message(
      'Authorization failed. Incorrect login or password.\nLogin is name.surname as per ID.\nLogin should not contain @kazminerals.com.\nTo reset login or password, please push "Restore".',
      name: 'incorrectness',
      desc: '',
      args: [],
    );
  }

  /// `timeOut`
  String get timeout {
    return Intl.message(
      'timeOut',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `Task editor`
  String get taskEditor {
    return Intl.message(
      'Task editor',
      name: 'taskEditor',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Successfully updated`
  String get updatedSuccess {
    return Intl.message(
      'Successfully updated',
      name: 'updatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update failed`
  String get updatedNotSuccess {
    return Intl.message(
      'Update failed',
      name: 'updatedNotSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Successfully deleted`
  String get deletedSuccess {
    return Intl.message(
      'Successfully deleted',
      name: 'deletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Required fields must not be null`
  String get fillRequiredFields {
    return Intl.message(
      'Required fields must not be null',
      name: 'fillRequiredFields',
      desc: '',
      args: [],
    );
  }

  /// `Event Editor`
  String get eventEditor {
    return Intl.message(
      'Event Editor',
      name: 'eventEditor',
      desc: '',
      args: [],
    );
  }

  /// `Observer`
  String get observer {
    return Intl.message(
      'Observer',
      name: 'observer',
      desc: '',
      args: [],
    );
  }

  /// `Filter: Name`
  String get filterName {
    return Intl.message(
      'Filter: Name',
      name: 'filterName',
      desc: '',
      args: [],
    );
  }

  /// `Actively`
  String get active {
    return Intl.message(
      'Actively',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Inactively`
  String get inactive {
    return Intl.message(
      'Inactively',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }

  /// `Resident`
  String get resident {
    return Intl.message(
      'Resident',
      name: 'resident',
      desc: '',
      args: [],
    );
  }

  /// `Not resident`
  String get notResident {
    return Intl.message(
      'Not resident',
      name: 'notResident',
      desc: '',
      args: [],
    );
  }

  /// `Annual income`
  String get annualIncome {
    return Intl.message(
      'Annual income',
      name: 'annualIncome',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Family status`
  String get familyStatus {
    return Intl.message(
      'Family status',
      name: 'familyStatus',
      desc: '',
      args: [],
    );
  }

  /// `Amount of children`
  String get amountOfChildren {
    return Intl.message(
      'Amount of children',
      name: 'amountOfChildren',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nation {
    return Intl.message(
      'Nationality',
      name: 'nation',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get experience {
    return Intl.message(
      'Experience',
      name: 'experience',
      desc: '',
      args: [],
    );
  }

  /// `Industry`
  String get industry {
    return Intl.message(
      'Industry',
      name: 'industry',
      desc: '',
      args: [],
    );
  }

  /// `Not right format`
  String get notRightFormat {
    return Intl.message(
      'Not right format',
      name: 'notRightFormat',
      desc: '',
      args: [],
    );
  }

  /// `Company day`
  String get companyDay {
    return Intl.message(
      'Company day',
      name: 'companyDay',
      desc: '',
      args: [],
    );
  }

  /// `Brand name`
  String get brandName {
    return Intl.message(
      'Brand name',
      name: 'brandName',
      desc: '',
      args: [],
    );
  }

  /// `State company`
  String get stateCompany {
    return Intl.message(
      'State company',
      name: 'stateCompany',
      desc: '',
      args: [],
    );
  }

  /// `Web address`
  String get webAddress {
    return Intl.message(
      'Web address',
      name: 'webAddress',
      desc: '',
      args: [],
    );
  }

  /// `ADDITIONAL`
  String get Additional {
    return Intl.message(
      'ADDITIONAL',
      name: 'Additional',
      desc: '',
      args: [],
    );
  }

  /// `MAIN`
  String get Main {
    return Intl.message(
      'MAIN',
      name: 'Main',
      desc: '',
      args: [],
    );
  }

  /// `EDIT`
  String get editButtonCaps {
    return Intl.message(
      'EDIT',
      name: 'editButtonCaps',
      desc: '',
      args: [],
    );
  }

  /// `Party`
  String get party {
    return Intl.message(
      'Party',
      name: 'party',
      desc: '',
      args: [],
    );
  }

  /// `Individual editor`
  String get privat_person_editor {
    return Intl.message(
      'Individual editor',
      name: 'privat_person_editor',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Type of ownership`
  String get typeOfOwnership {
    return Intl.message(
      'Type of ownership',
      name: 'typeOfOwnership',
      desc: '',
      args: [],
    );
  }

  /// `IIN/BIN`
  String get nationalIdentifier {
    return Intl.message(
      'IIN/BIN',
      name: 'nationalIdentifier',
      desc: '',
      args: [],
    );
  }

  /// `Country of residence`
  String get countryOfResidence {
    return Intl.message(
      'Country of residence',
      name: 'countryOfResidence',
      desc: '',
      args: [],
    );
  }

  /// `Counterparty segment`
  String get counterpartySegment {
    return Intl.message(
      'Counterparty segment',
      name: 'counterpartySegment',
      desc: '',
      args: [],
    );
  }

  /// `Marketing company`
  String get marketingCompany {
    return Intl.message(
      'Marketing company',
      name: 'marketingCompany',
      desc: '',
      args: [],
    );
  }

  /// `Responsible`
  String get responsible {
    return Intl.message(
      'Responsible',
      name: 'responsible',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `MiddleName`
  String get middleName {
    return Intl.message(
      'MiddleName',
      name: 'middleName',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get personName {
    return Intl.message(
      'Name',
      name: 'personName',
      desc: '',
      args: [],
    );
  }

  /// `Additional Information`
  String get additionalInfo {
    return Intl.message(
      'Additional Information',
      name: 'additionalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get mainInfo {
    return Intl.message(
      'Basic Information',
      name: 'mainInfo',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get bithDate {
    return Intl.message(
      'Date of Birth',
      name: 'bithDate',
      desc: '',
      args: [],
    );
  }

  /// `Sex`
  String get sex {
    return Intl.message(
      'Sex',
      name: 'sex',
      desc: '',
      args: [],
    );
  }

  /// `Birth place`
  String get buildPlace {
    return Intl.message(
      'Birth place',
      name: 'buildPlace',
      desc: '',
      args: [],
    );
  }

  /// `Not Valid number`
  String get notAValidNumber {
    return Intl.message(
      'Not Valid number',
      name: 'notAValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Short Name`
  String get shortName {
    return Intl.message(
      'Short Name',
      name: 'shortName',
      desc: '',
      args: [],
    );
  }

  /// `Legal Entity Editor`
  String get company_party_editor {
    return Intl.message(
      'Legal Entity Editor',
      name: 'company_party_editor',
      desc: '',
      args: [],
    );
  }

  /// `Task type`
  String get taskType {
    return Intl.message(
      'Task type',
      name: 'taskType',
      desc: '',
      args: [],
    );
  }

  /// `Subtype`
  String get subtype {
    return Intl.message(
      'Subtype',
      name: 'subtype',
      desc: '',
      args: [],
    );
  }

  /// `Heading`
  String get heading {
    return Intl.message(
      'Heading',
      name: 'heading',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Counterparty`
  String get contragent {
    return Intl.message(
      'Counterparty',
      name: 'contragent',
      desc: '',
      args: [],
    );
  }

  /// `Appointed`
  String get appointed {
    return Intl.message(
      'Appointed',
      name: 'appointed',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message(
      'Start Date',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `Expiration Date`
  String get endDate {
    return Intl.message(
      'Expiration Date',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// `Start Date Time`
  String get startDateTime {
    return Intl.message(
      'Start Date Time',
      name: 'startDateTime',
      desc: '',
      args: [],
    );
  }

  /// `End Date Time`
  String get endDateTime {
    return Intl.message(
      'End Date Time',
      name: 'endDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Registration Is Open Until`
  String get registrationIsOpenUntil {
    return Intl.message(
      'Registration Is Open Until',
      name: 'registrationIsOpenUntil',
      desc: '',
      args: [],
    );
  }

  /// `Execution date`
  String get executionDate {
    return Intl.message(
      'Execution date',
      name: 'executionDate',
      desc: '',
      args: [],
    );
  }

  /// `Planned duration`
  String get plannedDuration {
    return Intl.message(
      'Planned duration',
      name: 'plannedDuration',
      desc: '',
      args: [],
    );
  }

  /// `Notify for`
  String get notifyFor {
    return Intl.message(
      'Notify for',
      name: 'notifyFor',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Project`
  String get project {
    return Intl.message(
      'Project',
      name: 'project',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Team`
  String get team {
    return Intl.message(
      'Team',
      name: 'team',
      desc: '',
      args: [],
    );
  }

  /// `EDIT`
  String get edit {
    return Intl.message(
      'EDIT',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `EXECUTE`
  String get perform {
    return Intl.message(
      'EXECUTE',
      name: 'perform',
      desc: '',
      args: [],
    );
  }

  /// `TIME ACCOUNTING`
  String get time_accounting {
    return Intl.message(
      'TIME ACCOUNTING',
      name: 'time_accounting',
      desc: '',
      args: [],
    );
  }

  /// `Lead`
  String get lead {
    return Intl.message(
      'Lead',
      name: 'lead',
      desc: '',
      args: [],
    );
  }

  /// `Event Date`
  String get eventDate {
    return Intl.message(
      'Event Date',
      name: 'eventDate',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get durability {
    return Intl.message(
      'Duration',
      name: 'durability',
      desc: '',
      args: [],
    );
  }

  /// `Spent`
  String get spend {
    return Intl.message(
      'Spent',
      name: 'spend',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Offer`
  String get offers {
    return Intl.message(
      'Offer',
      name: 'offers',
      desc: '',
      args: [],
    );
  }

  /// `Souvenir`
  String get souvenir {
    return Intl.message(
      'Souvenir',
      name: 'souvenir',
      desc: '',
      args: [],
    );
  }

  /// `Souvenir`
  String get Souvenir {
    return Intl.message(
      'Souvenir',
      name: 'Souvenir',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get taskMenuKey {
    return Intl.message(
      'Task',
      name: 'taskMenuKey',
      desc: '',
      args: [],
    );
  }

  /// `The Issue Date must not be later than the closing date`
  String get opportunityStartDateLowerThanEndDate {
    return Intl.message(
      'The Issue Date must not be later than the closing date',
      name: 'opportunityStartDateLowerThanEndDate',
      desc: '',
      args: [],
    );
  }

  /// `The closing date must not be earlier than the issue date`
  String get opportunityEndDateGreaterThanStartDate {
    return Intl.message(
      'The closing date must not be earlier than the issue date',
      name: 'opportunityEndDateGreaterThanStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get files {
    return Intl.message(
      'Files',
      name: 'files',
      desc: '',
      args: [],
    );
  }

  /// `Account number`
  String get accountNumber {
    return Intl.message(
      'Account number',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Author`
  String get author {
    return Intl.message(
      'Author',
      name: 'author',
      desc: '',
      args: [],
    );
  }

  /// `Date of issue`
  String get billingDate {
    return Intl.message(
      'Date of issue',
      name: 'billingDate',
      desc: '',
      args: [],
    );
  }

  /// `Payment term, (days)`
  String get paymentPeriod {
    return Intl.message(
      'Payment term, (days)',
      name: 'paymentPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Payer`
  String get payer {
    return Intl.message(
      'Payer',
      name: 'payer',
      desc: '',
      args: [],
    );
  }

  /// `Poena`
  String get poena {
    return Intl.message(
      'Poena',
      name: 'poena',
      desc: '',
      args: [],
    );
  }

  /// `Terms of payment`
  String get termsOfPayment {
    return Intl.message(
      'Terms of payment',
      name: 'termsOfPayment',
      desc: '',
      args: [],
    );
  }

  /// `Update is available`
  String get updateIsAvailable {
    return Intl.message(
      'Update is available',
      name: 'updateIsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Update needed`
  String get updateIsRequired {
    return Intl.message(
      'Update needed',
      name: 'updateIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Update the T2Crm application.\nYour version is outdated without the update functions are not available`
  String get updateT2crmnOldVersion {
    return Intl.message(
      'Update the T2Crm application.\nYour version is outdated without the update functions are not available',
      name: 'updateT2crmnOldVersion',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Not a state company`
  String get notAStateCompany {
    return Intl.message(
      'Not a state company',
      name: 'notAStateCompany',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get companyName {
    return Intl.message(
      'Name',
      name: 'companyName',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get userNotFound {
    return Intl.message(
      'User not found',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Server Error`
  String get serverError {
    return Intl.message(
      'Server Error',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Successfully`
  String get success {
    return Intl.message(
      'Successfully',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `You will receive a letter with a code by mail`
  String get youWillReceiveALetterWithACodeByMail {
    return Intl.message(
      'You will receive a letter with a code by mail',
      name: 'youWillReceiveALetterWithACodeByMail',
      desc: '',
      args: [],
    );
  }

  /// `An email has been sent to you`
  String get anEmailHasBeenSentToYou {
    return Intl.message(
      'An email has been sent to you',
      name: 'anEmailHasBeenSentToYou',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Contract`
  String get contracts {
    return Intl.message(
      'Contract',
      name: 'contracts',
      desc: '',
      args: [],
    );
  }

  /// `Project number`
  String get projectNumber {
    return Intl.message(
      'Project number',
      name: 'projectNumber',
      desc: '',
      args: [],
    );
  }

  /// `Project name`
  String get projectName {
    return Intl.message(
      'Project name',
      name: 'projectName',
      desc: '',
      args: [],
    );
  }

  /// `Client`
  String get client {
    return Intl.message(
      'Client',
      name: 'client',
      desc: '',
      args: [],
    );
  }

  /// `Project start`
  String get projectStartDate {
    return Intl.message(
      'Project start',
      name: 'projectStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get deadline {
    return Intl.message(
      'Deadline',
      name: 'deadline',
      desc: '',
      args: [],
    );
  }

  /// `Project Description`
  String get projectDescription {
    return Intl.message(
      'Project Description',
      name: 'projectDescription',
      desc: '',
      args: [],
    );
  }

  /// `Project manager`
  String get projectManager {
    return Intl.message(
      'Project manager',
      name: 'projectManager',
      desc: '',
      args: [],
    );
  }

  /// `Project category`
  String get projectCategory {
    return Intl.message(
      'Project category',
      name: 'projectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Create Task / Activity`
  String get createTask {
    return Intl.message(
      'Create Task / Activity',
      name: 'createTask',
      desc: '',
      args: [],
    );
  }

  /// `Stages / Goal`
  String get projectStages {
    return Intl.message(
      'Stages / Goal',
      name: 'projectStages',
      desc: '',
      args: [],
    );
  }

  /// `Obligatory field`
  String get obligatoryField {
    return Intl.message(
      'Obligatory field',
      name: 'obligatoryField',
      desc: '',
      args: [],
    );
  }

  /// `Team-only access`
  String get teamOnlyAccess {
    return Intl.message(
      'Team-only access',
      name: 'teamOnlyAccess',
      desc: '',
      args: [],
    );
  }

  /// `Create Stage / Goal`
  String get createStageGoal {
    return Intl.message(
      'Create Stage / Goal',
      name: 'createStageGoal',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get finish {
    return Intl.message(
      'Complete',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Select application language`
  String get selectApplicationLanguage {
    return Intl.message(
      'Select application language',
      name: 'selectApplicationLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Client must be asked`
  String get clientMustBeAsked {
    return Intl.message(
      'Client must be asked',
      name: 'clientMustBeAsked',
      desc: '',
      args: [],
    );
  }

  /// `Incoming Call Log`
  String get callLogIn {
    return Intl.message(
      'Incoming Call Log',
      name: 'callLogIn',
      desc: '',
      args: [],
    );
  }

  /// `Outgoing Call Log`
  String get callLogOut {
    return Intl.message(
      'Outgoing Call Log',
      name: 'callLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get closedOpp {
    return Intl.message(
      'Closed',
      name: 'closedOpp',
      desc: '',
      args: [],
    );
  }

  /// `Unclosed`
  String get unclosed {
    return Intl.message(
      'Unclosed',
      name: 'unclosed',
      desc: '',
      args: [],
    );
  }

  /// `To Complete`
  String get toComplete {
    return Intl.message(
      'To Complete',
      name: 'toComplete',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get completed {
    return Intl.message(
      'Complete',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Help sent for approval`
  String get certificateSuccess {
    return Intl.message(
      'Help sent for approval',
      name: 'certificateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `You do not have vacation days for work on weekends and holidays`
  String get youDoNotVacationDays {
    return Intl.message(
      'You do not have vacation days for work on weekends and holidays',
      name: 'youDoNotVacationDays',
      desc: '',
      args: [],
    );
  }

  /// `Not enough vacation days for work on weekends and holidays. Please specify other dates`
  String get notEnoughVacationDays {
    return Intl.message(
      'Not enough vacation days for work on weekends and holidays. Please specify other dates',
      name: 'notEnoughVacationDays',
      desc: '',
      args: [],
    );
  }

  /// `One of the vacation parts must be at least" Number of vacation days in a year (min) "days. Change the vacation dates in the request`
  String get oneOfTheVacationPartsMustBe {
    return Intl.message(
      'One of the vacation parts must be at least" Number of vacation days in a year (min) "days. Change the vacation dates in the request',
      name: 'oneOfTheVacationPartsMustBe',
      desc: '',
      args: [],
    );
  }

  /// `The unused part of the paid annual leave due to the recall is granted`
  String get leaveOtherTimeAlertTitle {
    return Intl.message(
      'The unused part of the paid annual leave due to the recall is granted',
      name: 'leaveOtherTimeAlertTitle',
      desc: '',
      args: [],
    );
  }

  /// `1) during the current working year \n2) in the next working year at any time\n3) either joins the paid annual leave for the next working year.`
  String get leaveOtherTimeAlertContent {
    return Intl.message(
      '1) during the current working year \n2) in the next working year at any time\n3) either joins the paid annual leave for the next working year.',
      name: 'leaveOtherTimeAlertContent',
      desc: '',
      args: [],
    );
  }

  /// `Planned start date`
  String get plannedStartDate {
    return Intl.message(
      'Planned start date',
      name: 'plannedStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Task approved`
  String get approve {
    return Intl.message(
      'Task approved',
      name: 'approve',
      desc: '',
      args: [],
    );
  }

  /// `Task reassigned`
  String get reassign {
    return Intl.message(
      'Task reassigned',
      name: 'reassign',
      desc: '',
      args: [],
    );
  }

  /// `Task rejected`
  String get reject {
    return Intl.message(
      'Task rejected',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `Submitted for revision`
  String get revision {
    return Intl.message(
      'Submitted for revision',
      name: 'revision',
      desc: '',
      args: [],
    );
  }

  /// `Submitted for approval`
  String get sendForApproval {
    return Intl.message(
      'Submitted for approval',
      name: 'sendForApproval',
      desc: '',
      args: [],
    );
  }

  /// `Submitted for approval`
  String get start {
    return Intl.message(
      'Submitted for approval',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Approve`
  String get outcomeApprove {
    return Intl.message(
      'Approve',
      name: 'outcomeApprove',
      desc: '',
      args: [],
    );
  }

  /// `Auto reassign`
  String get outcomeAutoReassign {
    return Intl.message(
      'Auto reassign',
      name: 'outcomeAutoReassign',
      desc: '',
      args: [],
    );
  }

  /// `Reassign`
  String get outcomeReassign {
    return Intl.message(
      'Reassign',
      name: 'outcomeReassign',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get outcomeReject {
    return Intl.message(
      'Reject',
      name: 'outcomeReject',
      desc: '',
      args: [],
    );
  }

  /// `Send for revision`
  String get outcomeRevision {
    return Intl.message(
      'Send for revision',
      name: 'outcomeRevision',
      desc: '',
      args: [],
    );
  }

  /// `Send for approval`
  String get outcomeSendForApproval {
    return Intl.message(
      'Send for approval',
      name: 'outcomeSendForApproval',
      desc: '',
      args: [],
    );
  }

  /// `If necessary, use adding users to the route manually`
  String get outcomeAddIfNecessary {
    return Intl.message(
      'If necessary, use adding users to the route manually',
      name: 'outcomeAddIfNecessary',
      desc: '',
      args: [],
    );
  }

  /// `Start process`
  String get outcomeStart {
    return Intl.message(
      'Start process',
      name: 'outcomeStart',
      desc: '',
      args: [],
    );
  }

  /// `Cancel process`
  String get outcomeCancel {
    return Intl.message(
      'Cancel process',
      name: 'outcomeCancel',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get personalInfo {
    return Intl.message(
      'Personal information',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Time management`
  String get timeManagement {
    return Intl.message(
      'Time management',
      name: 'timeManagement',
      desc: '',
      args: [],
    );
  }

  /// `Leave request`
  String get absence {
    return Intl.message(
      'Leave request',
      name: 'absence',
      desc: '',
      args: [],
    );
  }

  /// `Leave request`
  String get leaveRequest {
    return Intl.message(
      'Leave request',
      name: 'leaveRequest',
      desc: '',
      args: [],
    );
  }

  /// `Shift schedule`
  String get shiftSchedule {
    return Intl.message(
      'Shift schedule',
      name: 'shiftSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Shift schedule request`
  String get shiftScheduleRequest {
    return Intl.message(
      'Shift schedule request',
      name: 'shiftScheduleRequest',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `My Team`
  String get myTeam {
    return Intl.message(
      'My Team',
      name: 'myTeam',
      desc: '',
      args: [],
    );
  }

  /// `My Absences`
  String get myAbsences {
    return Intl.message(
      'My Absences',
      name: 'myAbsences',
      desc: '',
      args: [],
    );
  }

  /// `Vacation Schedule`
  String get vacationSchedule {
    return Intl.message(
      'Vacation Schedule',
      name: 'vacationSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Medical Insurance`
  String get medicalInsurance {
    return Intl.message(
      'Medical Insurance',
      name: 'medicalInsurance',
      desc: '',
      args: [],
    );
  }

  /// `Job Confirmation Letter`
  String get jclRequest {
    return Intl.message(
      'Job Confirmation Letter',
      name: 'jclRequest',
      desc: '',
      args: [],
    );
  }

  /// `Payslip`
  String get payslip {
    return Intl.message(
      'Payslip',
      name: 'payslip',
      desc: '',
      args: [],
    );
  }

  /// `Training`
  String get training {
    return Intl.message(
      'Training',
      name: 'training',
      desc: '',
      args: [],
    );
  }

  /// `My KPI`
  String get myKpi {
    return Intl.message(
      'My KPI',
      name: 'myKpi',
      desc: '',
      args: [],
    );
  }

  /// `Teams KPI`
  String get teamsKpi {
    return Intl.message(
      'Teams KPI',
      name: 'teamsKpi',
      desc: '',
      args: [],
    );
  }

  /// `Tasks and notifications`
  String get tasksNotifications {
    return Intl.message(
      'Tasks and notifications',
      name: 'tasksNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get task {
    return Intl.message(
      'Tasks',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get areYouSureToLogout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'areYouSureToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Absence request`
  String get absenceRequest {
    return Intl.message(
      'Absence request',
      name: 'absenceRequest',
      desc: '',
      args: [],
    );
  }

  /// `Training Catalogue`
  String get trainingCatalogue {
    return Intl.message(
      'Training Catalogue',
      name: 'trainingCatalogue',
      desc: '',
      args: [],
    );
  }

  /// `My Courses`
  String get myCourses {
    return Intl.message(
      'My Courses',
      name: 'myCourses',
      desc: '',
      args: [],
    );
  }

  /// `Training history`
  String get trainingHistory {
    return Intl.message(
      'Training history',
      name: 'trainingHistory',
      desc: '',
      args: [],
    );
  }

  /// `Library`
  String get library {
    return Intl.message(
      'Library',
      name: 'library',
      desc: '',
      args: [],
    );
  }

  /// `Join Health Insurance`
  String get joinHealthInsurance {
    return Intl.message(
      'Join Health Insurance',
      name: 'joinHealthInsurance',
      desc: '',
      args: [],
    );
  }

  /// `General information`
  String get generalInformation {
    return Intl.message(
      'General information',
      name: 'generalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Insurance information`
  String get insuranceInformation {
    return Intl.message(
      'Insurance information',
      name: 'insuranceInformation',
      desc: '',
      args: [],
    );
  }

  /// `Approval steps`
  String get approvalSteps {
    return Intl.message(
      'Approval steps',
      name: 'approvalSteps',
      desc: '',
      args: [],
    );
  }

  /// `Get certificate`
  String get getCertificate {
    return Intl.message(
      'Get certificate',
      name: 'getCertificate',
      desc: '',
      args: [],
    );
  }

  /// `If you do not have a corporate account`
  String get register {
    return Intl.message(
      'If you do not have a corporate account',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerButton {
    return Intl.message(
      'Register',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `To register, you need to install Telegram on your phone`
  String get installTelegram {
    return Intl.message(
      'To register, you need to install Telegram on your phone',
      name: 'installTelegram',
      desc: '',
      args: [],
    );
  }

  /// `Forgot login and/or password?`
  String get forgotThePassword {
    return Intl.message(
      'Forgot login and/or password?',
      name: 'forgotThePassword',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get recoverThePassword {
    return Intl.message(
      'Restore',
      name: 'recoverThePassword',
      desc: '',
      args: [],
    );
  }

  /// `IIN`
  String get iin {
    return Intl.message(
      'IIN',
      name: 'iin',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Already registered?`
  String get alreadyRegistered {
    return Intl.message(
      'Already registered?',
      name: 'alreadyRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get enter {
    return Intl.message(
      'Login',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `ОК`
  String get ok {
    return Intl.message(
      'ОК',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `An employee with this IIN is not registered in the database. Contact the HR service`
  String get signUpDataEmpty {
    return Intl.message(
      'An employee with this IIN is not registered in the database. Contact the HR service',
      name: 'signUpDataEmpty',
      desc: '',
      args: [],
    );
  }

  /// `A user is already registered in the system for the specified IIN. If you forgot your login and / or password, use the password recovery function`
  String get signUpLinkedUserExists {
    return Intl.message(
      'A user is already registered in the system for the specified IIN. If you forgot your login and / or password, use the password recovery function',
      name: 'signUpLinkedUserExists',
      desc: '',
      args: [],
    );
  }

  /// `An employee with this IIN is not registered in the database. Contact the HR service`
  String get signUpLinkedUserNotExists {
    return Intl.message(
      'An employee with this IIN is not registered in the database. Contact the HR service',
      name: 'signUpLinkedUserNotExists',
      desc: '',
      args: [],
    );
  }

  /// `The user with the specified IIN is blocked. We ask you to contact the IT service`
  String get signUpIINLocked {
    return Intl.message(
      'The user with the specified IIN is blocked. We ask you to contact the IT service',
      name: 'signUpIINLocked',
      desc: '',
      args: [],
    );
  }

  /// `An employee with such a combination of IIN and phone number is not in the system. Contact the HR service`
  String get signUpIncorrectPhone {
    return Intl.message(
      'An employee with such a combination of IIN and phone number is not in the system. Contact the HR service',
      name: 'signUpIncorrectPhone',
      desc: '',
      args: [],
    );
  }

  /// `There is a corporate account for the specified IIN. Please use it to enter the portal`
  String get signUpCorpUserExists {
    return Intl.message(
      'There is a corporate account for the specified IIN. Please use it to enter the portal',
      name: 'signUpCorpUserExists',
      desc: '',
      args: [],
    );
  }

  /// `An employee with this combination of IIN and phone number is not in the system`
  String get signUpIncorrectInputs {
    return Intl.message(
      'An employee with this combination of IIN and phone number is not in the system',
      name: 'signUpIncorrectInputs',
      desc: '',
      args: [],
    );
  }

  /// `Verification code has been sent to your phone.`
  String get signUpVerifyTelegramText {
    return Intl.message(
      'Verification code has been sent to your phone.',
      name: 'signUpVerifyTelegramText',
      desc: '',
      args: [],
    );
  }

  /// `A verification code will be sent to your phone to reset your password. Enter it please`
  String get signUpVerifyTelegramTextRecover {
    return Intl.message(
      'A verification code will be sent to your phone to reset your password. Enter it please',
      name: 'signUpVerifyTelegramTextRecover',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get signUpVerifyEditHint {
    return Intl.message(
      'Verification code',
      name: 'signUpVerifyEditHint',
      desc: '',
      args: [],
    );
  }

  /// `Left until verification:`
  String get signUpVerifyTimer {
    return Intl.message(
      'Left until verification:',
      name: 'signUpVerifyTimer',
      desc: '',
      args: [],
    );
  }

  /// `Send again`
  String get signUpVerifyResend {
    return Intl.message(
      'Send again',
      name: 'signUpVerifyResend',
      desc: '',
      args: [],
    );
  }

  /// `Enter password.\n - Password must be at least 8 characters;\n - Contain letters of the dark and uppercase\n - Numbers (0-9);\n - Special characters #!,%:?*()_+<>/\)`
  String get signUpPassword {
    return Intl.message(
      'Enter password.\n - Password must be at least 8 characters;\n - Contain letters of the dark and uppercase\n - Numbers (0-9);\n - Special characters #!,%:?*()_+<>/\)',
      name: 'signUpPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get signUpPasswordText {
    return Intl.message(
      'Password',
      name: 'signUpPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get signUpRepeatPasswordText {
    return Intl.message(
      'Repeat password',
      name: 'signUpRepeatPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Error sending SMS`
  String get signUpSendVerificationCodeError {
    return Intl.message(
      'Error sending SMS',
      name: 'signUpSendVerificationCodeError',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Application Error`
  String get exception {
    return Intl.message(
      'Unexpected Application Error',
      name: 'exception',
      desc: '',
      args: [],
    );
  }

  /// `Error. SMS code is not correct`
  String get signUpVerifyIncorrectCode {
    return Intl.message(
      'Error. SMS code is not correct',
      name: 'signUpVerifyIncorrectCode',
      desc: '',
      args: [],
    );
  }

  /// `Your account is missing a First name`
  String get signUpEmptyName {
    return Intl.message(
      'Your account is missing a First name',
      name: 'signUpEmptyName',
      desc: '',
      args: [],
    );
  }

  /// `Your account is missing a Last name`
  String get signUpEmptySurname {
    return Intl.message(
      'Your account is missing a Last name',
      name: 'signUpEmptySurname',
      desc: '',
      args: [],
    );
  }

  /// `A login has not yet been generated for your account`
  String get signUpEmptyLogin {
    return Intl.message(
      'A login has not yet been generated for your account',
      name: 'signUpEmptyLogin',
      desc: '',
      args: [],
    );
  }

  /// `Password update failed`
  String get signUpSavePasswordError {
    return Intl.message(
      'Password update failed',
      name: 'signUpSavePasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Password saved successfully`
  String get signUpSavePasswordOk {
    return Intl.message(
      'Password saved successfully',
      name: 'signUpSavePasswordOk',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations, you have successfully registered.Your login name is shown below.Remember it and your password and do not share them with anyone.`
  String get signUpLoginGenerated {
    return Intl.message(
      'Congratulations, you have successfully registered.Your login name is shown below.Remember it and your password and do not share them with anyone.',
      name: 'signUpLoginGenerated',
      desc: '',
      args: [],
    );
  }

  /// `Your new password has been successfully saved in the database. Remember it and your password and do not share them with anyone.`
  String get recoverPasswordSaved {
    return Intl.message(
      'Your new password has been successfully saved in the database. Remember it and your password and do not share them with anyone.',
      name: 'recoverPasswordSaved',
      desc: '',
      args: [],
    );
  }

  /// `To the start page`
  String get toStartPage {
    return Intl.message(
      'To the start page',
      name: 'toStartPage',
      desc: '',
      args: [],
    );
  }

  /// `To reset login and password, please indicate your ID and mobile number registered in the system.\nVerification sms-code will be sent to your number.\nIf the previous mobile number is not relevant, please address to HR.`
  String get recoverPasswordScreenText {
    return Intl.message(
      'To reset login and password, please indicate your ID and mobile number registered in the system.\nVerification sms-code will be sent to your number.\nIf the previous mobile number is not relevant, please address to HR.',
      name: 'recoverPasswordScreenText',
      desc: '',
      args: [],
    );
  }

  /// ` HR requests`
  String get hr {
    return Intl.message(
      ' HR requests',
      name: 'hr',
      desc: '',
      args: [],
    );
  }

  /// `My calendar`
  String get myCalendar {
    return Intl.message(
      'My calendar',
      name: 'myCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Job confirmation letter`
  String get reference {
    return Intl.message(
      'Job confirmation letter',
      name: 'reference',
      desc: '',
      args: [],
    );
  }

  /// `Send message`
  String get question {
    return Intl.message(
      'Send message',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// ` Daily survey`
  String get everydayQuestions {
    return Intl.message(
      ' Daily survey',
      name: 'everydayQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Your answer`
  String get everydayQuestionsAnswer {
    return Intl.message(
      'Your answer',
      name: 'everydayQuestionsAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Pass`
  String get everydayQuestionsButton {
    return Intl.message(
      'Pass',
      name: 'everydayQuestionsButton',
      desc: '',
      args: [],
    );
  }

  /// `Not all fields are filled!`
  String get everydayQuestionsAlert {
    return Intl.message(
      'Not all fields are filled!',
      name: 'everydayQuestionsAlert',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred`
  String get everydayQuestionsPushError {
    return Intl.message(
      'An error has occurred',
      name: 'everydayQuestionsPushError',
      desc: '',
      args: [],
    );
  }

  /// `You are successfully finish questionnaire`
  String get everydayQuestionsSuccess {
    return Intl.message(
      'You are successfully finish questionnaire',
      name: 'everydayQuestionsSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Send message`
  String get sendMessage {
    return Intl.message(
      'Send message',
      name: 'sendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Personal Data`
  String get personalData {
    return Intl.message(
      'Personal Data',
      name: 'personalData',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get comment {
    return Intl.message(
      'Notes',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Unable to navigate to URL`
  String get cannotGoToURL {
    return Intl.message(
      'Unable to navigate to URL',
      name: 'cannotGoToURL',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get documents {
    return Intl.message(
      'Documents',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `Document Number`
  String get documentNumber {
    return Intl.message(
      'Document Number',
      name: 'documentNumber',
      desc: '',
      args: [],
    );
  }

  /// `Issuing authority`
  String get issuingAuthority {
    return Intl.message(
      'Issuing authority',
      name: 'issuingAuthority',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editText {
    return Intl.message(
      'Edit',
      name: 'editText',
      desc: '',
      args: [],
    );
  }

  /// `Change of identity documents`
  String get personDocument {
    return Intl.message(
      'Change of identity documents',
      name: 'personDocument',
      desc: '',
      args: [],
    );
  }

  /// `Send for approval`
  String get sendToApproval {
    return Intl.message(
      'Send for approval',
      name: 'sendToApproval',
      desc: '',
      args: [],
    );
  }

  /// `Request number`
  String get requestNumber {
    return Intl.message(
      'Request number',
      name: 'requestNumber',
      desc: '',
      args: [],
    );
  }

  /// `Request Date`
  String get requestDate {
    return Intl.message(
      'Request Date',
      name: 'requestDate',
      desc: '',
      args: [],
    );
  }

  /// `Document Type`
  String get documentType {
    return Intl.message(
      'Document Type',
      name: 'documentType',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Issued By (for expat)`
  String get issuingAuthorityExpats {
    return Intl.message(
      'Issued By (for expat)',
      name: 'issuingAuthorityExpats',
      desc: '',
      args: [],
    );
  }

  /// `Issue Date`
  String get validFromDate {
    return Intl.message(
      'Issue Date',
      name: 'validFromDate',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get validToDate {
    return Intl.message(
      'Expiry Date',
      name: 'validToDate',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation document`
  String get confirmationDocument {
    return Intl.message(
      'Confirmation document',
      name: 'confirmationDocument',
      desc: '',
      args: [],
    );
  }

  /// `Document type not selected`
  String get documentTypeNotSelected {
    return Intl.message(
      'Document type not selected',
      name: 'documentTypeNotSelected',
      desc: '',
      args: [],
    );
  }

  /// `Issuing authority not selected`
  String get issuingAuthorityNotSelected {
    return Intl.message(
      'Issuing authority not selected',
      name: 'issuingAuthorityNotSelected',
      desc: '',
      args: [],
    );
  }

  /// `Issue date not selected`
  String get validFromDateNotSelected {
    return Intl.message(
      'Issue date not selected',
      name: 'validFromDateNotSelected',
      desc: '',
      args: [],
    );
  }

  /// `No expiration date selected`
  String get validToDateNotSelected {
    return Intl.message(
      'No expiration date selected',
      name: 'validToDateNotSelected',
      desc: '',
      args: [],
    );
  }

  /// `Document number is not filled`
  String get documentNumberNotSelected {
    return Intl.message(
      'Document number is not filled',
      name: 'documentNumberNotSelected',
      desc: '',
      args: [],
    );
  }

  /// `Need to attach attachments`
  String get filesNotSelected {
    return Intl.message(
      'Need to attach attachments',
      name: 'filesNotSelected',
      desc: '',
      args: [],
    );
  }

  /// `Error when saving request`
  String get saveRequestError {
    return Intl.message(
      'Error when saving request',
      name: 'saveRequestError',
      desc: '',
      args: [],
    );
  }

  /// `Request saved successfully!`
  String get saveRequestSuccess {
    return Intl.message(
      'Request saved successfully!',
      name: 'saveRequestSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Material aid`
  String get materialAssistance {
    return Intl.message(
      'Material aid',
      name: 'materialAssistance',
      desc: '',
      args: [],
    );
  }

  /// `Аddress`
  String get adress {
    return Intl.message(
      'Аddress',
      name: 'adress',
      desc: '',
      args: [],
    );
  }

  /// `Classifier of administrative territorial objects (CATO)`
  String get addressKATO {
    return Intl.message(
      'Classifier of administrative territorial objects (CATO)',
      name: 'addressKATO',
      desc: '',
      args: [],
    );
  }

  /// `Classifier of administrative territorial objects (CATO)`
  String get addressKATOCode {
    return Intl.message(
      'Classifier of administrative territorial objects (CATO)',
      name: 'addressKATOCode',
      desc: '',
      args: [],
    );
  }

  /// `Postal code`
  String get addressPostalCode {
    return Intl.message(
      'Postal code',
      name: 'addressPostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get addressCountry {
    return Intl.message(
      'Country',
      name: 'addressCountry',
      desc: '',
      args: [],
    );
  }

  /// `Street type code`
  String get addressStreetType {
    return Intl.message(
      'Street type code',
      name: 'addressStreetType',
      desc: '',
      args: [],
    );
  }

  /// `Address change`
  String get addressCaption {
    return Intl.message(
      'Address change',
      name: 'addressCaption',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Date from`
  String get dateFrom {
    return Intl.message(
      'Date from',
      name: 'dateFrom',
      desc: '',
      args: [],
    );
  }

  /// `Date to`
  String get dateTo {
    return Intl.message(
      'Date to',
      name: 'dateTo',
      desc: '',
      args: [],
    );
  }

  /// `Address type`
  String get addressType {
    return Intl.message(
      'Address type',
      name: 'addressType',
      desc: '',
      args: [],
    );
  }

  /// `Postal code`
  String get postalCode {
    return Intl.message(
      'Postal code',
      name: 'postalCode',
      desc: '',
      args: [],
    );
  }

  /// `Street name`
  String get street {
    return Intl.message(
      'Street name',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get homeNum {
    return Intl.message(
      'Building',
      name: 'homeNum',
      desc: '',
      args: [],
    );
  }

  /// `Block`
  String get homeBlock {
    return Intl.message(
      'Block',
      name: 'homeBlock',
      desc: '',
      args: [],
    );
  }

  /// `Flat`
  String get kv {
    return Intl.message(
      'Flat',
      name: 'kv',
      desc: '',
      args: [],
    );
  }

  /// `Address for expats`
  String get adressExpats {
    return Intl.message(
      'Address for expats',
      name: 'adressExpats',
      desc: '',
      args: [],
    );
  }

  /// `Address in Kazakh`
  String get adressKZ {
    return Intl.message(
      'Address in Kazakh',
      name: 'adressKZ',
      desc: '',
      args: [],
    );
  }

  /// `Address in English`
  String get adressENG {
    return Intl.message(
      'Address in English',
      name: 'adressENG',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get mark {
    return Intl.message(
      'Notes',
      name: 'mark',
      desc: '',
      args: [],
    );
  }

  /// `Field`
  String get field {
    return Intl.message(
      'Field',
      name: 'field',
      desc: '',
      args: [],
    );
  }

  /// `Not filled`
  String get notFilled {
    return Intl.message(
      'Not filled',
      name: 'notFilled',
      desc: '',
      args: [],
    );
  }

  /// `Not Selected`
  String get notSelected {
    return Intl.message(
      'Not Selected',
      name: 'notSelected',
      desc: '',
      args: [],
    );
  }

  /// `Сan't be before`
  String get notCannotBeEarlier {
    return Intl.message(
      'Сan\'t be before',
      name: 'notCannotBeEarlier',
      desc: '',
      args: [],
    );
  }

  /// `Message Type`
  String get messageType {
    return Intl.message(
      'Message Type',
      name: 'messageType',
      desc: '',
      args: [],
    );
  }

  /// `Topic`
  String get topic {
    return Intl.message(
      'Topic',
      name: 'topic',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get text {
    return Intl.message(
      'Text',
      name: 'text',
      desc: '',
      args: [],
    );
  }

  /// `Сamera`
  String get camera {
    return Intl.message(
      'Сamera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get photo {
    return Intl.message(
      'Photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Document`
  String get document {
    return Intl.message(
      'Document',
      name: 'document',
      desc: '',
      args: [],
    );
  }

  /// `Attachments`
  String get attachments {
    return Intl.message(
      'Attachments',
      name: 'attachments',
      desc: '',
      args: [],
    );
  }

  /// `Спасибо. Ваше сообщение было успешно отправлено в соответствующую службу и будут приняты соответствующие меры по решению данного вопроса.`
  String get sendMessageSnackBarSuccessText {
    return Intl.message(
      'Спасибо. Ваше сообщение было успешно отправлено в соответствующую службу и будут приняты соответствующие меры по решению данного вопроса.',
      name: 'sendMessageSnackBarSuccessText',
      desc: '',
      args: [],
    );
  }

  /// `Не удалось отправить сообщение.`
  String get sendMessageSnackBarErrorText {
    return Intl.message(
      'Не удалось отправить сообщение.',
      name: 'sendMessageSnackBarErrorText',
      desc: '',
      args: [],
    );
  }

  /// `City of residence`
  String get cityOfResidence {
    return Intl.message(
      'City of residence',
      name: 'cityOfResidence',
      desc: '',
      args: [],
    );
  }

  /// `Last Name latin`
  String get lastNameLatin {
    return Intl.message(
      'Last Name latin',
      name: 'lastNameLatin',
      desc: '',
      args: [],
    );
  }

  /// `Middle Name latin`
  String get middleNameLatin {
    return Intl.message(
      'Middle Name latin',
      name: 'middleNameLatin',
      desc: '',
      args: [],
    );
  }

  /// `First Name latin`
  String get personNameLatin {
    return Intl.message(
      'First Name latin',
      name: 'personNameLatin',
      desc: '',
      args: [],
    );
  }

  /// `Application for changing personal data`
  String get personalDataRequest {
    return Intl.message(
      'Application for changing personal data',
      name: 'personalDataRequest',
      desc: '',
      args: [],
    );
  }

  /// `The date of issue cannot be later than the expiration date.`
  String get issueDateAfterExpiredDate {
    return Intl.message(
      'The date of issue cannot be later than the expiration date.',
      name: 'issueDateAfterExpiredDate',
      desc: '',
      args: [],
    );
  }

  /// `Request history`
  String get historyRequests {
    return Intl.message(
      'Request history',
      name: 'historyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Name of the educational institution`
  String get educationSchool {
    return Intl.message(
      'Name of the educational institution',
      name: 'educationSchool',
      desc: '',
      args: [],
    );
  }

  /// `Type of education`
  String get educationType {
    return Intl.message(
      'Type of education',
      name: 'educationType',
      desc: '',
      args: [],
    );
  }

  /// `Diploma, series, number`
  String get educationDiplomaNumber {
    return Intl.message(
      'Diploma, series, number',
      name: 'educationDiplomaNumber',
      desc: '',
      args: [],
    );
  }

  /// `Faculty or department`
  String get educationFaculty {
    return Intl.message(
      'Faculty or department',
      name: 'educationFaculty',
      desc: '',
      args: [],
    );
  }

  /// `What qualifications did (-a) receive as a result of graduation`
  String get educationQualification {
    return Intl.message(
      'What qualifications did (-a) receive as a result of graduation',
      name: 'educationQualification',
      desc: '',
      args: [],
    );
  }

  /// `Form of study`
  String get educationFormStudy {
    return Intl.message(
      'Form of study',
      name: 'educationFormStudy',
      desc: '',
      args: [],
    );
  }

  /// `Specialization`
  String get educationSpecialization {
    return Intl.message(
      'Specialization',
      name: 'educationSpecialization',
      desc: '',
      args: [],
    );
  }

  /// `Year of admission`
  String get educationStartYear {
    return Intl.message(
      'Year of admission',
      name: 'educationStartYear',
      desc: '',
      args: [],
    );
  }

  /// `Graduation or leaving year`
  String get educationEndYear {
    return Intl.message(
      'Graduation or leaving year',
      name: 'educationEndYear',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get personContact {
    return Intl.message(
      'Contacts',
      name: 'personContact',
      desc: '',
      args: [],
    );
  }

  /// `Contact Value`
  String get personContactContactValue {
    return Intl.message(
      'Contact Value',
      name: 'personContactContactValue',
      desc: '',
      args: [],
    );
  }

  /// `Contact type`
  String get personContactPhoneType {
    return Intl.message(
      'Contact type',
      name: 'personContactPhoneType',
      desc: '',
      args: [],
    );
  }

  /// `Start date`
  String get personContactStartDate {
    return Intl.message(
      'Start date',
      name: 'personContactStartDate',
      desc: '',
      args: [],
    );
  }

  /// `End date`
  String get personContactEndDate {
    return Intl.message(
      'End date',
      name: 'personContactEndDate',
      desc: '',
      args: [],
    );
  }

  /// `The start date cannot be later than the end date`
  String get personContactStartAfterEndDate {
    return Intl.message(
      'The start date cannot be later than the end date',
      name: 'personContactStartAfterEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Location of institution, enterprise`
  String get experienceLocation {
    return Intl.message(
      'Location of institution, enterprise',
      name: 'experienceLocation',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get experienceCompany {
    return Intl.message(
      'Company',
      name: 'experienceCompany',
      desc: '',
      args: [],
    );
  }

  /// `Job`
  String get experienceJob {
    return Intl.message(
      'Job',
      name: 'experienceJob',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get experienceStartDate {
    return Intl.message(
      'Start Date',
      name: 'experienceStartDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get experienceEndDate {
    return Intl.message(
      'End Date',
      name: 'experienceEndDate',
      desc: '',
      args: [],
    );
  }

  /// `The start date cannot be later than the end date`
  String get experienceStartAfterEndDate {
    return Intl.message(
      'The start date cannot be later than the end date',
      name: 'experienceStartAfterEndDate',
      desc: '',
      args: [],
    );
  }

  /// `The start date cannot be later than the admission date`
  String get experienceStartAfterHireDate {
    return Intl.message(
      'The start date cannot be later than the admission date',
      name: 'experienceStartAfterHireDate',
      desc: '',
      args: [],
    );
  }

  /// `The end date cannot be later than the acceptance date`
  String get experienceEndAfterHireDate {
    return Intl.message(
      'The end date cannot be later than the acceptance date',
      name: 'experienceEndAfterHireDate',
      desc: '',
      args: [],
    );
  }

  /// `Person qualification`
  String get qualification {
    return Intl.message(
      'Person qualification',
      name: 'qualification',
      desc: '',
      args: [],
    );
  }

  /// `Institution name`
  String get qualificationEducationalInstitutionName {
    return Intl.message(
      'Institution name',
      name: 'qualificationEducationalInstitutionName',
      desc: '',
      args: [],
    );
  }

  /// `Document number`
  String get qualificationDiploma {
    return Intl.message(
      'Document number',
      name: 'qualificationDiploma',
      desc: '',
      args: [],
    );
  }

  /// `Document date`
  String get qualificationIssuedDate {
    return Intl.message(
      'Document date',
      name: 'qualificationIssuedDate',
      desc: '',
      args: [],
    );
  }

  /// `Qualification`
  String get qualificationQualification {
    return Intl.message(
      'Qualification',
      name: 'qualificationQualification',
      desc: '',
      args: [],
    );
  }

  /// `Speciality`
  String get qualificationProfession {
    return Intl.message(
      'Speciality',
      name: 'qualificationProfession',
      desc: '',
      args: [],
    );
  }

  /// `Document type`
  String get educationDocumentType {
    return Intl.message(
      'Document type',
      name: 'educationDocumentType',
      desc: '',
      args: [],
    );
  }

  /// `Expiry date`
  String get educationExpiryDate {
    return Intl.message(
      'Expiry date',
      name: 'educationExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Course name`
  String get educationCourseName {
    return Intl.message(
      'Course name',
      name: 'educationCourseName',
      desc: '',
      args: [],
    );
  }

  /// `Awards and scientific works`
  String get awardsDegrees {
    return Intl.message(
      'Awards and scientific works',
      name: 'awardsDegrees',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get awardsDegreesType {
    return Intl.message(
      'Type',
      name: 'awardsDegreesType',
      desc: '',
      args: [],
    );
  }

  /// `Kind`
  String get awardsDegreesKind {
    return Intl.message(
      'Kind',
      name: 'awardsDegreesKind',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get awardsDegreesDescription {
    return Intl.message(
      'Notes',
      name: 'awardsDegreesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Disability request`
  String get disability {
    return Intl.message(
      'Disability request',
      name: 'disability',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Has disability`
  String get disabilityHasDisability {
    return Intl.message(
      'Has disability',
      name: 'disabilityHasDisability',
      desc: '',
      args: [],
    );
  }

  /// `Group disability`
  String get disabilityDisabilityType {
    return Intl.message(
      'Group disability',
      name: 'disabilityDisabilityType',
      desc: '',
      args: [],
    );
  }

  /// `Training calendar`
  String get trainingCalendar {
    return Intl.message(
      'Training calendar',
      name: 'trainingCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Course schedule`
  String get courseSchedule {
    return Intl.message(
      'Course schedule',
      name: 'courseSchedule',
      desc: '',
      args: [],
    );
  }

  /// `My study plan`
  String get myStudyPlan {
    return Intl.message(
      'My study plan',
      name: 'myStudyPlan',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Leave feedback`
  String get leaveFeedback {
    return Intl.message(
      'Leave feedback',
      name: 'leaveFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `Course`
  String get course {
    return Intl.message(
      'Course',
      name: 'course',
      desc: '',
      args: [],
    );
  }

  /// `Places left`
  String get placesLeft {
    return Intl.message(
      'Places left',
      name: 'placesLeft',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get requestedCourseSchedule {
    return Intl.message(
      'Request',
      name: 'requestedCourseSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Trainer`
  String get trainer {
    return Intl.message(
      'Trainer',
      name: 'trainer',
      desc: '',
      args: [],
    );
  }

  /// `My work contracts`
  String get myWorkContracts {
    return Intl.message(
      'My work contracts',
      name: 'myWorkContracts',
      desc: '',
      args: [],
    );
  }

  /// `Type of training`
  String get typeOfTraining {
    return Intl.message(
      'Type of training',
      name: 'typeOfTraining',
      desc: '',
      args: [],
    );
  }

  /// `Contract number`
  String get contractNumber {
    return Intl.message(
      'Contract number',
      name: 'contractNumber',
      desc: '',
      args: [],
    );
  }

  /// `Contract date`
  String get contractDate {
    return Intl.message(
      'Contract date',
      name: 'contractDate',
      desc: '',
      args: [],
    );
  }

  /// `Contract amount (tenge)`
  String get contractAmount {
    return Intl.message(
      'Contract amount (tenge)',
      name: 'contractAmount',
      desc: '',
      args: [],
    );
  }

  /// `Balance (tenge)`
  String get balance {
    return Intl.message(
      'Balance (tenge)',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Working time`
  String get workingTime {
    return Intl.message(
      'Working time',
      name: 'workingTime',
      desc: '',
      args: [],
    );
  }

  /// `Military form request`
  String get military {
    return Intl.message(
      'Military form request',
      name: 'military',
      desc: '',
      args: [],
    );
  }

  /// `Relation`
  String get militaryAttitudeToMilitary {
    return Intl.message(
      'Relation',
      name: 'militaryAttitudeToMilitary',
      desc: '',
      args: [],
    );
  }

  /// `Document #`
  String get militaryDocumentNumber {
    return Intl.message(
      'Document #',
      name: 'militaryDocumentNumber',
      desc: '',
      args: [],
    );
  }

  /// `Military service type`
  String get militaryMilitaryType {
    return Intl.message(
      'Military service type',
      name: 'militaryMilitaryType',
      desc: '',
      args: [],
    );
  }

  /// `Military Sustainability`
  String get militarySuitabilityToMilitary {
    return Intl.message(
      'Military Sustainability',
      name: 'militarySuitabilityToMilitary',
      desc: '',
      args: [],
    );
  }

  /// `UDO`
  String get militaryUdo {
    return Intl.message(
      'UDO',
      name: 'militaryUdo',
      desc: '',
      args: [],
    );
  }

  /// `Military rank`
  String get militaryMilitaryRank {
    return Intl.message(
      'Military rank',
      name: 'militaryMilitaryRank',
      desc: '',
      args: [],
    );
  }

  /// `Type of officers`
  String get militaryOfficerType {
    return Intl.message(
      'Type of officers',
      name: 'militaryOfficerType',
      desc: '',
      args: [],
    );
  }

  /// `Military occupational specialty`
  String get militarySpecialization {
    return Intl.message(
      'Military occupational specialty',
      name: 'militarySpecialization',
      desc: '',
      args: [],
    );
  }

  /// `Type of military document`
  String get militaryMilitaryDocumentType {
    return Intl.message(
      'Type of military document',
      name: 'militaryMilitaryDocumentType',
      desc: '',
      args: [],
    );
  }

  /// `Military profile`
  String get militaryTroopsStructure {
    return Intl.message(
      'Military profile',
      name: 'militaryTroopsStructure',
      desc: '',
      args: [],
    );
  }

  /// `Дата с (прохождение службы)`
  String get militaryDateFrom {
    return Intl.message(
      'Дата с (прохождение службы)',
      name: 'militaryDateFrom',
      desc: '',
      args: [],
    );
  }

  /// `Дата по (прохождение службы)`
  String get militaryDateTo {
    return Intl.message(
      'Дата по (прохождение службы)',
      name: 'militaryDateTo',
      desc: '',
      args: [],
    );
  }

  /// `Information about relatives`
  String get beneficiary {
    return Intl.message(
      'Information about relatives',
      name: 'beneficiary',
      desc: '',
      args: [],
    );
  }

  /// `Employee name`
  String get beneficiaryFio {
    return Intl.message(
      'Employee name',
      name: 'beneficiaryFio',
      desc: '',
      args: [],
    );
  }

  /// `Relatives, who works in KAZ Minerals`
  String get beneficiaryWorkKazmin {
    return Intl.message(
      'Relatives, who works in KAZ Minerals',
      name: 'beneficiaryWorkKazmin',
      desc: '',
      args: [],
    );
  }

  /// `Family members`
  String get familyMember {
    return Intl.message(
      'Family members',
      name: 'familyMember',
      desc: '',
      args: [],
    );
  }

  /// `Last Name latin`
  String get beneficiaryLastNameLatin {
    return Intl.message(
      'Last Name latin',
      name: 'beneficiaryLastNameLatin',
      desc: '',
      args: [],
    );
  }

  /// `First Name latin`
  String get beneficiaryFirstNameLatin {
    return Intl.message(
      'First Name latin',
      name: 'beneficiaryFirstNameLatin',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get beneficiaryBirthDate {
    return Intl.message(
      'Date of birth',
      name: 'beneficiaryBirthDate',
      desc: '',
      args: [],
    );
  }

  /// `Address Type`
  String get beneficiaryAddressType {
    return Intl.message(
      'Address Type',
      name: 'beneficiaryAddressType',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get beneficiaryPostalCode {
    return Intl.message(
      'Postal Code',
      name: 'beneficiaryPostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get beneficiaryCountry {
    return Intl.message(
      'Country',
      name: 'beneficiaryCountry',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get beneficiaryAddressKATOCode {
    return Intl.message(
      '',
      name: 'beneficiaryAddressKATOCode',
      desc: '',
      args: [],
    );
  }

  /// `Street Type`
  String get beneficiaryStreetType {
    return Intl.message(
      'Street Type',
      name: 'beneficiaryStreetType',
      desc: '',
      args: [],
    );
  }

  /// `Street Name`
  String get beneficiaryStreetName {
    return Intl.message(
      'Street Name',
      name: 'beneficiaryStreetName',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get beneficiaryBuilding {
    return Intl.message(
      'Building',
      name: 'beneficiaryBuilding',
      desc: '',
      args: [],
    );
  }

  /// `Block`
  String get beneficiaryBlock {
    return Intl.message(
      'Block',
      name: 'beneficiaryBlock',
      desc: '',
      args: [],
    );
  }

  /// `Flat`
  String get beneficiaryFlat {
    return Intl.message(
      'Flat',
      name: 'beneficiaryFlat',
      desc: '',
      args: [],
    );
  }

  /// `Address For Expats`
  String get beneficiaryAddressForExpats {
    return Intl.message(
      'Address For Expats',
      name: 'beneficiaryAddressForExpats',
      desc: '',
      args: [],
    );
  }

  /// `Additional Contact`
  String get beneficiaryAdditionalContact {
    return Intl.message(
      'Additional Contact',
      name: 'beneficiaryAdditionalContact',
      desc: '',
      args: [],
    );
  }

  /// `Relationship Type`
  String get beneficiaryRelationshipType {
    return Intl.message(
      'Relationship Type',
      name: 'beneficiaryRelationshipType',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get beneficiaryLastName {
    return Intl.message(
      'Last name',
      name: 'beneficiaryLastName',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get beneficiaryFirstName {
    return Intl.message(
      'First name',
      name: 'beneficiaryFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Middle name`
  String get beneficiaryMiddleName {
    return Intl.message(
      'Middle name',
      name: 'beneficiaryMiddleName',
      desc: '',
      args: [],
    );
  }

  /// `Place of work, position`
  String get beneficiaryWorkLocation {
    return Intl.message(
      'Place of work, position',
      name: 'beneficiaryWorkLocation',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get lk {
    return Intl.message(
      'My Profile',
      name: 'lk',
      desc: '',
      args: [],
    );
  }

  /// `Personal data`
  String get lkMyData {
    return Intl.message(
      'Personal data',
      name: 'lkMyData',
      desc: '',
      args: [],
    );
  }

  /// `Enter a search text. Minimum 4 letters.`
  String get searchHint {
    return Intl.message(
      'Enter a search text. Minimum 4 letters.',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Overtime/Override Request`
  String get rvd {
    return Intl.message(
      'Overtime/Override Request',
      name: 'rvd',
      desc: '',
      args: [],
    );
  }

  /// `Purpose`
  String get absPurpose {
    return Intl.message(
      'Purpose',
      name: 'absPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Time of starting`
  String get timeOfStarting {
    return Intl.message(
      'Time of starting',
      name: 'timeOfStarting',
      desc: '',
      args: [],
    );
  }

  /// `Time of finishing`
  String get timeOfFinishing {
    return Intl.message(
      'Time of finishing',
      name: 'timeOfFinishing',
      desc: '',
      args: [],
    );
  }

  /// `Shift`
  String get shift {
    return Intl.message(
      'Shift',
      name: 'shift',
      desc: '',
      args: [],
    );
  }

  /// `Shift code`
  String get shiftCode {
    return Intl.message(
      'Shift code',
      name: 'shiftCode',
      desc: '',
      args: [],
    );
  }

  /// `Cancel all hours of the day`
  String get discardDayHours {
    return Intl.message(
      'Cancel all hours of the day',
      name: 'discardDayHours',
      desc: '',
      args: [],
    );
  }

  /// `Compensation payment (without providing rest days)`
  String get compensationPayment {
    return Intl.message(
      'Compensation payment (without providing rest days)',
      name: 'compensationPayment',
      desc: '',
      args: [],
    );
  }

  /// `Providing rest days`
  String get vacationDay {
    return Intl.message(
      'Providing rest days',
      name: 'vacationDay',
      desc: '',
      args: [],
    );
  }

  /// `Remote`
  String get remote {
    return Intl.message(
      'Remote',
      name: 'remote',
      desc: '',
      args: [],
    );
  }

  /// `Filing an application is prohibited for workers engaged in rotational work`
  String get vahtaCheckAlert {
    return Intl.message(
      'Filing an application is prohibited for workers engaged in rotational work',
      name: 'vahtaCheckAlert',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `First you need to save the request`
  String get reportNeedRequestID {
    return Intl.message(
      'First you need to save the request',
      name: 'reportNeedRequestID',
      desc: '',
      args: [],
    );
  }

  /// `Set date and time`
  String get setDateAndTime {
    return Intl.message(
      'Set date and time',
      name: 'setDateAndTime',
      desc: '',
      args: [],
    );
  }

  /// `Competence assessment`
  String get competenceAssessment {
    return Intl.message(
      'Competence assessment',
      name: 'competenceAssessment',
      desc: '',
      args: [],
    );
  }

  /// `Purpose`
  String get purposeText {
    return Intl.message(
      'Purpose',
      name: 'purposeText',
      desc: '',
      args: [],
    );
  }

  /// `Orphan education`
  String get childUnder {
    return Intl.message(
      'Orphan education',
      name: 'childUnder',
      desc: '',
      args: [],
    );
  }

  /// `Start assessement`
  String get startCompetence {
    return Intl.message(
      'Start assessement',
      name: 'startCompetence',
      desc: '',
      args: [],
    );
  }

  /// `Competence`
  String get competence {
    return Intl.message(
      'Competence',
      name: 'competence',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextCompetence {
    return Intl.message(
      'Next',
      name: 'nextCompetence',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get resultCompetence {
    return Intl.message(
      'Result',
      name: 'resultCompetence',
      desc: '',
      args: [],
    );
  }

  /// `Employee`
  String get employee {
    return Intl.message(
      'Employee',
      name: 'employee',
      desc: '',
      args: [],
    );
  }

  /// `Are you raising a disabled child under 18 without a father/mother?`
  String get childUnderTo18 {
    return Intl.message(
      'Are you raising a disabled child under 18 without a father/mother?',
      name: 'childUnderTo18',
      desc: '',
      args: [],
    );
  }

  /// `Are you raising a child under 14 without a father/mother?`
  String get childUnderTo14 {
    return Intl.message(
      'Are you raising a child under 14 without a father/mother?',
      name: 'childUnderTo14',
      desc: '',
      args: [],
    );
  }

  /// `Other information about the employee`
  String get personExt {
    return Intl.message(
      'Other information about the employee',
      name: 'personExt',
      desc: '',
      args: [],
    );
  }

  /// `Indicators`
  String get indicators {
    return Intl.message(
      'Indicators',
      name: 'indicators',
      desc: '',
      args: [],
    );
  }

  /// `Indicator`
  String get indicator {
    return Intl.message(
      'Indicator',
      name: 'indicator',
      desc: '',
      args: [],
    );
  }

  /// `Manager`
  String get manager {
    return Intl.message(
      'Manager',
      name: 'manager',
      desc: '',
      args: [],
    );
  }

  /// `Superior manager`
  String get superiorManager {
    return Intl.message(
      'Superior manager',
      name: 'superiorManager',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Complete assessment`
  String get completedComptence {
    return Intl.message(
      'Complete assessment',
      name: 'completedComptence',
      desc: '',
      args: [],
    );
  }

  /// `Assessment session`
  String get assessmentSession {
    return Intl.message(
      'Assessment session',
      name: 'assessmentSession',
      desc: '',
      args: [],
    );
  }

  /// `Total,%`
  String get totalPercent {
    return Intl.message(
      'Total,%',
      name: 'totalPercent',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get hrRole {
    return Intl.message(
      'Role',
      name: 'hrRole',
      desc: '',
      args: [],
    );
  }

  /// `Date of creation`
  String get createTime {
    return Intl.message(
      'Date of creation',
      name: 'createTime',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date`
  String get endTime {
    return Intl.message(
      'Expiration date',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Solution`
  String get outcome {
    return Intl.message(
      'Solution',
      name: 'outcome',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get noData {
    return Intl.message(
      'No data',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Change of paid leave dates`
  String get changeAbsenceTitle {
    return Intl.message(
      'Change of paid leave dates',
      name: 'changeAbsenceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Absence`
  String get changeAbsenceVacation {
    return Intl.message(
      'Absence',
      name: 'changeAbsenceVacation',
      desc: '',
      args: [],
    );
  }

  /// `The period of annual labor leave according to the approved schedule Date from`
  String get changeAbsenceScheduleStartDate {
    return Intl.message(
      'The period of annual labor leave according to the approved schedule Date from',
      name: 'changeAbsenceScheduleStartDate',
      desc: '',
      args: [],
    );
  }

  /// `The period of annual labor leave according to the approved schedule Date to`
  String get changeAbsenceScheduleEndDate {
    return Intl.message(
      'The period of annual labor leave according to the approved schedule Date to',
      name: 'changeAbsenceScheduleEndDate',
      desc: '',
      args: [],
    );
  }

  /// `New period of annual leave Date from`
  String get changeAbsenceNewStartDate {
    return Intl.message(
      'New period of annual leave Date from',
      name: 'changeAbsenceNewStartDate',
      desc: '',
      args: [],
    );
  }

  /// `New period of annual leave Date to`
  String get changeAbsenceNewEndDate {
    return Intl.message(
      'New period of annual leave Date to',
      name: 'changeAbsenceNewEndDate',
      desc: '',
      args: [],
    );
  }

  /// `The period of working days of the watch for the requested vacation Date from`
  String get changeAbsencePeriodStartDate {
    return Intl.message(
      'The period of working days of the watch for the requested vacation Date from',
      name: 'changeAbsencePeriodStartDate',
      desc: '',
      args: [],
    );
  }

  /// `The period of working days of the watch for the requested vacation Date to`
  String get changeAbsencePeriodEndDate {
    return Intl.message(
      'The period of working days of the watch for the requested vacation Date to',
      name: 'changeAbsencePeriodEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Justification`
  String get purpose {
    return Intl.message(
      'Justification',
      name: 'purpose',
      desc: '',
      args: [],
    );
  }

  /// `Absence type`
  String get changeAbsenceVacationType {
    return Intl.message(
      'Absence type',
      name: 'changeAbsenceVacationType',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Familiarized`
  String get familiarization {
    return Intl.message(
      'Familiarized',
      name: 'familiarization',
      desc: '',
      args: [],
    );
  }

  /// `To do nothing`
  String get doNothingAction {
    return Intl.message(
      'To do nothing',
      name: 'doNothingAction',
      desc: '',
      args: [],
    );
  }

  /// `Create request`
  String get materialAssistanceCreateRequest {
    return Intl.message(
      'Create request',
      name: 'materialAssistanceCreateRequest',
      desc: '',
      args: [],
    );
  }

  /// `My requests`
  String get materialAssistanceMyRequests {
    return Intl.message(
      'My requests',
      name: 'materialAssistanceMyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get request {
    return Intl.message(
      'Request',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `Aid type`
  String get materialAssistanceAidType {
    return Intl.message(
      'Aid type',
      name: 'materialAssistanceAidType',
      desc: '',
      args: [],
    );
  }

  /// `For new employees`
  String get newEmployeesTitle {
    return Intl.message(
      'For new employees',
      name: 'newEmployeesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recall from paid leave`
  String get absenceForRecall {
    return Intl.message(
      'Recall from paid leave',
      name: 'absenceForRecall',
      desc: '',
      args: [],
    );
  }

  /// `Current adaptation period`
  String get currentAdaptationPlanPeriod {
    return Intl.message(
      'Current adaptation period',
      name: 'currentAdaptationPlanPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Other periods`
  String get otherAdaptationPeriods {
    return Intl.message(
      'Other periods',
      name: 'otherAdaptationPeriods',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `My tasks`
  String get newEmployeesPageMyTasks {
    return Intl.message(
      'My tasks',
      name: 'newEmployeesPageMyTasks',
      desc: '',
      args: [],
    );
  }

  /// `Documents for review`
  String get newEmployeesIntroductoryDocuments {
    return Intl.message(
      'Documents for review',
      name: 'newEmployeesIntroductoryDocuments',
      desc: '',
      args: [],
    );
  }

  /// `My adaptation team`
  String get newEmployeesMyAdaptationTeam {
    return Intl.message(
      'My adaptation team',
      name: 'newEmployeesMyAdaptationTeam',
      desc: '',
      args: [],
    );
  }

  /// `Required Courses`
  String get newEmployeesCompulsoryCourses {
    return Intl.message(
      'Required Courses',
      name: 'newEmployeesCompulsoryCourses',
      desc: '',
      args: [],
    );
  }

  /// `Tasks for the adaptation period`
  String get newEmployeesAdaptationTasks {
    return Intl.message(
      'Tasks for the adaptation period',
      name: 'newEmployeesAdaptationTasks',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Task card`
  String get newEmployeesTaskCard {
    return Intl.message(
      'Task card',
      name: 'newEmployeesTaskCard',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task1 {
    return Intl.message(
      'Task',
      name: 'task1',
      desc: '',
      args: [],
    );
  }

  /// `Expected results`
  String get newEmployeesExpectedResults {
    return Intl.message(
      'Expected results',
      name: 'newEmployeesExpectedResults',
      desc: '',
      args: [],
    );
  }

  /// `Achieved results`
  String get newEmployeesResultsAchieved {
    return Intl.message(
      'Achieved results',
      name: 'newEmployeesResultsAchieved',
      desc: '',
      args: [],
    );
  }

  /// `To review`
  String get newEmployeesIntroductaryDocuments {
    return Intl.message(
      'To review',
      name: 'newEmployeesIntroductaryDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Acquaintance with the document`
  String get newEmployeesAcquaintanceWithTheDocument {
    return Intl.message(
      'Acquaintance with the document',
      name: 'newEmployeesAcquaintanceWithTheDocument',
      desc: '',
      args: [],
    );
  }

  /// `Mark a document as familiar?`
  String get newEmployeesMarkDocument {
    return Intl.message(
      'Mark a document as familiar?',
      name: 'newEmployeesMarkDocument',
      desc: '',
      args: [],
    );
  }

  /// `Mark as familiar`
  String get newEmployeesMarkAsFamiliar {
    return Intl.message(
      'Mark as familiar',
      name: 'newEmployeesMarkAsFamiliar',
      desc: '',
      args: [],
    );
  }

  /// `Reviewed`
  String get newEmployeesFamiliarized {
    return Intl.message(
      'Reviewed',
      name: 'newEmployeesFamiliarized',
      desc: '',
      args: [],
    );
  }

  /// `Required courses according to course matrix`
  String get newEmployeesRequiredCoursesAccordingToCourseMatrix {
    return Intl.message(
      'Required courses according to course matrix',
      name: 'newEmployeesRequiredCoursesAccordingToCourseMatrix',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Go to my learning plan`
  String get newEmployeesGotoLearningPlan {
    return Intl.message(
      'Go to my learning plan',
      name: 'newEmployeesGotoLearningPlan',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fio {
    return Intl.message(
      'Full Name',
      name: 'fio',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get position {
    return Intl.message(
      'Position',
      name: 'position',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone1 {
    return Intl.message(
      'Phone',
      name: 'phone1',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Citizenship`
  String get citizenship {
    return Intl.message(
      'Citizenship',
      name: 'citizenship',
      desc: '',
      args: [],
    );
  }

  /// `Employment date`
  String get employmentDate {
    return Intl.message(
      'Employment date',
      name: 'employmentDate',
      desc: '',
      args: [],
    );
  }

  /// `Open assessment`
  String get viewCompetance {
    return Intl.message(
      'Open assessment',
      name: 'viewCompetance',
      desc: '',
      args: [],
    );
  }

  /// `Display salary?`
  String get displaySalary {
    return Intl.message(
      'Display salary?',
      name: 'displaySalary',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completedComptenceTab {
    return Intl.message(
      'Completed',
      name: 'completedComptenceTab',
      desc: '',
      args: [],
    );
  }

  /// `Number of copies`
  String get numberOfCopies {
    return Intl.message(
      'Number of copies',
      name: 'numberOfCopies',
      desc: '',
      args: [],
    );
  }

  /// `Reference type`
  String get referenceType {
    return Intl.message(
      'Reference type',
      name: 'referenceType',
      desc: '',
      args: [],
    );
  }

  /// `How to obtain`
  String get obtainType {
    return Intl.message(
      'How to obtain',
      name: 'obtainType',
      desc: '',
      args: [],
    );
  }

  /// `View competance form`
  String get viewCompetanceForm {
    return Intl.message(
      'View competance form',
      name: 'viewCompetanceForm',
      desc: '',
      args: [],
    );
  }

  /// `Fill competance form`
  String get fillCompetanceForm {
    return Intl.message(
      'Fill competance form',
      name: 'fillCompetanceForm',
      desc: '',
      args: [],
    );
  }

  /// `Filling instructions`
  String get fillingInstructions {
    return Intl.message(
      'Filling instructions',
      name: 'fillingInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Required level`
  String get requiredLevel {
    return Intl.message(
      'Required level',
      name: 'requiredLevel',
      desc: '',
      args: [],
    );
  }

  /// `Requires development`
  String get requiresDevelopment {
    return Intl.message(
      'Requires development',
      name: 'requiresDevelopment',
      desc: '',
      args: [],
    );
  }

  /// `Competencyies`
  String get competences {
    return Intl.message(
      'Competencyies',
      name: 'competences',
      desc: '',
      args: [],
    );
  }

  /// `Complete assessment`
  String get completeAssessment {
    return Intl.message(
      'Complete assessment',
      name: 'completeAssessment',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownError {
    return Intl.message(
      'Unknown error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Competency assessment completed`
  String get competencyAssessmentCompleted {
    return Intl.message(
      'Competency assessment completed',
      name: 'competencyAssessmentCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Evaluation period has expired. Contact CBA Administrator`
  String get periodExpiredMsg {
    return Intl.message(
      'Evaluation period has expired. Contact CBA Administrator',
      name: 'periodExpiredMsg',
      desc: '',
      args: [],
    );
  }

  /// `Show certificate`
  String get showCertificate {
    return Intl.message(
      'Show certificate',
      name: 'showCertificate',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully enrolled`
  String get successfullyEnrolled {
    return Intl.message(
      'You have successfully enrolled',
      name: 'successfullyEnrolled',
      desc: '',
      args: [],
    );
  }

  /// `There are no documents to review`
  String get thereAreNoDocumentsToReview {
    return Intl.message(
      'There are no documents to review',
      name: 'thereAreNoDocumentsToReview',
      desc: '',
      args: [],
    );
  }

  /// `There are no familiar documents`
  String get thereAreNoFamiliarDocuments {
    return Intl.message(
      'There are no familiar documents',
      name: 'thereAreNoFamiliarDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Not agreed`
  String get notAgreed {
    return Intl.message(
      'Not agreed',
      name: 'notAgreed',
      desc: '',
      args: [],
    );
  }

  /// `Agreed`
  String get alreadyAgreed {
    return Intl.message(
      'Agreed',
      name: 'alreadyAgreed',
      desc: '',
      args: [],
    );
  }

  /// `To be agreed`
  String get tobeAgreed {
    return Intl.message(
      'To be agreed',
      name: 'tobeAgreed',
      desc: '',
      args: [],
    );
  }

  /// `Новый период не равен старому`
  String get absenceDaysIncorrect {
    return Intl.message(
      'Новый период не равен старому',
      name: 'absenceDaysIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get absenceDays {
    return Intl.message(
      'Days',
      name: 'absenceDays',
      desc: '',
      args: [],
    );
  }

  /// `Balance at the start date`
  String get absenceBalance {
    return Intl.message(
      'Balance at the start date',
      name: 'absenceBalance',
      desc: '',
      args: [],
    );
  }

  /// `The number of days in the application exceeds the balance of the vacation balance`
  String get absenceBalanceError {
    return Intl.message(
      'The number of days in the application exceeds the balance of the vacation balance',
      name: 'absenceBalanceError',
      desc: '',
      args: [],
    );
  }

  /// `The date of the new period of annual leave is not correct`
  String get absenceDateError {
    return Intl.message(
      'The date of the new period of annual leave is not correct',
      name: 'absenceDateError',
      desc: '',
      args: [],
    );
  }

  /// `The period of working days of the watch for the requested vacation is not correct`
  String get absencePeriodError {
    return Intl.message(
      'The period of working days of the watch for the requested vacation is not correct',
      name: 'absencePeriodError',
      desc: '',
      args: [],
    );
  }

  /// `Need to add`
  String get bpmNeedUserWithRole {
    return Intl.message(
      'Need to add',
      name: 'bpmNeedUserWithRole',
      desc: '',
      args: [],
    );
  }

  /// `The number of days in the application exceeds the vacation balance`
  String get absenceDaysBalanceError {
    return Intl.message(
      'The number of days in the application exceeds the vacation balance',
      name: 'absenceDaysBalanceError',
      desc: '',
      args: [],
    );
  }

  /// `There are no records`
  String get paysLipNoRecords {
    return Intl.message(
      'There are no records',
      name: 'paysLipNoRecords',
      desc: '',
      args: [],
    );
  }

  /// `Date of recall from`
  String get dateRecallFrom {
    return Intl.message(
      'Date of recall from',
      name: 'dateRecallFrom',
      desc: '',
      args: [],
    );
  }

  /// `Date of recall to`
  String get dateRecallTo {
    return Intl.message(
      'Date of recall to',
      name: 'dateRecallTo',
      desc: '',
      args: [],
    );
  }

  /// `Provision of leave at other times`
  String get absenseInAnotherTime {
    return Intl.message(
      'Provision of leave at other times',
      name: 'absenseInAnotherTime',
      desc: '',
      args: [],
    );
  }

  /// `Compensation payment`
  String get compensationPay {
    return Intl.message(
      'Compensation payment',
      name: 'compensationPay',
      desc: '',
      args: [],
    );
  }

  /// `Dates of unused part from`
  String get unusedDaysFrom {
    return Intl.message(
      'Dates of unused part from',
      name: 'unusedDaysFrom',
      desc: '',
      args: [],
    );
  }

  /// `Dates of unused part to`
  String get unusedDaysTo {
    return Intl.message(
      'Dates of unused part to',
      name: 'unusedDaysTo',
      desc: '',
      args: [],
    );
  }

  /// ` Would you like to use Touch ID or Face ID in future authentications?`
  String get useBioAuth {
    return Intl.message(
      ' Would you like to use Touch ID or Face ID in future authentications?',
      name: 'useBioAuth',
      desc: '',
      args: [],
    );
  }

  /// `Place your finger to enter the application`
  String get authenticateBio {
    return Intl.message(
      'Place your finger to enter the application',
      name: 'authenticateBio',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint login`
  String get useFinger {
    return Intl.message(
      'Fingerprint login',
      name: 'useFinger',
      desc: '',
      args: [],
    );
  }

  /// `A new version available`
  String get newVersionAvailable {
    return Intl.message(
      'A new version available',
      name: 'newVersionAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Application not found for file type`
  String get noAppToOpen {
    return Intl.message(
      'Application not found for file type',
      name: 'noAppToOpen',
      desc: '',
      args: [],
    );
  }

  /// `File not found`
  String get fileNotFound {
    return Intl.message(
      'File not found',
      name: 'fileNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Not enough permissions to open the file`
  String get permissionDenied {
    return Intl.message(
      'Not enough permissions to open the file',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Request number`
  String get requestNum {
    return Intl.message(
      'Request number',
      name: 'requestNum',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days1 {
    return Intl.message(
      'Days',
      name: 'days1',
      desc: '',
      args: [],
    );
  }

  /// `I undertake to provide the original sheet of temporary disability after closing`
  String get origListText {
    return Intl.message(
      'I undertake to provide the original sheet of temporary disability after closing',
      name: 'origListText',
      desc: '',
      args: [],
    );
  }

  /// `The period of annual labor leave according to the schedule Date from`
  String get periodDateFrom {
    return Intl.message(
      'The period of annual labor leave according to the schedule Date from',
      name: 'periodDateFrom',
      desc: '',
      args: [],
    );
  }

  /// `The period of annual labor leave according to the schedule Date to`
  String get periodDateTo {
    return Intl.message(
      'The period of annual labor leave according to the schedule Date to',
      name: 'periodDateTo',
      desc: '',
      args: [],
    );
  }

  /// `Add to labor leave for the next working year`
  String get joinToNextYearAbsence {
    return Intl.message(
      'Add to labor leave for the next working year',
      name: 'joinToNextYearAbsence',
      desc: '',
      args: [],
    );
  }

  /// `Dates of use of the transferred labor leave Date from`
  String get usedAbsenceDateFrom {
    return Intl.message(
      'Dates of use of the transferred labor leave Date from',
      name: 'usedAbsenceDateFrom',
      desc: '',
      args: [],
    );
  }

  /// `Dates of use of the transferred labor leave Date to`
  String get usedAbsenceDateTo {
    return Intl.message(
      'Dates of use of the transferred labor leave Date to',
      name: 'usedAbsenceDateTo',
      desc: '',
      args: [],
    );
  }

  /// `The period of working days for the requested leave Date from`
  String get periodAbsenceDateFrom {
    return Intl.message(
      'The period of working days for the requested leave Date from',
      name: 'periodAbsenceDateFrom',
      desc: '',
      args: [],
    );
  }

  /// `The period of working days for the requested leave Date to`
  String get periodAbsenceDateTo {
    return Intl.message(
      'The period of working days for the requested leave Date to',
      name: 'periodAbsenceDateTo',
      desc: '',
      args: [],
    );
  }

  /// `Request for training on a day off`
  String get ovd {
    return Intl.message(
      'Request for training on a day off',
      name: 'ovd',
      desc: '',
      args: [],
    );
  }

  /// `Course and Rationale`
  String get justify {
    return Intl.message(
      'Course and Rationale',
      name: 'justify',
      desc: '',
      args: [],
    );
  }

  /// `Number of hours`
  String get hours {
    return Intl.message(
      'Number of hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Amount of days`
  String get daysAmount {
    return Intl.message(
      'Amount of days',
      name: 'daysAmount',
      desc: '',
      args: [],
    );
  }

  /// `Absence balance`
  String get myVacationAbsenceBalance {
    return Intl.message(
      'Absence balance',
      name: 'myVacationAbsenceBalance',
      desc: '',
      args: [],
    );
  }

  /// `Current absence balance`
  String get myCurrentAbsenceBalance {
    return Intl.message(
      'Current absence balance',
      name: 'myCurrentAbsenceBalance',
      desc: '',
      args: [],
    );
  }

  /// `Balance days`
  String get balanceDay {
    return Intl.message(
      'Balance days',
      name: 'balanceDay',
      desc: '',
      args: [],
    );
  }

  /// `Additional balance days`
  String get additionalBalanceDay {
    return Intl.message(
      'Additional balance days',
      name: 'additionalBalanceDay',
      desc: '',
      args: [],
    );
  }

  /// `Days left`
  String get leftDay {
    return Intl.message(
      'Days left',
      name: 'leftDay',
      desc: '',
      args: [],
    );
  }

  /// `Extra days left`
  String get extraLeftDay {
    return Intl.message(
      'Extra days left',
      name: 'extraLeftDay',
      desc: '',
      args: [],
    );
  }

  /// `Ecological due days`
  String get ecologicalDueDays {
    return Intl.message(
      'Ecological due days',
      name: 'ecologicalDueDays',
      desc: '',
      args: [],
    );
  }

  /// `Ecological days left`
  String get ecologicalDaysLeft {
    return Intl.message(
      'Ecological days left',
      name: 'ecologicalDaysLeft',
      desc: '',
      args: [],
    );
  }

  /// `Vacancies`
  String get organizationVacancies {
    return Intl.message(
      'Vacancies',
      name: 'organizationVacancies',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Vacancy name`
  String get vacancyName {
    return Intl.message(
      'Vacancy name',
      name: 'vacancyName',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Open vacancies`
  String get openVacancies {
    return Intl.message(
      'Open vacancies',
      name: 'openVacancies',
      desc: '',
      args: [],
    );
  }

  /// `Please note that according to Company Policy, if you refer a candidate, you will not be able to participate in the interview.`
  String get attentionVacancies {
    return Intl.message(
      'Please note that according to Company Policy, if you refer a candidate, you will not be able to participate in the interview.',
      name: 'attentionVacancies',
      desc: '',
      args: [],
    );
  }

  /// `Recommend`
  String get recommend {
    return Intl.message(
      'Recommend',
      name: 'recommend',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Job responsibilities`
  String get jobResponsibilities {
    return Intl.message(
      'Job responsibilities',
      name: 'jobResponsibilities',
      desc: '',
      args: [],
    );
  }

  /// `Mandatory qualifications`
  String get mandatoryQualifications {
    return Intl.message(
      'Mandatory qualifications',
      name: 'mandatoryQualifications',
      desc: '',
      args: [],
    );
  }

  /// `General and additional requirements`
  String get generalRequirement {
    return Intl.message(
      'General and additional requirements',
      name: 'generalRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Desirable requirements and additional comments`
  String get desirableComments {
    return Intl.message(
      'Desirable requirements and additional comments',
      name: 'desirableComments',
      desc: '',
      args: [],
    );
  }

  /// `The vacancy was created on`
  String get createVacancies {
    return Intl.message(
      'The vacancy was created on',
      name: 'createVacancies',
      desc: '',
      args: [],
    );
  }

  /// `Referring employee info`
  String get referringInfo {
    return Intl.message(
      'Referring employee info',
      name: 'referringInfo',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Name`
  String get enterName {
    return Intl.message(
      'Enter Your Name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Corporate Email`
  String get enterEmail {
    return Intl.message(
      'Corporate Email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Candidate's info`
  String get candidateInfo {
    return Intl.message(
      'Candidate\'s info',
      name: 'candidateInfo',
      desc: '',
      args: [],
    );
  }

  /// `Enter Candidate's First Name`
  String get enterCandidateFirstName {
    return Intl.message(
      'Enter Candidate\'s First Name',
      name: 'enterCandidateFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Candidate's Last Name`
  String get enterCandidateLastName {
    return Intl.message(
      'Enter Candidate\'s Last Name',
      name: 'enterCandidateLastName',
      desc: '',
      args: [],
    );
  }

  /// `Years of experience`
  String get experienceYear {
    return Intl.message(
      'Years of experience',
      name: 'experienceYear',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Relations`
  String get relations {
    return Intl.message(
      'Relations',
      name: 'relations',
      desc: '',
      args: [],
    );
  }

  /// `Candidate's education`
  String get candidateEducation {
    return Intl.message(
      'Candidate\'s education',
      name: 'candidateEducation',
      desc: '',
      args: [],
    );
  }

  /// `Candidate's personal evaluation`
  String get candidateEvaluation {
    return Intl.message(
      'Candidate\'s personal evaluation',
      name: 'candidateEvaluation',
      desc: '',
      args: [],
    );
  }

  /// `Attach candidate's resume`
  String get attachResume {
    return Intl.message(
      'Attach candidate\'s resume',
      name: 'attachResume',
      desc: '',
      args: [],
    );
  }

  /// `Main data`
  String get mainData {
    return Intl.message(
      'Main data',
      name: 'mainData',
      desc: '',
      args: [],
    );
  }

  /// `Attach Your resume`
  String get attachYouResume {
    return Intl.message(
      'Attach Your resume',
      name: 'attachYouResume',
      desc: '',
      args: [],
    );
  }

  /// `Employee`
  String get employeeFio {
    return Intl.message(
      'Employee',
      name: 'employeeFio',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Withholding Statement`
  String get withholdingStatement {
    return Intl.message(
      'Withholding Statement',
      name: 'withholdingStatement',
      desc: '',
      args: [],
    );
  }

  /// `No file`
  String get notFile {
    return Intl.message(
      'No file',
      name: 'notFile',
      desc: '',
      args: [],
    );
  }

  /// `Insurance contract`
  String get insuranceContract {
    return Intl.message(
      'Insurance contract',
      name: 'insuranceContract',
      desc: '',
      args: [],
    );
  }

  /// `Assistance`
  String get assistance {
    return Intl.message(
      'Assistance',
      name: 'assistance',
      desc: '',
      args: [],
    );
  }

  /// `Attach date`
  String get attachDate {
    return Intl.message(
      'Attach date',
      name: 'attachDate',
      desc: '',
      args: [],
    );
  }

  /// `Exclusion date`
  String get exclusionDate {
    return Intl.message(
      'Exclusion date',
      name: 'exclusionDate',
      desc: '',
      args: [],
    );
  }

  /// `Insurance program`
  String get insuredProgram {
    return Intl.message(
      'Insurance program',
      name: 'insuredProgram',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message(
      'Region',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `Total amount, KZT`
  String get totalAmountKzt {
    return Intl.message(
      'Total amount, KZT',
      name: 'totalAmountKzt',
      desc: '',
      args: [],
    );
  }

  /// `Annexes`
  String get annexes {
    return Intl.message(
      'Annexes',
      name: 'annexes',
      desc: '',
      args: [],
    );
  }

  /// `No annexes`
  String get notAnnexes {
    return Intl.message(
      'No annexes',
      name: 'notAnnexes',
      desc: '',
      args: [],
    );
  }

  /// `Attaching family members`
  String get addFamilyMember {
    return Intl.message(
      'Attaching family members',
      name: 'addFamilyMember',
      desc: '',
      args: [],
    );
  }

  /// `Information about family members`
  String get informationMember {
    return Intl.message(
      'Information about family members',
      name: 'informationMember',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete`
  String get deleteSure {
    return Intl.message(
      'Are you sure you want to delete',
      name: 'deleteSure',
      desc: '',
      args: [],
    );
  }

  /// `Relative`
  String get relative {
    return Intl.message(
      'Relative',
      name: 'relative',
      desc: '',
      args: [],
    );
  }

  /// `Amount KZT`
  String get amountKzt {
    return Intl.message(
      'Amount KZT',
      name: 'amountKzt',
      desc: '',
      args: [],
    );
  }

  /// `You have already applied for this vacancy`
  String get checkClick {
    return Intl.message(
      'You have already applied for this vacancy',
      name: 'checkClick',
      desc: '',
      args: [],
    );
  }

  /// `The candidate has already been recommended for this vacancy`
  String get checkClickRecommend {
    return Intl.message(
      'The candidate has already been recommended for this vacancy',
      name: 'checkClickRecommend',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to response for this vacancy?`
  String get sureVacation {
    return Intl.message(
      'Are you sure you want to response for this vacancy?',
      name: 'sureVacation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to recommend this candidate?`
  String get sureRefVacation {
    return Intl.message(
      'Are you sure you want to recommend this candidate?',
      name: 'sureRefVacation',
      desc: '',
      args: [],
    );
  }

  /// `Select company`
  String get selectCompany {
    return Intl.message(
      'Select company',
      name: 'selectCompany',
      desc: '',
      args: [],
    );
  }

  /// `Request for medical insurance with such IIN (Individual Identification Number) already exists.`
  String get errorDmsMember {
    return Intl.message(
      'Request for medical insurance with such IIN (Individual Identification Number) already exists.',
      name: 'errorDmsMember',
      desc: '',
      args: [],
    );
  }

  /// `Termination`
  String get dismissal {
    return Intl.message(
      'Termination',
      name: 'dismissal',
      desc: '',
      args: [],
    );
  }

  /// `Employee name`
  String get dismissalFIO {
    return Intl.message(
      'Employee name',
      name: 'dismissalFIO',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get dismissalPosition {
    return Intl.message(
      'Position',
      name: 'dismissalPosition',
      desc: '',
      args: [],
    );
  }

  /// `Subdivision`
  String get dismissalSubdivision {
    return Intl.message(
      'Subdivision',
      name: 'dismissalSubdivision',
      desc: '',
      args: [],
    );
  }

  /// `Hire date`
  String get dismissalHiredate {
    return Intl.message(
      'Hire date',
      name: 'dismissalHiredate',
      desc: '',
      args: [],
    );
  }

  /// `Dismissal date`
  String get dismissalDate {
    return Intl.message(
      'Dismissal date',
      name: 'dismissalDate',
      desc: '',
      args: [],
    );
  }

  /// `Download request template`
  String get dismissalDownloadButton {
    return Intl.message(
      'Download request template',
      name: 'dismissalDownloadButton',
      desc: '',
      args: [],
    );
  }

  /// `Download request template and fill by hand. Photograph and attach signed dismissal request.`
  String get dismissalDownloadText {
    return Intl.message(
      'Download request template and fill by hand. Photograph and attach signed dismissal request.',
      name: 'dismissalDownloadText',
      desc: '',
      args: [],
    );
  }

  /// `My Profile for the Employee\n Recognition and Bonus Program`
  String get myEmployeeRecognition {
    return Intl.message(
      'My Profile for the Employee\n Recognition and Bonus Program',
      name: 'myEmployeeRecognition',
      desc: '',
      args: [],
    );
  }

  /// `Logo`
  String get logo {
    return Intl.message(
      'Logo',
      name: 'logo',
      desc: '',
      args: [],
    );
  }

  /// `Badge`
  String get badge {
    return Intl.message(
      'Badge',
      name: 'badge',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Criterion`
  String get criterion {
    return Intl.message(
      'Criterion',
      name: 'criterion',
      desc: '',
      args: [],
    );
  }

  /// `Issue date`
  String get issueDate {
    return Intl.message(
      'Issue date',
      name: 'issueDate',
      desc: '',
      args: [],
    );
  }

  /// `Expire date`
  String get expireDate {
    return Intl.message(
      'Expire date',
      name: 'expireDate',
      desc: '',
      args: [],
    );
  }

  /// `Pin status`
  String get pinStatus {
    return Intl.message(
      'Pin status',
      name: 'pinStatus',
      desc: '',
      args: [],
    );
  }

  /// `Pin upgrade`
  String get pinUpgrade {
    return Intl.message(
      'Pin upgrade',
      name: 'pinUpgrade',
      desc: '',
      args: [],
    );
  }

  /// `Valid`
  String get valid {
    return Intl.message(
      'Valid',
      name: 'valid',
      desc: '',
      args: [],
    );
  }

  /// `Not valid`
  String get notValid {
    return Intl.message(
      'Not valid',
      name: 'notValid',
      desc: '',
      args: [],
    );
  }

  /// `Please attach to your application a withholding statement in accordance with the template for the amount of the co-payment for all family members.`
  String get attachCoPaymentField {
    return Intl.message(
      'Please attach to your application a withholding statement in accordance with the template for the amount of the co-payment for all family members.',
      name: 'attachCoPaymentField',
      desc: '',
      args: [],
    );
  }

  /// `Application for your family member's health insurance has been deleted.`
  String get deleteMembers {
    return Intl.message(
      'Application for your family member\'s health insurance has been deleted.',
      name: 'deleteMembers',
      desc: '',
      args: [],
    );
  }

  /// `PIN-code login`
  String get loginByPin {
    return Intl.message(
      'PIN-code login',
      name: 'loginByPin',
      desc: '',
      args: [],
    );
  }

  /// `Want to sign in and sign in as a different user?`
  String get exitUser {
    return Intl.message(
      'Want to sign in and sign in as a different user?',
      name: 'exitUser',
      desc: '',
      args: [],
    );
  }

  /// `All current passcode settings will be reset`
  String get exitUserInfo {
    return Intl.message(
      'All current passcode settings will be reset',
      name: 'exitUserInfo',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect PIN code`
  String get incorrectPin {
    return Intl.message(
      'Incorrect PIN code',
      name: 'incorrectPin',
      desc: '',
      args: [],
    );
  }

  /// `Enter PIN code for authentication`
  String get enterPinTitle {
    return Intl.message(
      'Enter PIN code for authentication',
      name: 'enterPinTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter PIN code`
  String get enterPin {
    return Intl.message(
      'Enter PIN code',
      name: 'enterPin',
      desc: '',
      args: [],
    );
  }

  /// `Repeat PIN Code`
  String get repeatePin {
    return Intl.message(
      'Repeat PIN Code',
      name: 'repeatePin',
      desc: '',
      args: [],
    );
  }

  /// `PIN codes do not match`
  String get doesntMatchPin {
    return Intl.message(
      'PIN codes do not match',
      name: 'doesntMatchPin',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to set up PIN code for authentication?`
  String get wantPin {
    return Intl.message(
      'Would you like to set up PIN code for authentication?',
      name: 'wantPin',
      desc: '',
      args: [],
    );
  }

  /// ` PIN code setting`
  String get pinCreate {
    return Intl.message(
      ' PIN code setting',
      name: 'pinCreate',
      desc: '',
      args: [],
    );
  }

  /// `FaceID/TouchID authentication`
  String get touchAuth {
    return Intl.message(
      'FaceID/TouchID authentication',
      name: 'touchAuth',
      desc: '',
      args: [],
    );
  }

  /// `Your login: `
  String get yourLogin {
    return Intl.message(
      'Your login: ',
      name: 'yourLogin',
      desc: '',
      args: [],
    );
  }

  /// `Version:`
  String get version {
    return Intl.message(
      'Version:',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Additional requirements to document`
  String get additionalReqsforDoc {
    return Intl.message(
      'Additional requirements to document',
      name: 'additionalReqsforDoc',
      desc: '',
      args: [],
    );
  }

  /// `The date cannot be earlier than today`
  String get cannotBeEarlierThanToday {
    return Intl.message(
      'The date cannot be earlier than today',
      name: 'cannotBeEarlierThanToday',
      desc: '',
      args: [],
    );
  }

  /// `Field "Phone number" must be filled.`
  String get fillMobilePhone {
    return Intl.message(
      'Field "Phone number" must be filled.',
      name: 'fillMobilePhone',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get courseStartDate {
    return Intl.message(
      'Start Date',
      name: 'courseStartDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get courseEndDate {
    return Intl.message(
      'End Date',
      name: 'courseEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get courseTime {
    return Intl.message(
      'Time',
      name: 'courseTime',
      desc: '',
      args: [],
    );
  }

  /// `Duration (hours)`
  String get courseDurationHours {
    return Intl.message(
      'Duration (hours)',
      name: 'courseDurationHours',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get courseAddress {
    return Intl.message(
      'Address',
      name: 'courseAddress',
      desc: '',
      args: [],
    );
  }

  /// `On Hold`
  String get on_hold {
    return Intl.message(
      'On Hold',
      name: 'on_hold',
      desc: '',
      args: [],
    );
  }

  /// `Collective Agreement Payment`
  String get collectivePayment {
    return Intl.message(
      'Collective Agreement Payment',
      name: 'collectivePayment',
      desc: '',
      args: [],
    );
  }

  /// `Payment Type`
  String get paymentType {
    return Intl.message(
      'Payment Type',
      name: 'paymentType',
      desc: '',
      args: [],
    );
  }

  /// `Payment Amount`
  String get paymentAmount {
    return Intl.message(
      'Payment Amount',
      name: 'paymentAmount',
      desc: '',
      args: [],
    );
  }

  /// `If you can not find your relative in the list, please add him/her in “My Profile” > “Information about relatives”`
  String get relativeText {
    return Intl.message(
      'If you can not find your relative in the list, please add him/her in “My Profile” > “Information about relatives”',
      name: 'relativeText',
      desc: '',
      args: [],
    );
  }

  /// `Relation Type`
  String get relationType {
    return Intl.message(
      'Relation Type',
      name: 'relationType',
      desc: '',
      args: [],
    );
  }

  /// `Relative`
  String get fioRelative {
    return Intl.message(
      'Relative',
      name: 'fioRelative',
      desc: '',
      args: [],
    );
  }

  /// `Attachment status (employee)`
  String get insuranceStatus {
    return Intl.message(
      'Attachment status (employee)',
      name: 'insuranceStatus',
      desc: '',
      args: [],
    );
  }

  /// `Server Error, contact administrator`
  String get errorServerAdmin {
    return Intl.message(
      'Server Error, contact administrator',
      name: 'errorServerAdmin',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'kk'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}