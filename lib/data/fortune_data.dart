import 'dart:math';

class FortuneData {
  static const List<String> overallFortunes = [
    '오늘은 새로운 기회가 찾아올 수 있는 날입니다. 열린 마음으로 주변을 살펴보세요.',
    '작은 일에도 감사하는 마음을 가지면 큰 행운이 따라올 것입니다.',
    '오늘의 에너지는 매우 활발합니다. 미뤄두었던 일을 시작하기 좋은 날이에요.',
    '예상치 못한 만남이 좋은 인연으로 이어질 수 있습니다.',
    '차분하게 하루를 보내면 마음의 평화를 얻을 수 있는 날입니다.',
    '오랫동안 준비했던 일이 결실을 맺기 시작하는 시기입니다.',
    '주변 사람들의 도움으로 어려움을 극복할 수 있는 날이에요.',
    '직감이 예리해지는 날입니다. 느낌을 믿고 행동해보세요.',
    '꾸준히 노력해온 것들이 빛을 발하기 시작합니다. 조금만 더 힘내세요!',
    '오늘은 자신을 돌보는 시간을 가져보세요. 휴식도 중요합니다.',
    '긍정적인 변화의 바람이 불어오고 있습니다. 변화를 두려워하지 마세요.',
    '소통이 핵심인 날입니다. 진심을 담아 대화하면 좋은 결과가 있을 거예요.',
  ];

  static const List<String> loveFortunes = [
    '사랑하는 사람과의 관계가 한층 더 깊어지는 날입니다.',
    '솔로라면 매력적인 사람을 만날 수 있는 기운이 감돕니다.',
    '상대방의 작은 배려에 감동받을 수 있는 하루예요.',
    '오해가 있었다면 오늘 풀릴 수 있습니다. 먼저 손을 내밀어보세요.',
    '로맨틱한 분위기가 감도는 날이에요. 특별한 이벤트를 계획해보세요.',
    '인연의 실이 서서히 이어지고 있습니다. 조급해하지 마세요.',
    '진심을 표현하기 좋은 날입니다. 숨기지 말고 솔직해져보세요.',
    '사랑에 대한 기대감이 높아지는 날이에요. 좋은 소식이 있을 수 있습니다.',
    '관계에서 신뢰를 쌓아가는 것이 중요한 시기입니다.',
    '과거의 상처를 치유하고 새로운 사랑을 맞이할 준비를 하세요.',
    '함께하는 시간의 소중함을 느끼게 되는 하루입니다.',
    '사랑의 에너지가 충만한 날입니다. 주변에 온기를 나눠주세요.',
  ];

  static const List<String> moneyFortunes = [
    '재정적으로 안정적인 흐름이 이어지고 있습니다.',
    '예상치 못한 수입이 생길 수 있는 날이에요. 기대해보세요!',
    '투자나 재테크에 관심을 가져보면 좋은 정보를 얻을 수 있습니다.',
    '지출 관리에 신경 쓰면 월말에 여유가 생길 것입니다.',
    '금전적 기회가 찾아올 수 있으니 준비하고 계세요.',
    '오늘은 큰 소비보다는 저축을 생각해보는 것이 좋겠어요.',
    '사업이나 부업에 대한 아이디어가 떠오를 수 있는 날입니다.',
    '꾸준한 노력이 경제적 보상으로 돌아오기 시작합니다.',
    '현명한 소비가 중요한 날이에요. 충동구매를 조심하세요.',
    '재정 계획을 재점검하기 좋은 시기입니다.',
    '나눔의 기쁨이 더 큰 풍요로 돌아올 수 있는 날이에요.',
    '안정적인 수입 흐름이 기대되는 시기입니다. 꾸준히 노력하세요.',
  ];

  static const List<String> healthFortunes = [
    '에너지가 넘치는 날입니다! 운동을 시작해보세요.',
    '충분한 수면이 건강의 비결입니다. 오늘은 일찍 잠자리에 들어보세요.',
    '스트레스 관리가 필요한 날이에요. 명상이나 산책을 추천합니다.',
    '건강한 식습관을 실천하기 좋은 날입니다.',
    '몸과 마음 모두 건강한 에너지가 흐르는 하루예요.',
    '무리하지 말고 적절한 휴식을 취하세요. 내일은 더 나아질 거예요.',
    '물을 충분히 마시고 비타민을 챙기세요. 건강이 곧 재산입니다.',
    '새로운 운동이나 건강 루틴을 시작하기 좋은 시기입니다.',
    '마음의 건강도 중요합니다. 즐거운 활동으로 스트레스를 풀어보세요.',
    '규칙적인 생활 리듬을 유지하면 컨디션이 좋아질 거예요.',
    '자연 속에서 시간을 보내면 몸과 마음이 치유됩니다.',
    '긍정적인 마인드가 건강을 지켜줍니다. 웃음을 잃지 마세요!',
  ];

  static const List<String> luckyColors = [
    '빨간색', '주황색', '노란색', '초록색', '하늘색',
    '파란색', '남색', '보라색', '분홍색', '흰색',
    '금색', '은색',
  ];

  static const List<String> luckyNumbers = [
    '3', '7', '9', '12', '15', '21', '24', '28', '33', '36', '42', '48',
  ];

  static Map<String, String> getDailyFortune(DateTime birthday) {
    final now = DateTime.now();
    final seed = now.year * 10000 + now.month * 100 + now.day +
        birthday.month * 31 + birthday.day;
    final random = Random(seed);

    return {
      'overall': overallFortunes[random.nextInt(overallFortunes.length)],
      'love': loveFortunes[random.nextInt(loveFortunes.length)],
      'money': moneyFortunes[random.nextInt(moneyFortunes.length)],
      'health': healthFortunes[random.nextInt(healthFortunes.length)],
      'luckyColor': luckyColors[random.nextInt(luckyColors.length)],
      'luckyNumber': luckyNumbers[random.nextInt(luckyNumbers.length)],
      'overallScore': '${60 + random.nextInt(41)}',
      'loveScore': '${60 + random.nextInt(41)}',
      'moneyScore': '${60 + random.nextInt(41)}',
      'healthScore': '${60 + random.nextInt(41)}',
    };
  }
}
