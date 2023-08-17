class SupportInfo {
  SupportInfo({
    this.url,
    this.text,
  });

  final String? url;
  final String? text;

  Map<String, dynamic> toJson() => {
        'url': url,
        'text': text,
      };

  factory SupportInfo.fromJson(Map<String, dynamic> map) {
    return SupportInfo(
      url: map['url'] != null ? map['url'] as String : null,
      text: map['text'] != null ? map['text'] as String : null,
    );
  }
}
