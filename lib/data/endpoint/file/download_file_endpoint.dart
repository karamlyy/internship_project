import 'package:language_learning/data/endpoint/base/endpoint.dart';

class DownloadFileEndpoint extends Endpoint {
  @override
  String get route => 'https://docs.google.com/spreadsheets/d/1XdBMokLQax1Q32zpWVH3FNCNr_882MN_/edit?usp=share_link&ouid=110829931777831866696&rtpof=true&sd=true';

  @override
  HttpMethod get httpMethod => HttpMethod.get;
}
