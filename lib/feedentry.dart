class FeedEntry {
  final String user;
  final String trackName;
  final String description;

  FeedEntry(this.user, this.description, this.trackName);

  FeedEntry.fromJson(Map<String, dynamic> json)
      : user = json['user'],
        trackName = json['track'],
        description = json['description'];

  Map<String, dynamic> toJson() =>
      {'user': user, 'track': trackName, 'description': description};
}
