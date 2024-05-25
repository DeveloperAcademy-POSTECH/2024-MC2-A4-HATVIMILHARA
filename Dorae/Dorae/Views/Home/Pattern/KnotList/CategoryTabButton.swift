//
//  CategoryTabButton.swift
//  Dorae
//
//  Created by 지영 on 5/26/24.
//

import SwiftUI

struct CategoryTabButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2.bold())
                .foregroundColor(isSelected ? Color.knotMenuBar: .white)
        }
        .padding(20)
        .background(isSelected ? Color.knotMenuBG: Color.knotMenuBar)
    }
}
