//
//  PatternDummy.swift
//  Dorae
//
//  Created by yegang on 5/22/24.
//

import Foundation

final class PatternDummy {
    static var patternList: [Pattern] = [
        Pattern(knotList: [
            .etc(knot: EtcKnot(interval: 0)),
            .etc(knot: EtcKnot(lasso: "lasso가 뭐야")),
//            .basic(knot: 도래매듭),
//            .basic(knot: 귀도래매듭),
//            .applied(knot: 항아리매듭),
//            .applied(knot: 육립매듭),
//            .applied(knot: 공작매듭),
//            .applied(knot: 스타매듭)
        ],createdAt: "2000.01.11", title: "첫 번째 도안"),
        
        Pattern(knotList: [
            .basic(knot: 도래매듭),
            .basic(knot: 귀도래매듭),
            .applied(knot: 항아리매듭)
        ],createdAt: "2010.02.22", title: "두 번째 도안"),
        
        Pattern(knotList: [
            .basic(knot: 도래매듭),
            .basic(knot: 귀도래매듭),
            .applied(knot: 항아리매듭)
        ],createdAt: "2020.03.33", title: "세 번째 도안"),
    ]
}
