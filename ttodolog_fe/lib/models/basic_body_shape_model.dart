//기본 원형 모델(10개 항목)

class BasicBodyShapeModel {
  double shoulderSlope; // 어깨처짐
  double backNeckDepth; // 뒷목깊이
  double armholeDepth; // 진동길이
  double neckCircumference; // 목둘레
  double shoulderWidth; // 어깨너비
  double armLength; // 팔길이
  double armCircumference; // 팔둘레
  double wristCircumference; // 손목둘레
  double backLength; // 등길이

  BasicBodyShapeModel({
    required this.shoulderSlope,
    required this.backNeckDepth,
    required this.armholeDepth,
    required this.neckCircumference,
    required this.shoulderWidth,
    required this.armLength,
    required this.armCircumference,
    required this.wristCircumference,
    required this.backLength,
  });

  static BasicBodyShapeModel getMatchingBodyShape(double chestSize) {
    final data = _basePatternData(chestSize);
    return BasicBodyShapeModel(
      shoulderSlope: data["어깨처짐"]!,
      backNeckDepth: data["뒷목깊이"]!,
      armholeDepth: data["진동길이"]!,
      neckCircumference: data["목둘레"]!,
      shoulderWidth: data["어깨너비"]!,
      armLength: data["팔길이"]!,
      armCircumference: data["팔둘레"]!,
      wristCircumference: data["손목둘레"]!,
      backLength: data["등길이"]!,
    );
  }

  static Map<String, double> _basePatternData(double chestSize) {
    final List<Map<String, dynamic>> patternData = [
      {
        "range": [50, 53],
        "values": {
          "어깨처짐": 1.0,
          "뒷목깊이": 1.0,
          "진동길이": 12.0,
          "목둘레": 26.0,
          "어깨너비": 22.0,
          "팔길이": 26.0,
          "팔둘레": 21.1,
          "손목둘레": 12.0,
          "등길이": 24,
        }
      },
      {
        "range": [54, 57],
        "values": {
          "어깨처짐": 1.5,
          "뒷목깊이": 1.0,
          "진동길이": 12.5,
          "목둘레": 27.0,
          "어깨너비": 24.0,
          "팔길이": 28.0,
          "팔둘레": 22.0,
          "손목둘레": 12.0,
          "등길이": 26,
        }
      },
      {
        "range": [58, 61],
        "values": {
          "어깨처짐": 2.0,
          "뒷목깊이": 1.0,
          "진동길이": 13.0,
          "목둘레": 28.0,
          "어깨너비": 26.0,
          "팔길이": 32.0,
          "팔둘레": 22.5,
          "손목둘레": 13.0,
          "등길이": 28
        }
      },
      {
        "range": [62, 65],
        "values": {
          "어깨처짐": 2.5,
          "뒷목깊이": 1.0,
          "진동길이": 14.0,
          "목둘레": 30.0,
          "어깨너비": 28.0,
          "팔길이": 36.0,
          "팔둘레": 23.5,
          "손목둘레": 13.0,
          "등길이": 30
        }
      },
      {
        "range": [66, 69],
        "values": {
          "어깨처짐": 3.0,
          "뒷목깊이": 1.0,
          "진동길이": 15.5,
          "목둘레": 32.0,
          "어깨너비": 30.0,
          "팔길이": 40.0,
          "팔둘레": 24.0,
          "손목둘레": 14.0,
          "등길이": 33
        }
      },
      {
        "range": [70, 73],
        "values": {
          "어깨처짐": 3.5,
          "뒷목깊이": 1.5,
          "진동길이": 16.0,
          "목둘레": 33,
          "어깨너비": 32.0,
          "팔길이": 44.0,
          "팔둘레": 25.0,
          "손목둘레": 14.0,
          "등길이": 35
        }
      },
      {
        "range": [74, 79],
        "values": {
          "어깨처짐": 4.0,
          "뒷목깊이": 1.5,
          "진동길이": 17.0,
          "목둘레": 33.0,
          "어깨너비": 34.5,
          "팔길이": 46.0,
          "팔둘레": 27.0,
          "손목둘레": 15.0,
          "등길이": 37
        }
      },
      {
        "range": [80, 84],
        "values": {
          "어깨처짐": 4.0,
          "뒷목깊이": 1.5,
          "진동길이": 18.0,
          "목둘레": 33.0,
          "어깨너비": 35.0,
          "팔길이": 49.0,
          "팔둘레": 28.0,
          "손목둘레": 16.0,
          "등길이": 38
        }
      },
      {
        "range": [85, 89],
        "values": {
          "어깨처짐": 4.0,
          "뒷목깊이": 1.5,
          "진동길이": 18.5,
          "목둘레": 34.0,
          "어깨너비": 36.0,
          "팔길이": 51.0,
          "팔둘레": 29.0,
          "손목둘레": 16.0,
          "등길이": 40
        }
      },
      {
        "range": [90, 94],
        "values": {
          "어깨처짐": 4.0,
          "뒷목깊이": 1.5,
          "진동길이": 19.0,
          "목둘레": 35.0,
          "어깨너비": 36.5,
          "팔길이": 53.0,
          "팔둘레": 31.0,
          "손목둘레": 17.0,
          "등길이": 41
        }
      },
      {
        "range": [95, 99],
        "values": {
          "어깨처짐": 4.0,
          "뒷목깊이": 1.5,
          "진동길이": 19.5,
          "목둘레": 36.0,
          "어깨너비": 37.0,
          "팔길이": 54.0,
          "팔둘레": 33.0,
          "손목둘레": 17.0,
          "등길이": 42
        }
      },
      {
        "range": [100, 104],
        "values": {
          "어깨처짐": 4.0,
          "뒷목깊이": 1.5,
          "진동길이": 20.0,
          "목둘레": 38.0,
          "어깨너비": 38.0,
          "팔길이": 55.0,
          "팔둘레": 34.0,
          "손목둘레": 18.0,
          "등길이": 43
        }
      },
      {
        "range": [105, 109],
        "values": {
          "어깨처짐": 4.0,
          "뒷목깊이": 1.5,
          "진동길이": 20.5,
          "목둘레": 39.0,
          "어깨너비": 39.0,
          "팔길이": 57.0,
          "팔둘레": 35.0,
          "손목둘레": 18.0,
          "등길이": 44
        }
      },
      {
        "range": [110, 114],
        "values": {
          "어깨처짐": 4.0,
          "뒷목깊이": 1.5,
          "진동길이": 21.0,
          "목둘레": 40.0,
          "어깨너비": 40.0,
          "팔길이": 58.0,
          "팔둘레": 36.0,
          "손목둘레": 18.0,
          "등길이": 45
        }
      },
      {
        "range": [115, 120],
        "values": {
          "어깨처짐": 4.0,
          "뒷목깊이": 1.5,
          "진동길이": 22.0,
          "목둘레": 41.0,
          "어깨너비": 41.0,
          "팔길이": 59.0,
          "팔둘레": 37.0,
          "손목둘레": 19.0,
          "등길이": 46
        }
      },
      {
        "range": [121, 129],
        "values": {
          "어깨처짐": 4.0,
          "뒷목깊이": 1.5,
          "진동길이": 23.0,
          "목둘레": 42.0,
          "어깨너비": 42.0,
          "팔길이": 60.0,
          "팔둘레": 39.0,
          "손목둘레": 19.0,
          "등길이": 48
        }
      }
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
