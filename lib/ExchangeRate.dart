// To parse this JSON data, do
//
//     final exchangeRate = exchangeRateFromJson(jsonString);

import 'dart:convert';

ExchangeRate exchangeRateFromJson(String str) => ExchangeRate.fromJson(json.decode(str));

String exchangeRateToJson(ExchangeRate data) => json.encode(data.toJson());

class ExchangeRate {
    String? provider;
    String? warningUpgradeToV6;
    String? terms;
    String? base;
    DateTime? date;
    int? timeLastUpdated;
    Map<String, double>? rates;

    ExchangeRate({
        this.provider,
        this.warningUpgradeToV6,
        this.terms,
        this.base,
        this.date,
        this.timeLastUpdated,
        this.rates,
    });

    factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
        provider: json["provider"],
        warningUpgradeToV6: json["WARNING_UPGRADE_TO_V6"],
        terms: json["terms"],
        base: json["base"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timeLastUpdated: json["time_last_updated"],
        rates: Map.from(json["rates"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "provider": provider,
        "WARNING_UPGRADE_TO_V6": warningUpgradeToV6,
        "terms": terms,
        "base": base,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time_last_updated": timeLastUpdated,
        "rates": Map.from(rates!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
