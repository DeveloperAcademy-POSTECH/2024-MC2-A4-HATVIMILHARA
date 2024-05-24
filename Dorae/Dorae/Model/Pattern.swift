//
//  Pattern.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import Foundation

struct Pattern: Identifiable {
    var id = UUID()
    var knotList: [Knot]
    let createdAt: String
    let title: String
    var braid: String = ""
}
