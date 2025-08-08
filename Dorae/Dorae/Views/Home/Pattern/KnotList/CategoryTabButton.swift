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
    
    private var adaptivePadding: CGFloat {
        let locale = Locale.current.language.languageCode?.identifier ?? "ko"
        switch locale {
        case "en": return 4
        case "ja": return 14
        default: return 20
        }
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2.bold())
                .padding(.horizontal, adaptivePadding)
                .padding(.vertical, 20)
                .foregroundColor(isSelected ? Color.knotMenuBar: .white)
                .frame(maxWidth: .infinity)
        }
        .background(isSelected ? Color.knotMenuBG: Color.knotMenuBar)
    }
}
