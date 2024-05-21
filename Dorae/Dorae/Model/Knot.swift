//
//  Knot.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import Foundation

// enum 네이밍 방법이 더 적절하지 않을까요?
enum 매듭 {
    case 기본(매듭: 기본매듭)
    case 응용(매듭: 응용매듭)
    case 길이(매듭: 길이)
    case 끈목(매듭: 끈목)
    case 술(매듭: 술)
}

struct 기본: Identifiable, Hashable {
    var id = UUID()
    let 매듭이름: 기본매듭
    let 매듭이미지: 기본매듭?
    var 귀: [String]?
    var 개수: Int
    
    init(매듭이름: 기본매듭,
         매듭이미지: 기본매듭? = nil,
         귀: [String]? = nil,
         개수: Int = 1) {
        self.매듭이름 = 매듭이름
        self.매듭이미지 = 매듭이미지
        self.귀 = 귀
        self.개수 = 개수
    }
}

struct 응용: Identifiable, Hashable {
    var id = UUID()
    let 매듭이름: 응용매듭
    let 매듭이미지: 응용매듭
    var 하위매듭리스트: [기본] = []
}

struct 길이 {
    var 끈길이: Float
}

enum 끈목 {
    case 극세사, 세사, 중사, 중세사, 태사, 극테사
}

enum 술 {
    case 딸기술, 봉술, 방망이술, 낙지발술, 방울술, 전복술, 금전지술, 잔술

}

enum 기본매듭: String {
    case 도래매듭
    case 귀도래매듭
    case 단추매듭
    case 가락지매듭
    case 생쪽매듭
    case 나비매듭
    case 거꾸로나비매듭    // 응용매듭에만 쓰임
    case 두벌매화
    case 세벌매화
    case 두벌국화
    case 세벌국화
    case 네벌국화
    case 다섯벌국화
    case 병아리매듭
    case 잠자리매듭
    case 동심결매듭
    case 안경매듭
    case 장구매듭
    case 가지방석매듭
    case 귀달린가지방석매듭
    case 딸기매듭
    case 석씨매듭
    case 꼰디기매듭
    case 매미매듭
    case 사색판매듭
}

enum 응용매듭: String {
    case 항아리매듭
    case 지게매듭
    case 왕비국화매듭
    case 육립매듭
    case 꽃육립매듭
    case 공작매듭
    case 쌍공작매듭
    case 스타매듭
}
