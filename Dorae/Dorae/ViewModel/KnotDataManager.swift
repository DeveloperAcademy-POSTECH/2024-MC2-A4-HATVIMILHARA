//
//  KnotDataManager.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import Foundation

@Observable
final class KnotDataManager {
    /// 줄글 도안과 이미지 도안에서 참조할 Knot 리스트
    var knotList: [Knot] = [Knot.basic(knot: 거꾸로나비매듭), Knot.etc(knot: 간격), Knot.basic(knot: 도래매듭), Knot.basic(knot: 장구매듭), Knot.basic(knot: 도래매듭), Knot.basic(knot: 도래매듭), Knot.basic(knot: 잠자리매듭), Knot.basic(knot: 도래매듭), Knot.etc(knot: 간격), Knot.basic(knot: 나비매듭)]
    
    func getKnotName(knot: Knot) -> String {
        var knotName = ""
        switch knot {
        case .basic(let knot):
            knotName = knot.knotName.rawValue
        case .applied(let knot):
            knotName = knot.knotName.rawValue
        case .etc(let knot):
            if let knot = knot.interval {
                knotName = "간격"
            }else if let knot = knot.tassel {
                knotName = "술"
            }
        }
        return knotName
    }
    
    func getBasicKnotData(knot: Knot) -> BasicKnot? {
        var basicKnot: BasicKnot?
        switch knot {
        case .basic(let knot):
            basicKnot = knot
        default:
            break
        }
        return basicKnot
    }
}
