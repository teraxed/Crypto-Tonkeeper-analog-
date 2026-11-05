class YieldAsset {
  final String asset;
  final double? bestApy;
  final String? platform;
  final String? riskTier;
  final bool stablecoin;

  const YieldAsset({
    required this.asset,
    this.bestApy,
    this.platform,
    this.riskTier,
    this.stablecoin = false,
  });

  factory YieldAsset.fromJson(Map<String, dynamic> json) {
    return YieldAsset(
      asset: json['asset'] as String,
      bestApy: (json['best_apy'] as num?)?.toDouble(),
      platform: json['best_platform'] as String?,
      riskTier: json['risk_tier'] as String?,
      stablecoin: json['stablecoin'] as bool? ?? false,
    );
  }
}