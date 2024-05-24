//
//  Knot.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import Foundation

enum Knot: Identifiable {
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
}

struct BasicKnot: Identifiable, Hashable {
    var id = UUID()
    let knotName: BasicKnotName
    var loop: [String]? = nil
    var knotCount: Int = 1
    var topHeightRatio: CGFloat = 0
    var topWidthRatio: CGFloat = 1
    var bottomHeightRatio: CGFloat = 0
    var bottomWidthRatio: CGFloat = 1
}

struct AppliedKnot: Identifiable, Hashable {
    var id = UUID()
    let knotName: AppliedKnotName
    var subKnotList: [BasicKnot] = []
}

struct EtcKnot: Identifiable {
    let id = UUID()
    /// 기타 매듭 이름
    var tassel: String?
    var lasso: String?
    /// 간격의 값
    var interval: Float?
}

enum BasicKnotName: String, CaseIterable {
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
    case 딸기매듭
    case 석씨매듭
    case 매미매듭
}

enum AppliedKnotName: String, CaseIterable {
    case 항아리매듭
    case 지게매듭
    case 육립매듭
    case 꽃육립매듭
    case 공작매듭
    case 스타매듭
}

enum EtcKnotName: String, CaseIterable {
    case 고
    case 술
    case 간격
}
