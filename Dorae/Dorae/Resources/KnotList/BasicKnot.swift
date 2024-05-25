//
//  BasicKnot.swift
//  Dorae
//
//  Created by 지영 on 5/20/24.
//

import Foundation


let 도래매듭 = BasicKnot(knotName: .도래매듭)
let 귀도래매듭 = BasicKnot(knotName: .귀도래매듭, loop: Array(repeating: "", count: 1))
let 단추매듭 = BasicKnot(knotName: .단추매듭)
let 가락지매듭 = BasicKnot(knotName: .가락지매듭)
let 생쪽매듭 = BasicKnot(knotName: .생쪽매듭, loop: Array(repeating: "", count: 1))
let 나비매듭 = BasicKnot(knotName: .나비매듭, loop: Array(repeating: "", count: 1), topHeightRatio: 0.32, topWidthRatio: 0.43)
let 거꾸로나비매듭 = BasicKnot(knotName: .거꾸로나비매듭, loop: Array(repeating: "", count: 1), bottomHeightRatio: 0.32, bottomWidthRatio: 0.43)
let 두벌매화매듭 = BasicKnot(knotName: .두벌매화매듭, loop: Array(repeating: "", count: 2))
let 세벌매화매듭 = BasicKnot(knotName: .세벌매화매듭, loop: Array(repeating: "", count: 3))
let 두벌국화매듭 = BasicKnot(knotName: .두벌국화매듭, loop: Array(repeating: "", count: 3))
let 세벌국화매듭 = BasicKnot(knotName: .세벌국화매듭, loop: Array(repeating: "", count: 5))
let 네벌국화매듭 = BasicKnot(knotName: .네벌국화매듭, loop: Array(repeating: "", count: 7))
let 다섯벌국화매듭 = BasicKnot(knotName: .다섯벌국화매듭, loop: Array(repeating: "", count: 9))
let 병아리매듭 = BasicKnot(knotName: .병아리매듭, loop: Array(repeating: "", count: 2))
let 잠자리매듭 = BasicKnot(knotName: .잠자리매듭)
let 동심결매듭 = BasicKnot(knotName: .동심결매듭, loop: Array(repeating: "", count: 2))
let 안경매듭 = BasicKnot(knotName: .안경매듭)
let 장구매듭 = BasicKnot(knotName: .장구매듭, loop: Array(repeating: "", count: 1), topHeightRatio: 0.13, topWidthRatio: 0.33, bottomHeightRatio: 0.13, bottomWidthRatio: 0.33)
let 가지방석매듭 = BasicKnot(knotName: .가지방석매듭)
let 딸기매듭 = BasicKnot(knotName: .딸기매듭)
let 석씨매듭 = BasicKnot(knotName: .석씨매듭)

let basicKnotCollection: [BasicKnot] = [
    도래매듭,
    귀도래매듭,
    단추매듭,
    가락지매듭,
    생쪽매듭,
    나비매듭,
    거꾸로나비매듭,
    두벌매화매듭,
    세벌매화매듭,
    두벌국화매듭,
    세벌국화매듭,
    네벌국화매듭,
    다섯벌국화매듭,
    병아리매듭,
    잠자리매듭,
    동심결매듭,
    안경매듭,
    장구매듭,
    가지방석매듭,
    딸기매듭,
    석씨매듭,
]
