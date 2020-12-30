class WeatherBrain {
  /// Function to capitalize the first letter in Strings
  static String capitalizeFirstLetterOfWords(String words) {
    String formattedWords;
    formattedWords = words
        .toLowerCase()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');

    return formattedWords;
  }
}
