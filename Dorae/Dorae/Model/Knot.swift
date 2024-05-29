//
//  Knot.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import Foundation
import SwiftData

enum Knot: Identifiable, Equatable, Codable, Hashable {
    case basic(knot: BasicKnot)
    case applied(knot: AppliedKnot)
    case etc(knot: EtcKnot)
    
    var id: UUID {
        switch self {
        case .basic(let knot): return knot.id
        case .applied(let knot): return knot.id
        case .etc(let knot): return knot.id
        }
    }
    
    // Equatable 프로토콜 준수를 위한 사용자 정의 == 연산자
    static func == (lhs: Knot, rhs: Knot) -> Bool {
        switch (lhs, rhs) {
        case (.basic(let lhsKnot), .basic(let rhsKnot)):
            return lhsKnot == rhsKnot
        case (.applied(let lhsKnot), .applied(let rhsKnot)):
            return lhsKnot == rhsKnot
        case (.etc(let lhsKnot), .etc(let rhsKnot)):
            return lhsKnot == rhsKnot
        default:
            return false
        }
    }
}



struct BasicKnot: Identifiable, Hashable, Codable {
    var id = UUID()
    let knotName: BasicKnotName
    var loop: [String]? = nil
    var knotCount: Int = 1
    var topHeightRatio: CGFloat = 0
    var topWidthRatio: CGFloat = 1
    var bottomHeightRatio: CGFloat = 0
    var bottomWidthRatio: CGFloat = 1
    
    // 기본 초기화 메서드
    init(knotName: BasicKnotName,
         loop: [String]? = nil,
         knotCount: Int = 1,
         topHeightRatio: CGFloat = 0,
         topWidthRatio: CGFloat = 1,
         bottomHeightRatio: CGFloat = 0,
         bottomWidthRatio: CGFloat = 1) {
        self.knotName = knotName
        self.loop = loop
        self.knotCount = knotCount
        self.topHeightRatio = topHeightRatio
        self.topWidthRatio = topWidthRatio
        self.bottomHeightRatio = bottomHeightRatio
        self.bottomWidthRatio = bottomWidthRatio
    }
    
    
    init(basicKnot: BasicKnot) {
        self.knotName = basicKnot.knotName
        self.loop = basicKnot.loop
        self.knotCount = basicKnot.knotCount
        self.topHeightRatio = basicKnot.topHeightRatio
        self.topWidthRatio = basicKnot.topWidthRatio
        self.bottomHeightRatio = basicKnot.bottomHeightRatio
        self.bottomWidthRatio = basicKnot.bottomWidthRatio
    }
}

struct AppliedKnot: Identifiable, Hashable, Codable {
    var id = UUID()
    let knotName: AppliedKnotName
    var subKnotList: [BasicKnot] = []
    
    init(knotName: AppliedKnotName, subKnotList: [BasicKnot] = []) {
        self.knotName = knotName
        self.subKnotList = subKnotList
    }
    
    init(appliedKnot: AppliedKnot) {
        self.knotName = appliedKnot.knotName
        self.subKnotList = appliedKnot.subKnotList
    }
}

struct EtcKnot: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    /// 기타 매듭 이름
    var tassel: String?
    var lasso: String?
    /// 간격의 값
    var interval: Float?
    
    init(id: UUID = UUID(), tassel: String? = nil, lasso: String? = nil, interval: Float? = nil) {
        self.id = id
        self.tassel = tassel
        self.lasso = lasso
        self.interval = interval
    }

    init(etcKnot: EtcKnot) {
        self.tassel = etcKnot.tassel
        self.lasso = etcKnot.lasso
        self.interval = etcKnot.interval
    }
}

enum BasicKnotName: String, CaseIterable, Codable {
    case 도래매듭
    case 귀도래매듭
    case 단추매듭
    case 가락지매듭
    case 생쪽매듭
    case 나비매듭
    case 거꾸로나비매듭    // 응용매듭에만 쓰임
    case 두벌매화매듭
    case 세벌매화매듭
    case 두벌국화매듭
    case 세벌국화매듭
    case 네벌국화매듭
    case 다섯벌국화매듭
    case 병아리매듭
    case 잠자리매듭
    case 동심결매듭
    case 안경매듭
    case 장구매듭
    case 가지방석매듭
    case 딸기매듭
    case 석씨매듭
}

enum AppliedKnotName: String, CaseIterable, Codable {
    case 항아리매듭
    case 지게매듭
    case 육립매듭
    case 꽃육립매듭
    case 공작매듭
    case 스타매듭
}

enum EtcKnotName: String, CaseIterable, Codable {
    case 고
    case 술
    case 간격
}

