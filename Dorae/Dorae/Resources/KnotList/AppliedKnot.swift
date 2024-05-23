//
//  AppliedKnot.swift
//  Dorae
//
//  Created by 지영 on 5/20/24.
//

import Foundation

let 육립매듭 = AppliedKnot(knotName: .육립매듭, subKnotList: [
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .거꾸로나비매듭),
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .생쪽매듭),
    BasicKnot(knotName: .도래매듭, knotCount: 2),
    BasicKnot(knotName: .네벌국화, loop: Array(repeating: "", count: 7)),
    BasicKnot(knotName: .도래매듭, knotCount: 2),
    BasicKnot(knotName: .생쪽매듭),
    BasicKnot(knotName: .도래매듭)
])

let 항아리매듭 = AppliedKnot(knotName: .항아리매듭, subKnotList: [
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .장구매듭, loop: Array(repeating: "", count: 1)),
    BasicKnot(knotName: .도래매듭, knotCount: 3),
    BasicKnot(knotName: .생쪽매듭, loop: Array(repeating: "", count: 1)),
    BasicKnot(knotName: .가락지매듭, knotCount: 3),
    BasicKnot(knotName: .세벌국화, loop: Array(repeating: "", count: 5)),
    BasicKnot(knotName: .도래매듭)
])

let 꽃육립매듭 = AppliedKnot(knotName: .꽃육립매듭, subKnotList: [
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .생쪽매듭),
    BasicKnot(knotName: .장구매듭),
    BasicKnot(knotName: .도래매듭, knotCount: 4),
    BasicKnot(knotName: .네벌국화, loop: Array(repeating: "", count: 7)),
    BasicKnot(knotName: .도래매듭, knotCount: 4),
    BasicKnot(knotName: .장구매듭),
    BasicKnot(knotName: .생쪽매듭),
    BasicKnot(knotName: .도래매듭)
])

let 지게매듭 = AppliedKnot(knotName: .지게매듭, subKnotList: [
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .장구매듭, loop: Array(repeating: "", count: 1)),
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .가락지매듭, knotCount: 2),
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .세벌국화, loop: Array(repeating: "", count: 5)),
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .가락지매듭, knotCount: 2),
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .장구매듭, loop: Array(repeating: "", count: 1)),
    BasicKnot(knotName: .도래매듭)
])

let 스타매듭 = AppliedKnot(knotName: .스타매듭, subKnotList: [
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .세벌국화, loop: Array(repeating: "", count: 5)),
    BasicKnot(knotName: .도래매듭, knotCount: 2),
    BasicKnot(knotName: .생쪽매듭),
    BasicKnot(knotName: .다섯벌국화),
    BasicKnot(knotName: .생쪽매듭),
    BasicKnot(knotName: .다섯벌국화),
    BasicKnot(knotName: .생쪽매듭),
    BasicKnot(knotName: .도래매듭)
])

let 공작매듭 = AppliedKnot(knotName: .공작매듭, subKnotList: [
    BasicKnot(knotName: .나비매듭),
    BasicKnot(knotName: .도래매듭, knotCount: 2),
    BasicKnot(knotName: .생쪽매듭, loop: Array(repeating: "", count: 5), knotCount: 9),
    BasicKnot(knotName: .생쪽매듭, loop: Array(repeating: "", count: 5), knotCount: 9),
    BasicKnot(knotName: .장구매듭),
    BasicKnot(knotName: .도래매듭),
    BasicKnot(knotName: .장구매듭),
    BasicKnot(knotName: .도래매듭)
])

let appliedKnotCollection: [AppliedKnot] = [
    육립매듭,
    항아리매듭,
    꽃육립매듭,
    지게매듭,
    스타매듭,
    공작매듭
]
