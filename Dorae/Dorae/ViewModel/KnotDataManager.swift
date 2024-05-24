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
    var knotList: [Knot] = [
        Knot.basic(knot: 거꾸로나비매듭), Knot.etc(knot: 간격), Knot.basic(knot: 도래매듭), Knot.basic(knot: 장구매듭), Knot.basic(knot: 도래매듭), Knot.basic(knot: 도래매듭), Knot.basic(knot: 잠자리매듭), Knot.basic(knot: 도래매듭), Knot.etc(knot: 간격), Knot.basic(knot: 나비매듭),
        
        Knot.basic(knot: BasicKnot(knotName: .세벌국화매듭, loop: Array(repeating: "", count: 5))), Knot.basic(knot: BasicKnot(knotName: .병아리매듭, loop: Array(repeating: "", count: 2))),
        Knot.applied(knot: AppliedKnot(knotName: .꽃육립매듭, subKnotList: [
            BasicKnot(knotName: .도래매듭),
            BasicKnot(knotName: .생쪽매듭),
            BasicKnot(knotName: .장구매듭),
            BasicKnot(knotName: .도래매듭, knotCount: 4),
            BasicKnot(knotName: .네벌국화매듭, loop: Array(repeating: "", count: 7)),
            BasicKnot(knotName: .도래매듭, knotCount: 4),
            BasicKnot(knotName: .장구매듭),
            BasicKnot(knotName: .생쪽매듭),
            BasicKnot(knotName: .도래매듭)
        ])),
        
        Knot.applied(knot: AppliedKnot(knotName: .지게매듭, subKnotList: [
            BasicKnot(knotName: .도래매듭),
            BasicKnot(knotName: .장구매듭, loop: Array(repeating: "", count: 1)),
            BasicKnot(knotName: .도래매듭),
            BasicKnot(knotName: .가락지매듭, knotCount: 2),
            BasicKnot(knotName: .도래매듭),
            BasicKnot(knotName: .세벌국화매듭, loop: Array(repeating: "", count: 5)),
            BasicKnot(knotName: .도래매듭),
            BasicKnot(knotName: .가락지매듭, knotCount: 2),
            BasicKnot(knotName: .도래매듭),
            BasicKnot(knotName: .장구매듭, loop: Array(repeating: "", count: 1)),
            BasicKnot(knotName: .도래매듭)
        ]))
    ]
    
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
