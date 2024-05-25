//
//  KnotDataManager.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import Foundation
import SwiftData


@Observable
final class KnotDataManager {
    /// 줄글 도안과 이미지 도안에서 참조할 Knot 리스트
    var knotList: [Knot] = []
    
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
            }else if let knot = knot.lasso {
                knotName = "고"
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
