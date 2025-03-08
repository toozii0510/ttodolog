//기본 원형 모델(하드코딩)

class BasePatternModel {
  double shoulderSlope; // 어깨처짐
  double backNeckDepth; // 뒷목깊이
  double frontNeckDepth; // 앞목깊이
  double armholeDepth; // 진동길이
  double sideLength; // 옆길이
  double neckWidth; // 목너비
  double shoulderWidth; // 어깨너비
  double chestWidth; // 가슴너비
  double sleeveCapHeight; // 소매산 길이
  double sleeveLength; // 소매 길이
  double sleeveWidth; // 소매 너비
  double wristWidth; // 손목 너비
  double bottomBandHeight; // 아랫단 고무단 길이
  double sleeveBandHeight; // 소매 고무단 길이

  BasePatternModel({
    required this.shoulderSlope,
    required this.backNeckDepth,
    required this.frontNeckDepth,
    required this.armholeDepth,
    required this.sideLength,
    required this.neckWidth,
    required this.shoulderWidth,
    required this.chestWidth,
    required this.sleeveCapHeight,
    required this.sleeveLength,
    required this.sleeveWidth,
    required this.wristWidth,
    required this.bottomBandHeight,
    required this.sleeveBandHeight,
  });

  static BasePatternModel getBasePatternByChestSize(double chestSize) {
    final data = _basePatternData(chestSize);
    return BasePatternModel(
      shoulderSlope: data["어깨처짐"]!,
      backNeckDepth: data["뒷목깊이"]!,
      frontNeckDepth: data["앞목깊이"]!,
      armholeDepth: data["진동길이"]!,
      sideLength: data["옆길이"]!,
      neckWidth: data["목너비"]!,
      shoulderWidth: data["어깨너비"]!,
      chestWidth: data["가슴너비"]!,
      sleeveCapHeight: data["소매산 길이"]!,
      sleeveLength: data["소매 길이"]!,
      sleeveWidth: data["소매 너비"]!,
      wristWidth: data["손목 너비"]!,
      bottomBandHeight: data["아랫단 고무단 길이"]!,
      sleeveBandHeight: data["아랫단 고무단 길이"]!,
    );
  }

