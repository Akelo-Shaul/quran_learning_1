class SliderImage {
  String? bannerId, bannerName,bannerLink,dateAdded;
  SliderImage({
    required this.bannerId,
    required this.bannerName,
    required this.bannerLink,
    required this.dateAdded,
  });

  factory SliderImage.fromJson(Map<String, dynamic> json) {
    return SliderImage(
      bannerId: json['banner_id'] ?? '',
      bannerName: json['banner_name'] ?? '',
      bannerLink: json['banner_link'] ?? '',
      dateAdded: json['date_added'] ?? '',
    );
  }

  @override
  String toString() {
    return 'SliderImage(bannerId: $bannerId, bannerName: $bannerName, bannerLink: $bannerLink, dateAdded: $dateAdded)';
  }
}