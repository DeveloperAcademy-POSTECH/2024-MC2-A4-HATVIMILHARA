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


