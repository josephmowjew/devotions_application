import 'package:devotions_app/shared/environments/base_urls.dart';

class EnvironmentUrls implements BaseUrls {
  String formatUrl(String domain, String path) =>
      'https://staging-$domain.lyvepulse.com/$path';

  @override
  String get permissionsService => formatUrl('permissions', 'permissions');

  @override
  String get devotionService => formatUrl('devotion', 'api');

  @override
  String get reportsService => formatUrl('reporting-v2', 'api/v1');
}
