class Media {
  int? id;
  String? contentType;
  int? contentSize;
  String? name;
  String? extension;
  String? filePath;
  bool? isVideo;
  Null? posts;

  Media(
      {this.id,
      this.contentType,
      this.contentSize,
      this.name,
      this.extension,
      this.filePath,
      this.isVideo,
      this.posts});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentType = json['contentType'];
    contentSize = json['contentSize'];
    name = json['name'];
    extension = json['extension'];
    filePath = json['filePath'];
    isVideo = json['isVideo'];
    posts = json['posts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contentType'] = contentType;
    data['contentSize'] = contentSize;
    data['name'] = name;
    data['extension'] = extension;
    data['filePath'] = filePath;
    data['isVideo'] = isVideo;
    data['posts'] = posts;
    return data;
  }
}
