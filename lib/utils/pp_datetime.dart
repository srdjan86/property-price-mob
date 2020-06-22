class PPDateTime {
  static String toEuroString(DateTime date) {
    return '${date.day < 10 ? '0' : ''}${date.day}.${date.month < 10 ? '0' : ''}${date.month}.${date.year}';
  }

  static String toUSString(DateTime date) {
    return '${date.year}-${date.month < 10 ? '0' : ''}${date.month}-${date.day < 10 ? '0' : ''}${date.day}';
  }
}
