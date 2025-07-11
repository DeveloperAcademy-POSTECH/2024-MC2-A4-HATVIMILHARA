//
//  Pattern.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import Foundation
import SwiftData

@Model
class Pattern: Identifiable {
    @Attribute(.unique) var id = UUID()
    var knotList: [Knot]
    var createdAt: Date
    var title: String
    var braid: String = ""
    
    init(knotList: [Knot], createdAt: Date, title: String, braid: String) {
        self.knotList = knotList
        self.createdAt = createdAt
        self.title = title
        self.braid = braid
    }
}

extension Pattern {
    // TODO: 매듭 수정할것
    static let predefinedTemplates: [Pattern] = [
        Pattern(
            knotList: [
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .etc(knot: EtcKnot(interval: 12)),
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .etc(knot: EtcKnot(interval: 12)),
                .basic(knot: BasicKnot(knotName: .생쪽매듭))
            ],
            createdAt: .now,
            title: "진우",
            braid: ""
        ),
        
        Pattern(
            knotList: [
                .etc(knot: EtcKnot(lasso: "고")),
                .applied(knot: AppliedKnot(knotName: .육립매듭)),
                .etc(knot: EtcKnot(tassel: "술"))
            ],
            createdAt: .now,
            title: "루미",
            braid: ""
        ),
        
        Pattern(
            knotList: [
                .etc(knot: EtcKnot(lasso: "고")),
                .applied(knot: AppliedKnot(knotName: .지게매듭)),
                .etc(knot: EtcKnot(tassel: "술"))
            ],
            createdAt: .now,
            title: "조이",
            braid: ""
        ),
        
        Pattern(
            knotList: [
                .etc(knot: EtcKnot(lasso: "고")),
                .applied(knot: AppliedKnot(knotName: .항아리매듭)),
                .etc(knot: EtcKnot(tassel: "술"))
            ],
            createdAt: .now,
            title: "미라",
            braid: ""
        )
    ]
}
