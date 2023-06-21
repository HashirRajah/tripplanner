class EmbassyInfoModel {
  final String url;
  final String status;
  final String title;
  final String address;
  final List<String> phoneNumbers;
  final List<String> faxes;
  final String email;
  final String websiteUrl;
  //
  EmbassyInfoModel({
    required this.url,
    required this.status,
    required this.title,
    required this.address,
    required this.phoneNumbers,
    required this.faxes,
    required this.email,
    required this.websiteUrl,
  });
}
