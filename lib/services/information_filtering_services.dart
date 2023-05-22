class InformationFilteringService {
  String filterPrice(String text) {
    String price = '';
    //
    int index = text.toLowerCase().indexOf('total');
    //
    if (index != -1) {
      price = '$index';
    }
    //
    return price;
  }
}
