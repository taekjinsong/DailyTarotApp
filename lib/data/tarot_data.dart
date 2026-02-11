import '../models/tarot_card.dart';

class TarotData {
  static const List<TarotCard> majorArcana = [
    TarotCard(
      id: 0,
      name: 'The Fool',
      nameKo: '광대',
      imagePath: 'assets/cards/major_00.png',
      keywords: '새로운 시작, 모험, 순수, 자유',
      reverseKeywords: '무모함, 부주의, 위험, 경솔',
      description:
          '새로운 여정이 시작되려 합니다. 두려움 없이 첫 발을 내딛으세요. '
          '순수한 마음으로 세상을 바라보면 예상치 못한 행운이 찾아올 것입니다. '
          '지금은 계획보다 직감을 믿을 때입니다.',
      reverseDescription:
          '지금은 조금 더 신중해질 필요가 있습니다. '
          '충동적인 결정은 후회를 남길 수 있으니 한 번 더 생각해보세요. '
          '주변의 조언에 귀를 기울이는 것이 현명합니다.',
    ),
    TarotCard(
      id: 1,
      name: 'The Magician',
      nameKo: '마법사',
      imagePath: 'assets/cards/major_01.png',
      keywords: '창조력, 의지, 능력, 집중',
      reverseKeywords: '속임, 미숙, 재능 낭비, 우유부단',
      description:
          '당신에게는 원하는 것을 이룰 수 있는 모든 도구가 갖춰져 있습니다. '
          '자신의 능력을 믿고 행동으로 옮기세요. '
          '집중력을 발휘하면 놀라운 결과를 만들어낼 수 있습니다.',
      reverseDescription:
          '가진 재능을 충분히 활용하지 못하고 있습니다. '
          '자신을 과소평가하지 말고, 실력을 발휘할 기회를 만드세요. '
          '겉모습에 현혹되지 않도록 주의하세요.',
    ),
    TarotCard(
      id: 2,
      name: 'The High Priestess',
      nameKo: '여사제',
      imagePath: 'assets/cards/major_02.png',
      keywords: '직감, 지혜, 신비, 내면의 소리',
      reverseKeywords: '비밀, 혼란, 직감 무시, 표면적 판단',
      description:
          '내면의 목소리에 귀를 기울이세요. '
          '지금은 행동보다 관찰과 성찰이 필요한 시기입니다. '
          '숨겨진 진실이 곧 드러날 것이니 인내심을 가지세요.',
      reverseDescription:
          '직감을 무시하고 있지는 않나요? '
          '너무 이성적으로만 판단하려 하면 중요한 것을 놓칠 수 있습니다. '
          '감추고 있는 감정을 솔직히 마주해보세요.',
    ),
    TarotCard(
      id: 3,
      name: 'The Empress',
      nameKo: '여황제',
      imagePath: 'assets/cards/major_03.png',
      keywords: '풍요, 모성, 자연, 창조',
      reverseKeywords: '의존, 과보호, 창조력 부족, 공허',
      description:
          '풍요와 사랑이 넘치는 시기입니다. '
          '창조적인 에너지가 샘솟고 있으니 새로운 프로젝트를 시작해보세요. '
          '주변 사람들에게 따뜻한 관심을 나누면 더 큰 행복이 돌아옵니다.',
      reverseDescription:
          '타인에게 너무 의존하고 있지는 않나요? '
          '자신만의 힘으로 설 수 있는 독립심을 키워보세요. '
          '내면의 창조력을 다시 일깨울 시간입니다.',
    ),
    TarotCard(
      id: 4,
      name: 'The Emperor',
      nameKo: '황제',
      imagePath: 'assets/cards/major_04.png',
      keywords: '권위, 안정, 리더십, 구조',
      reverseKeywords: '독재, 경직, 통제욕, 미성숙',
      description:
          '확고한 의지와 리더십으로 상황을 이끌어 나갈 때입니다. '
          '체계적인 계획을 세우고 단계적으로 실행하세요. '
          '안정적인 기반을 다지면 큰 성과를 이룰 수 있습니다.',
      reverseDescription:
          '지나친 통제와 고집은 오히려 역효과를 낳습니다. '
          '유연한 사고와 타인의 의견을 수용하는 자세가 필요합니다. '
          '권위보다는 소통으로 문제를 해결해보세요.',
    ),
    TarotCard(
      id: 5,
      name: 'The Hierophant',
      nameKo: '교황',
      imagePath: 'assets/cards/major_05.png',
      keywords: '전통, 가르침, 신앙, 멘토',
      reverseKeywords: '반항, 비전통, 새로운 접근, 자유',
      description:
          '경험 많은 사람의 조언을 구해보세요. '
          '전통적인 방법과 검증된 길이 지금 당신에게 가장 적합합니다. '
          '배움의 자세를 유지하면 귀중한 깨달음을 얻게 됩니다.',
      reverseDescription:
          '기존의 틀에서 벗어나 새로운 시도를 해볼 때입니다. '
          '자신만의 가치관과 신념을 세워나가세요. '
          '남들의 기대에 맞추기보다 자신의 길을 걸어보세요.',
    ),
    TarotCard(
      id: 6,
      name: 'The Lovers',
      nameKo: '연인',
      imagePath: 'assets/cards/major_06.png',
      keywords: '사랑, 조화, 선택, 가치관',
      reverseKeywords: '불화, 유혹, 잘못된 선택, 불균형',
      description:
          '중요한 선택의 기로에 서 있습니다. '
          '마음의 소리를 따르되 신중하게 결정하세요. '
          '진정한 사랑과 조화로운 관계가 당신을 기다리고 있습니다.',
      reverseDescription:
          '관계에서 불균형이 느껴지고 있나요? '
          '솔직한 대화를 통해 서로의 마음을 확인해보세요. '
          '유혹에 흔들리지 말고 진정으로 소중한 것이 무엇인지 생각해보세요.',
    ),
    TarotCard(
      id: 7,
      name: 'The Chariot',
      nameKo: '전차',
      imagePath: 'assets/cards/major_07.png',
      keywords: '승리, 의지, 결단력, 전진',
      reverseKeywords: '좌절, 방향상실, 공격성, 통제 불능',
      description:
          '강한 의지로 앞으로 나아가세요! '
          '어떤 장애물도 당신의 결단력 앞에서는 무너질 것입니다. '
          '목표를 향해 흔들림 없이 전진하면 승리가 기다립니다.',
      reverseDescription:
          '너무 무리하게 밀어붙이고 있지는 않나요? '
          '잠시 멈춰서 방향을 재점검해보세요. '
          '감정을 조절하고 냉정함을 유지하는 것이 중요합니다.',
    ),
    TarotCard(
      id: 8,
      name: 'Strength',
      nameKo: '힘',
      imagePath: 'assets/cards/major_08.png',
      keywords: '용기, 인내, 내면의 힘, 자비',
      reverseKeywords: '자기 의심, 나약함, 불안, 포기',
      description:
          '진정한 힘은 부드러움에서 나옵니다. '
          '인내와 자비로 어려움을 극복할 수 있습니다. '
          '자신의 내면에 있는 무한한 힘을 믿으세요.',
      reverseDescription:
          '자신감이 부족하다고 느끼고 있나요? '
          '당신은 생각보다 훨씬 강한 사람입니다. '
          '두려움에 지지 말고 한 걸음씩 나아가세요.',
    ),
    TarotCard(
      id: 9,
      name: 'The Hermit',
      nameKo: '은둔자',
      imagePath: 'assets/cards/major_09.png',
      keywords: '성찰, 고독, 지혜, 내면 탐구',
      reverseKeywords: '고립, 외로움, 현실 도피, 은둔',
      description:
          '혼자만의 시간이 필요한 때입니다. '
          '내면을 깊이 들여다보며 진정한 자아를 발견하세요. '
          '고요 속에서 찾은 지혜가 앞으로의 길을 밝혀줄 것입니다.',
      reverseDescription:
          '너무 오래 혼자 있었던 것은 아닌가요? '
          '세상 밖으로 나와 사람들과 교류해보세요. '
          '고립은 답이 아닙니다. 도움을 요청하는 것도 용기입니다.',
    ),
    TarotCard(
      id: 10,
      name: 'Wheel of Fortune',
      nameKo: '운명의 수레바퀴',
      imagePath: 'assets/cards/major_10.png',
      keywords: '행운, 변화, 순환, 전환점',
      reverseKeywords: '불운, 저항, 변화 거부, 혼란',
      description:
          '운명의 바퀴가 돌아가고 있습니다. '
          '좋은 변화가 다가오고 있으니 기회를 놓치지 마세요. '
          '흐름에 몸을 맡기면 예상치 못한 행운을 만나게 됩니다.',
      reverseDescription:
          '일이 뜻대로 풀리지 않는다고 좌절하지 마세요. '
          '지금의 어려움은 일시적입니다. '
          '변화를 받아들이고 적응하면 곧 상황이 호전됩니다.',
    ),
    TarotCard(
      id: 11,
      name: 'Justice',
      nameKo: '정의',
      imagePath: 'assets/cards/major_11.png',
      keywords: '공정, 진실, 균형, 책임',
      reverseKeywords: '불공정, 편견, 회피, 부정직',
      description:
          '공정하고 균형 잡힌 판단이 필요한 시기입니다. '
          '진실은 반드시 밝혀지며, 정직한 행동은 보상받을 것입니다. '
          '자신의 행동에 책임을 지는 자세가 좋은 결과를 가져옵니다.',
      reverseDescription:
          '무언가 불공평하다고 느끼고 있나요? '
          '감정에 치우치지 말고 객관적으로 상황을 바라보세요. '
          '정직하지 못한 부분이 있다면 바로잡을 때입니다.',
    ),
    TarotCard(
      id: 12,
      name: 'The Hanged Man',
      nameKo: '매달린 사람',
      imagePath: 'assets/cards/major_12.png',
      keywords: '희생, 새로운 관점, 기다림, 깨달음',
      reverseKeywords: '지연, 저항, 무의미한 희생, 이기심',
      description:
          '관점을 바꿔보세요. 다른 각도에서 보면 새로운 해답이 보입니다. '
          '지금은 행동보다 기다림이 필요한 시기입니다. '
          '때로는 멈춤이 가장 빠른 길일 수 있습니다.',
      reverseDescription:
          '불필요한 희생을 하고 있지는 않나요? '
          '상황을 바꿀 수 없다면 자신을 바꿔보세요. '
          '더 이상의 지연은 오히려 해가 될 수 있습니다.',
    ),
    TarotCard(
      id: 13,
      name: 'Death',
      nameKo: '죽음',
      imagePath: 'assets/cards/major_13.png',
      keywords: '변화, 끝과 시작, 변환, 해방',
      reverseKeywords: '변화 거부, 집착, 정체, 두려움',
      description:
          '하나의 장이 끝나고 새로운 장이 시작됩니다. '
          '과거를 놓아주세요. 끝은 곧 새로운 시작을 의미합니다. '
          '변화를 두려워하지 마세요. 더 나은 내일이 기다립니다.',
      reverseDescription:
          '변화를 거부하고 과거에 집착하고 있나요? '
          '놓아야 할 것을 놓아주지 못하면 앞으로 나아갈 수 없습니다. '
          '용기를 내어 새로운 시작을 받아들이세요.',
    ),
    TarotCard(
      id: 14,
      name: 'Temperance',
      nameKo: '절제',
      imagePath: 'assets/cards/major_14.png',
      keywords: '균형, 조화, 인내, 중용',
      reverseKeywords: '과도함, 불균형, 조급함, 갈등',
      description:
          '균형과 조화가 핵심입니다. '
          '극단적인 선택보다는 중용의 길을 택하세요. '
          '인내심을 가지고 천천히 조율하면 최상의 결과를 얻습니다.',
      reverseDescription:
          '생활의 균형이 무너지고 있습니다. '
          '일과 휴식, 이성과 감성 사이의 조화를 찾아보세요. '
          '과도한 것은 줄이고 부족한 것은 채워나가세요.',
    ),
    TarotCard(
      id: 15,
      name: 'The Devil',
      nameKo: '악마',
      imagePath: 'assets/cards/major_15.png',
      keywords: '유혹, 속박, 물질주의, 그림자',
      reverseKeywords: '해방, 자각, 극복, 자유',
      description:
          '무언가에 지나치게 집착하고 있지는 않나요? '
          '눈앞의 유혹에 현혹되지 마세요. '
          '진정한 자유는 내면의 속박에서 벗어날 때 찾아옵니다.',
      reverseDescription:
          '속박에서 벗어나려는 의지가 보입니다. '
          '나쁜 습관이나 부정적인 관계를 끊어낼 용기를 가지세요. '
          '자유를 향한 첫 발걸음을 응원합니다.',
    ),
    TarotCard(
      id: 16,
      name: 'The Tower',
      nameKo: '탑',
      imagePath: 'assets/cards/major_16.png',
      keywords: '급변, 파괴, 깨달음, 해방',
      reverseKeywords: '변화 회피, 재난 모면, 지연된 파괴, 두려움',
      description:
          '예상치 못한 변화가 찾아올 수 있습니다. '
          '하지만 이것은 더 단단한 기초를 다지기 위한 과정입니다. '
          '무너진 자리에서 더 강하게 다시 세워질 것입니다.',
      reverseDescription:
          '다가올 변화를 피하려 하고 있나요? '
          '언젠가는 마주해야 할 문제를 미루지 마세요. '
          '작은 변화를 통해 큰 충격을 완화할 수 있습니다.',
    ),
    TarotCard(
      id: 17,
      name: 'The Star',
      nameKo: '별',
      imagePath: 'assets/cards/major_17.png',
      keywords: '희망, 영감, 평화, 치유',
      reverseKeywords: '절망, 의기소침, 자신감 부족, 단절',
      description:
          '어둠 뒤에 반드시 빛이 찾아옵니다. '
          '희망을 잃지 마세요. 우주가 당신을 응원하고 있습니다. '
          '마음의 평화를 찾고 영감을 따라가면 꿈이 이루어집니다.',
      reverseDescription:
          '희망을 잃어가고 있나요? '
          '아무리 어두운 밤도 반드시 아침이 옵니다. '
          '작은 것에서부터 감사와 기쁨을 찾아보세요.',
    ),
    TarotCard(
      id: 18,
      name: 'The Moon',
      nameKo: '달',
      imagePath: 'assets/cards/major_18.png',
      keywords: '환상, 불안, 잠재의식, 직감',
      reverseKeywords: '혼란 해소, 진실 발견, 두려움 극복, 명확',
      description:
          '모든 것이 명확하지 않은 시기입니다. '
          '겉으로 보이는 것이 전부가 아닐 수 있으니 주의하세요. '
          '직감을 믿되, 중요한 결정은 조금 미루는 것이 좋습니다.',
      reverseDescription:
          '안개가 걷히고 진실이 드러나기 시작합니다. '
          '두려움을 극복하고 현실을 직시할 힘이 생기고 있습니다. '
          '혼란스러운 시기가 지나가고 있으니 조금만 더 힘내세요.',
    ),
    TarotCard(
      id: 19,
      name: 'The Sun',
      nameKo: '태양',
      imagePath: 'assets/cards/major_19.png',
      keywords: '기쁨, 성공, 활력, 긍정',
      reverseKeywords: '일시적 좌절, 낙관 과잉, 지연된 성공, 우울',
      description:
          '밝은 에너지가 당신을 감싸고 있습니다! '
          '기쁨과 성공이 가득한 시기이니 자신감을 가지세요. '
          '긍정적인 마음가짐이 더 큰 행운을 끌어당깁니다.',
      reverseDescription:
          '잠시 구름에 가려진 태양과 같습니다. '
          '일시적인 어려움일 뿐, 곧 다시 빛날 것입니다. '
          '지나친 낙관보다는 현실적인 계획을 세워보세요.',
    ),
    TarotCard(
      id: 20,
      name: 'Judgement',
      nameKo: '심판',
      imagePath: 'assets/cards/major_20.png',
      keywords: '부활, 각성, 결단, 소명',
      reverseKeywords: '자기 비판, 후회, 결정 회피, 자책',
      description:
          '중요한 결정의 시간이 다가왔습니다. '
          '과거를 돌아보고 교훈을 얻되, 미래를 향해 나아가세요. '
          '내면의 부름에 응답하면 새로운 차원의 삶이 열립니다.',
      reverseDescription:
          '과거의 실수에 얽매여 있지는 않나요? '
          '자책보다는 용서와 수용이 필요합니다. '
          '결정을 미루지 말고 용기 있게 선택하세요.',
    ),
    TarotCard(
      id: 21,
      name: 'The World',
      nameKo: '세계',
      imagePath: 'assets/cards/major_21.png',
      keywords: '완성, 성취, 통합, 여행',
      reverseKeywords: '미완성, 지연, 부족함, 미련',
      description:
          '하나의 큰 순환이 완성되는 순간입니다. '
          '그동안의 노력이 결실을 맺고 있습니다. 축하합니다! '
          '성취의 기쁨을 누리며 다음 여정을 준비하세요.',
      reverseDescription:
          '거의 다 왔지만 마지막 한 걸음이 남아있습니다. '
          '포기하지 마세요. 완성까지 조금만 더 힘을 내세요. '
          '부족한 부분을 채우면 원하는 결과를 얻을 수 있습니다.',
    ),
  ];

  static TarotCard getCardById(int id) {
    return majorArcana.firstWhere((card) => card.id == id);
  }
}
