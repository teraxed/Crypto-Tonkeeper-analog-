import 'package:Crypto/features/auth/data/models/yield_model.dart';
import 'package:Crypto/features/core/network/api_client.dart';

abstract class YieldsService {
  // TODO: путь эндпоинта на твоём бэке
  static const String _path = '/yields';

  static const List<String> _shown = [
    'BTC', 'ETH', 'SOL', 'USDT', 'USDC', 'BNB', 'AVAX',
  ];

  static Future<List<YieldAsset>> fetch() async {
    final response = await ApiClient.dio.get(_path);

    final data = response.data as Map<String, dynamic>;
    final all = (data['yields'] as List)
        .map((e) => YieldAsset.fromJson(e as Map<String, dynamic>))
        .toList();

    return [
      for (final symbol in _shown)
        ...all.where((y) => y.asset == symbol && y.bestApy != null),
    ];
  }
}