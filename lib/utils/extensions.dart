extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.toLowerCase().substring(1)}";
  }
}
