import 'dart:developer';
import 'package:redditech/models/base.model.dart';

class Subreddit extends BaseModel {
  String? subreddit;
  String? selftext;
  String? title;
  String? subredditNamePrefixed;
  String? subredditType;
  int? score;
  String? thumbnail;
  double? created;
  String? selftextHtml;
  bool? over18;
  Preview? preview;
  String? author;
  String? permalink;
  String? url;
  int? subredditSubscribers;
  double? createdUtc;
  int? numCrossposts;

  Subreddit({
    this.subreddit,
    this.selftext,
    this.title,
    this.subredditNamePrefixed,
    this.subredditType,
    this.score,
    this.thumbnail,
    this.created,
    this.selftextHtml,
    this.over18,
    this.preview,
    this.author,
    this.permalink,
    this.url,
    this.subredditSubscribers,
    this.createdUtc,
    this.numCrossposts,
  });

  Subreddit.fromJson(Map<String, dynamic> json) {
    subreddit = json['subreddit'];
    selftext = json['selftext'];
    title = json['title'];
    subredditNamePrefixed = json['subreddit_name_prefixed'];
    subredditType = json['subreddit_type'];
    score = json['score'];
    thumbnail = json['thumbnail'];
    created = json['created'];
    selftextHtml = json['selftext_html'];
    over18 = json['over_18'];
    preview = json['preview'] != null
        ? Preview.fromJson(json['preview']['images'][0])
        : null;
    author = json['author'];
    permalink = json['permalink'];
    url = json['url'];
    subredditSubscribers = json['subreddit_subscribers'];
    createdUtc = json['created_utc'];
    numCrossposts = json['num_crossposts'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subreddit'] = subreddit;
    data['selftext'] = selftext;
    data['title'] = title;
    data['subreddit_name_prefixed'] = subredditNamePrefixed;
    data['subreddit_type'] = subredditType;
    data['score'] = score;
    data['thumbnail'] = thumbnail;
    data['created'] = created;
    data['selftext_html'] = selftextHtml;
    data['over_18'] = over18;
    if (preview != null) {
      data['preview'] = preview!.toJson();
    }
    data['author'] = author;
    data['permalink'] = permalink;
    data['url'] = url;
    data['subreddit_subscribers'] = subredditSubscribers;
    data['created_utc'] = createdUtc;
    data['num_crossposts'] = numCrossposts;
    return data;
  }
}

class Preview extends BaseModel {
  Picture? source;
  List<Picture> resolutions = [];

  Preview();

  Preview.fromJson(Map<String, dynamic> json) {
    source = Picture.fromJson(json['source']);
    if (json['resolutions'] != null) {
      json['resolutions'].forEach(
        (v) => resolutions.add(Picture.fromJson(v)),
      );
    }
  }

  @override
  toJson() {
    return {
      'source': source!.toJson().toString(),
      'resolutions': resolutions.toString(),
    };
  }
}

class Picture extends BaseModel {
  String? url;
  int? width;
  int? height;

  Picture.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'width': width,
      'height': height,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
