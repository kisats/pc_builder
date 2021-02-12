extension UrlExtension on Map {
  String toUrlParams() {
    var string = '';
    this.forEach((key, value) => string += "${key.toString()}=${value.toString()}&");
    return string.substring(0, string.length - 1);
  }
}
