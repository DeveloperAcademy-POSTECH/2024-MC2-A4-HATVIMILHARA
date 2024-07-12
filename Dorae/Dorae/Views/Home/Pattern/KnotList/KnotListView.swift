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
    @Binding var isFolding : Bool

    let basicKnotNameList = BasicKnotName.allCases.map { knot in knot.rawValue }
    let appliedKnotNameList = AppliedKnotName.allCases.map { knot in knot.rawValue }
    let etcKnotNameList = EtcKnotName.allCases.map { knot in knot.rawValue }
    
    var body: some View {
        HStack(spacing: 0) {
            if isFolding {
                switch selectedTab {
                case .basicCategory:
                    KnotButtonListView(pattern: pattern, selectedTab: $selectedTab, knotNameList: basicKnotNameList)
                case .appliedCategory:
                    KnotButtonListView(pattern: pattern, selectedTab: $selectedTab, knotNameList: appliedKnotNameList)
                case .etcCategory:
                    KnotButtonListView(pattern: pattern, selectedTab: $selectedTab, knotNameList: etcKnotNameList)
                }
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
                
                Button {
                    isFolding.toggle()
                } label: {
                    isFolding ? Image(systemName: "chevron.right") : Image(systemName: "chevron.left")
                }
                .font(.title2.bold())
                .foregroundStyle(.white)
                Spacer().frame(height: 50)
            }
            .padding(.top, 50)
            .background(Color.knotMenuBar)
        }
        .background(Color.knotMenuBG)
        .roundedCorner(24, corners: [.bottomLeft, .topLeft])
    }
}
