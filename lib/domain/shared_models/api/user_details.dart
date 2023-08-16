class UserDetails {
    final String url;
    final String text;

    UserDetails({
        required this.url,
        required this.text,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        url: json["url"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "text": text,
    };
}