//
//  KnotView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

enum KnotCategory {
    case basicCategory
    case appliedCategory
    case etcCategory
}

struct KnotListView: View {
    @State private var selectedTab: KnotCategory = .basicCategory
    @Bindable var pattern: Pattern
    
    let basicKnotNameList = BasicKnotName.allCases.map { knot in knot.rawValue }
    let appliedKnotNameList = AppliedKnotName.allCases.map { knot in knot.rawValue }
    let etcKnotNameList = EtcKnotName.allCases.map { knot in knot.rawValue }
    
    var body: some View {
        HStack(spacing: 0) {
            switch selectedTab {
            case .basicCategory:
                KnotButtonListView(pattern: pattern, selectedTab: $selectedTab, knotNameList: basicKnotNameList)
            case .appliedCategory:
                KnotButtonListView(pattern: pattern, selectedTab: $selectedTab, knotNameList: appliedKnotNameList)
            case .etcCategory:
                KnotButtonListView(pattern: pattern, selectedTab: $selectedTab, knotNameList: etcKnotNameList)
            }
            
            VStack(spacing: 0) {
                CategoryTabButton(title: "기본", isSelected: selectedTab == .basicCategory) {
                    selectedTab = .basicCategory
                }
                
                CategoryTabButton(title: "응용", isSelected: selectedTab == .appliedCategory) {
                    selectedTab = .appliedCategory
                }
                
                CategoryTabButton(title: "기타", isSelected: selectedTab == .etcCategory) {
                    selectedTab = .etcCategory
                }
                Spacer()
            }
            .padding(.top, 50)
            .background(Color.knotMenuBar)
        }
        .background(Color.knotMenuBG)
        .roundedCorner(24, corners: [.bottomLeft, .topLeft])
    }
}
