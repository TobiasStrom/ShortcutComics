class Comics{
  final int num;
  final String title;
  final String safeTitle;
  final String alt;
  final String img;
  final String link;
  final String news;
  final String transcript;
  final String year;
  final String month;
  final String day;
  String imageData;

  Comics({
    this.num,
    this.title,
    this.safeTitle,
    this.alt,
    this.img,
    this.link,
    this.news,
    this.transcript,
    this.year,
    this.month,
    this.day,
    this.imageData});

  factory Comics.fromJson(Map<String, dynamic> json) => Comics(
    num: json['num'],
    title: json['title'],
    safeTitle: json['safe_title'],
    alt: json['alt'],
    img: json['img'],
    link: json['link'],
    news: json['news'],
    transcript: json['transcript'],
    year: json['year'],
    month: json['month'],
    day: json['day'],
  );
}