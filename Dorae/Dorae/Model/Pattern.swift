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
    static let predefinedTemplates: [Pattern] = [
        Pattern(
            knotList: [
                .etc(knot: EtcKnot(interval: 5)),
                .basic(knot: BasicKnot(knotName: .도래매듭)),
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .basic(knot: BasicKnot(knotName: .도래매듭)),
                .basic(knot: BasicKnot(knotName: .두벌국화매듭)),
                .basic(knot: BasicKnot(knotName: .도래매듭)),
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .basic(knot: BasicKnot(knotName: .도래매듭)),
                .etc(knot: EtcKnot(interval: 5))
            ],
            createdAt: .now,
            title: "진우",
            braid: ""
        ),
        
        Pattern(
            knotList: [
                .etc(knot: EtcKnot(lasso: "고")),
                .basic(knot: BasicKnot(knotName: .도래매듭)),
                .basic(knot: BasicKnot(knotName: .도래매듭)),
                .basic(knot: BasicKnot(knotName: .두벌국화매듭)),
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .basic(knot: BasicKnot(knotName: .병아리매듭)),
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .applied(knot: AppliedKnot(knotName: .스타매듭)),
                .basic(knot: BasicKnot(knotName: .세벌국화매듭)),
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .basic(knot: BasicKnot(knotName: .병아리매듭)),
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .basic(knot: BasicKnot(knotName: .병아리매듭)),
                .etc(knot: EtcKnot(tassel: "술"))
            ],
            createdAt: .now,
            title: "루미",
            braid: ""
        ),
        
        Pattern(
            knotList: [
                .etc(knot: EtcKnot(lasso: "고")),
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .basic(knot: BasicKnot(knotName: .장구매듭)),
                .basic(knot: BasicKnot(knotName: .생쪽매듭)),
                .basic(knot: BasicKnot(knotName: .장구매듭)),
                .basic(knot: BasicKnot(knotName: .나비매듭)),
                .etc(knot: EtcKnot(tassel: "술"))
            ],
            createdAt: .now,
            title: "조이",
            braid: ""
        ),
        
        Pattern(
            knotList: [
                .etc(knot: EtcKnot(lasso: "고")),
                .basic(knot: BasicKnot(knotName: .도래매듭)),
                .basic(knot: BasicKnot(knotName: .두벌국화매듭)),
                .basic(knot: BasicKnot(knotName: .도래매듭)),
                .etc(knot: EtcKnot(tassel: "술"))
            ],
            createdAt: .now,
            title: "미라",
            braid: ""
        )
    ]
}
