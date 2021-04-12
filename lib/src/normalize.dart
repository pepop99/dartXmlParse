import 'equivalentwords.dart';


class Normalizer {
  //normalize as per rules in LicenseClassifier and SPDX matching guidelines
  
  //strip new lines and carriage returns
  final lineBreakRegEx = RegExp('[\r\n]+');
  
  //strip spaces
  final whiteSpaceRegEx = RegExp('[\t ]+');
  final leadingWhiteSpaceRegEx = RegExp(
    '^[\t ]+',
    multiLine: true,
  );
  final trailingWhiteSpaceRegEx = RegExp('[\n\t ]+\$', multiLine: true);


  //punctutation regex
  final punctuationRegex = RegExp(r'[.,\/#!$%\^&\*;:{}=\-_`~()]');

  //quotes regex
  final quotesRegEx = RegExp('["\'“”‘’„‚,«»‹›❛❜❝❞`]+');

  //paranthesis regex
  final paranthesisRegEx = RegExp('[\(\)\{\}]+');

  //comments regex
  final commentsRegEx = RegExp(r'(\/\/|\/\*) +.*');

  //bullets regex
  final bulletRegEx = RegExp(r'(([0-9a-z]\.\s)+|(\([0-9a-z]\)\s)+|(\*\s)+)|([0-9a-z]\)\s)|(\s\([i]+\))');

  //url regex
  final urlRegEx = RegExp(r'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');

  //trim copyright symbols
  final copyrightSymbolRegEx = RegExp(r'[©Ⓒⓒ]');
  final trademarkSymbolRegEx = RegExp('trademark(s?)|\\(tm\\)');

  final copyrightTextRegEx =
      RegExp(r'((?<=\n)|.*)Copyright.+(?=\n)|Copyright.+\\n');

  //equivalent words
  final equivalentWords = EquivalentWords().words;

  String normalize(String licenseText) {
    licenseText = licenseText
        .replaceAll(bulletRegEx, '')
        .replaceAll(punctuationRegex, ' ')
        .replaceAll(quotesRegEx, ' ')
        .replaceAll(paranthesisRegEx, '')
        .replaceAll(urlRegEx, '')
        .replaceAll(commentsRegEx, '')
        .replaceAll(copyrightSymbolRegEx, '')
        .replaceAll(copyrightTextRegEx, '')
        .replaceAll(trademarkSymbolRegEx, ' ')
        .replaceAll(whiteSpaceRegEx, ' ')
        .replaceAll(trailingWhiteSpaceRegEx, '')
        .replaceAll(leadingWhiteSpaceRegEx, '')
        .toLowerCase()
        .trim();

    if (licenseText.split('\n')[0].contains('license')) {
      licenseText = licenseText.split('\n').sublist(1).join('\n');
    }

    equivalentWords.forEach((key, value) {
      licenseText = licenseText.replaceAll(key, value);
    });

    //replace more than 1 next line with a single next line
    licenseText = licenseText.replaceAll(RegExp('[\n]+'), '\n');

    return licenseText;
  }
}

