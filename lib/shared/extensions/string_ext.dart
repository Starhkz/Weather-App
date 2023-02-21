extension Capitalize on String {
  String capitalize() {
    return split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      } else {
        return word[0].toUpperCase() + word.substring(1);
      }
    }).join(' ');
  }
}
