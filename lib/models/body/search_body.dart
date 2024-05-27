class SearchBody {
  String? keyWord;
  int? pageIndex;
  int? size;
  int? status;

  SearchBody({this.keyWord, this.pageIndex, this.size, this.status});

  SearchBody.fromJson(Map<String, dynamic> json) {
    keyWord = json['keyWord'];
    pageIndex = json['pageIndex'];
    size = json['size'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyWord'] = keyWord;
    data['pageIndex'] = pageIndex;
    data['size'] = size;
    data['status'] = status;
    return data;
  }
}
