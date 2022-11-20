import Foundation

struct DummyItems {
    var type: String = .init()
    var title: String = .init()
    var content: String = .init()
    var writer: String = .init()
    var created_at: String = .init()
}

class Dummies {
    let entireItem1 = DummyItems.self (
        title: "플라잉 디스크 사용 안내",
        content: """
        최근 운동장에서 플라잉 디스크 사용 후 정리를 안 하는 학우들이 있습니다. 오늘 부로 정리를 제대로 하지 않는다는 제보가 들어올 시 해당 학우를 대상으로 제3 고문실에서 마법천자문을 아낌없이 제공할예정이오니참고 바...
        """,
        created_at: "방금 전"
    )
    let entireItem2 = DummyItems.self (
        title: "운동장 사용 규칙",
        content: """
    운동장 사용 규칙에 관한 안내 사항입니다. \
    1. 쓰레기 무단 투기 금지 \
    2. 관련 담당자 허가 없이 체육관 출입 금지 \
    3. 고양이 쓰다듬고 꼭 비누로 손 닦기...
    """,
        created_at: "2시간 전"
    )
    let categoryItem1 = DummyItems.self (
        type: "농구",
        title: "농구공 사용 안내",
        content: "농구공으로 축구하지 마세요.",
        created_at: "2일 전"
    )
    let categoryItem2 = DummyItems.self (
        type: "배드민턴",
        title: "배드민턴 라켓 사용 안내",
        content: """
        요즘 들어서 배드민턴 친선전을 진행하는 학생들이 더욱 많아진 듯 합니다. 라켓 사용이 많아진 만큼 라켓의 손상도 심해지고 있습니다. 라켓으로 바닥을 내리치지 말아주시고 친구와 라켓으로 칼싸움할 바엔 진검 사용이 더욱...
        """,
        created_at: "26일 전"
    )
}
