class CountryFlagService {
  final String url = 'https://www.countryflagicons.com/FLAT';
  final String country;
  final List<int> sizes = [16, 24, 32, 48, 64];
  //
  CountryFlagService({required this.country});
  //
  String getUrl(int size) {
    // check if invalid size
    if (!sizes.contains(size)) {
      size = 48;
    }
    //
    return '$url/$size/$country.png';
  }
}
