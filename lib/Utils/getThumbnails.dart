

import 'package:video_thumbnail/video_thumbnail.dart';

Future<String> getThumbnail(String path) async {

  print('vedio path: $path');


  String? thumb = await VideoThumbnail.thumbnailFile(video: path);
  print('vedio thumb: $thumb');
  return thumb!;
}