  static Map<String, double> _basePatternData(double chestSize) {
    final List<Map<String, dynamic>> patternData = [
      {
        "range": [50, 53],
        "values": {
          "어깨처짐": 0.6,
          "뒷목깊이": 1.2,
          "앞목깊이": 5.4,
          "진동길이": 13.0,
          "옆길이": 24.4,
          "목너비": 15.3,
          "어깨너비": 20.0,
          "가슴너비": 32.0,
          "소매산 길이": 7.7,
          "소매 길이": 26.0,
          "소매 너비": 12.1,
          "손목 너비": 6.0,
          "아랫단 고무단 길이": 3,
          "소매 고무단 길이": 3
        }
      },
      {
        "range": [54, 57],
        "values": {
          "어깨처짐": 0.9,
          "뒷목깊이": 1.2,
          "앞목깊이": 5.5,
          "진동길이": 13.5,
          "옆길이": 25.6,
          "목너비": 15.7,
          "어깨너비": 22.0,
          "가슴너비": 34.0,
          "소매산 길이": 7.5,
          "소매 길이": 30.0,
          "소매 너비": 12.7,
          "손목 너비": 6.0,
          "아랫단 고무단 길이": 3,
          "소매 고무단 길이": 3
        }
      },
      {
        "range": [58, 61],
        "values": {
          "어깨처짐": 1.2,
          "뒷목깊이": 1.2,
          "앞목깊이": 5.7,
          "진동길이": 14.0,
          "옆길이": 26.8,
          "목너비": 16.0,
          "어깨너비": 24.0,
          "가슴너비": 36.0,
          "소매산 길이": 8.1,
          "소매 길이": 34.0,
          "소매 너비": 12.9,
          "손목 너비": 6.5,
          "아랫단 고무단 길이": 3,
          "소매 고무단 길이": 3
        }
      },
      {
        "range": [62, 65],
        "values": {
          "총장": 47,
          "어깨처짐": 1.5,
          "뒷목깊이": 1.2,
          "앞목깊이": 5.7,
          "진동길이": 15.0,
          "옆길이": 26.5,
          "목너비": 16.0,
          "어깨너비": 26.0,
          "가슴너비": 38.0,
          "소매산 길이": 8.9,
          "소매 길이": 38.0,
          "소매 너비": 13.5,
          "손목 너비": 6.5,
          "아랫단 고무단 길이": 4,
          "소매 고무단 길이": 4
        }
      },
      {
        "range": [66, 69],
        "values": {
          "어깨처짐": 1.8,
          "뒷목깊이": 1.2,
          "앞목깊이": 5.9,
          "진동길이": 16.5,
          "옆길이": 27.7,
          "목너비": 16.3,
          "어깨너비": 28.0,
          "가슴너비": 40.0,
          "소매산 길이": 10.9,
          "소매 길이": 42.0,
          "소매 너비": 13.8,
          "손목 너비": 7.0,
          "아랫단 고무단 길이": 4,
          "소매 고무단 길이": 4
        }
      },
      {
        "range": [70, 73],
        "values": {
          "어깨처짐": 2.1,
          "뒷목깊이": 1.8,
          "앞목깊이": 6.6,
          "진동길이": 17.0,
          "옆길이": 29.9,
          "목너비": 16.5,
          "어깨너비": 30.0,
          "가슴너비": 42.0,
          "소매산 길이": 10.8,
          "소매 길이": 46.0,
          "소매 너비": 14.4,
          "손목 너비": 7.0,
          "아랫단 고무단 길이": 4,
          "소매 고무단 길이": 3
        }
      },
      {
        "range": [74, 79],
        "values": {
          "어깨처짐": 2.4,
          "뒷목깊이": 1.8,
          "앞목깊이": 6.8,
          "진동길이": 18.0,
          "옆길이": 29.6,
          "목너비": 17.0,
          "어깨너비": 32.5,
          "가슴너비": 44.0,
          "소매산 길이": 10.8,
          "소매 길이": 48.0,
          "소매 너비": 15.5,
          "손목 너비": 7.5,
          "아랫단 고무단 길이": 4,
          "소매 고무단 길이": 4
        }
      },
      {
        "range": [80, 84],
        "values": {
          "어깨처짐": 2.4,
          "뒷목깊이": 1.8,
          "앞목깊이": 7.0,
          "진동길이": 19.0,
          "옆길이": 29.6,
          "목너비": 17.3,
          "어깨너비": 33.0,
          "가슴너비": 47.0,
          "소매산 길이": 12.3,
          "소매 길이": 51.0,
          "소매 너비": 16.1,
          "손목 너비": 8.0,
          "아랫단 고무단 길이": 5,
          "소매 고무단 길이": 4
        }
      },
      {
        "range": [85, 89],
        "values": {
          "어깨처짐": 2.4,
          "뒷목깊이": 1.8,
          "앞목깊이": 7.3,
          "진동길이": 19.5,
          "옆길이": 31.1,
          "목너비": 18.0,
          "어깨너비": 34.0,
          "가슴너비": 49.5,
          "소매산 길이": 12.7,
          "소매 길이": 53.0,
          "소매 너비": 16.7,
          "손목 너비": 8.0,
          "아랫단 고무단 길이": 5,
          "소매 고무단 길이": 5
        }
      },
      {
        "range": [90, 94],
        "values": {
          "어깨처짐": 2.4,
          "뒷목깊이": 1.8,
          "앞목깊이": 7.5,
          "진동길이": 20.0,
          "옆길이": 31.6,
          "목너비": 18.3,
          "어깨너비": 34.5,
          "가슴너비": 52.0,
          "소매산 길이": 12.6,
          "소매 길이": 55.0,
          "소매 너비": 17.8,
          "손목 너비": 8.5,
          "아랫단 고무단 길이": 5,
          "소매 고무단 길이": 5
        }
      },
      {
        "range": [95, 99],
        "values": {
          "어깨처짐": 2.4,
          "뒷목깊이": 1.8,
          "앞목깊이": 7.8,
          "진동길이": 20.5,
          "옆길이": 31.1,
          "목너비": 19.0,
          "어깨너비": 35.0,
          "가슴너비": 54.5,
          "소매산 길이": 12.4,
          "소매 길이": 56.0,
          "소매 너비": 19.0,
          "손목 너비": 8.5,
          "아랫단 고무단 길이": 6,
          "소매 고무단 길이": 6
        }
      },
      {
        "range": [100, 129],
        "values": {
          "어깨처짐": 2.4,
          "뒷목깊이": 1.8,
          "앞목깊이": 9.1,
          "진동길이": 24.0,
          "옆길이": 33.1,
          "목너비": 21.7,
          "어깨너비": 40.0,
          "가슴너비": 68.0,
          "소매산 길이": 16.4,
          "소매 길이": 62.0,
          "소매 너비": 22.4,
          "손목 너비": 9.5,
          "아랫단 고무단 길이": 6.5,
          "소매 고무단 길이": 6.5
        }
      },
    ];

    for (final pattern in patternData) {
      final List<double> range = [
        (pattern["range"]![0] as num).toDouble(),
        (pattern["range"]![1] as num).toDouble()
      ];

      if (chestSize >= range[0] && chestSize <= range[1]) {
        return Map<String, double>.from(pattern["values"]
            .map((key, value) => MapEntry(key, (value as num).toDouble())));
      }
    }

// 마지막 패턴 데이터 반환 (int → double 변환 적용)
    return Map<String, double>.from(patternData.last["values"]
        .map((key, value) => MapEntry(key, (value as num).toDouble())));
  }
}
