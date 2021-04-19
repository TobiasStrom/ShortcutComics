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

  factory Comics.fromDB(Map<String, dynamic> db) => Comics(
    num: db['num'],
    title: db['title'],
    safeTitle: db['safe_title'],
    alt: db['alt'],
    img: db['img'],
    link: db['link'],
    news: db['news'],
    transcript: db['transcript'],
    year: db['year'],
    month: db['month'],
    day: db['day'],
    imageData: db['imageData']
  );

  Map<String, dynamic> toMap(){
    return{
      'num': num,
      'title': title,
      'safeTitle': safeTitle,
      'alt': alt,
      'img': img,
      'link': link,
      'news': news,
      'transcript': transcript,
      'year': year,
      'month': month,
      'day': day,
      'imageData': imageData,
    };
  }
}