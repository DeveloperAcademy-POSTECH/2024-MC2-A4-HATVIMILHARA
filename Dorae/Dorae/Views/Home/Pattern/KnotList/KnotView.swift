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

struct KnotView: View {
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
                TabButton(title: "기본", isSelected: selectedTab == .basicCategory) {
                    selectedTab = .basicCategory
                }
                
                TabButton(title: "응용", isSelected: selectedTab == .appliedCategory) {
                    selectedTab = .appliedCategory
                }
                
                TabButton(title: "기타", isSelected: selectedTab == .etcCategory) {
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


struct KnotButtonListView: View {
    @Environment(KnotDataManager.self) var knotDataManager
    @Bindable var pattern: Pattern
    @Binding var selectedTab: KnotCategory
    
    let knotNameList: [String]
    let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 16) { ///상하간격
                ForEach(knotNameList, id: \.self) { knotName in
                    KnotButton(knotName: knotName)
                        .onTapGesture {
                            // FIXME: 버튼인스턴스 수정 필요
                            var newKnot: Knot = Knot.basic(knot: 도래매듭)
                            switch selectedTab {
                            case .basicCategory:
                                basicKnotCollection.forEach { basicKnot in
                                    if knotName == basicKnot.knotName.rawValue {
                                        newKnot = Knot.basic(knot: basicKnot)
                                    }
                                }
                            case .appliedCategory:
                                appliedKnotCollection.forEach { appliedKnot in
                                    if knotName == appliedKnot.knotName.rawValue {
                                        newKnot = Knot.applied(knot: appliedKnot)
                                    }
                                }
                            case .etcCategory:
                                if knotName == "고" {
                                    newKnot = Knot.etc(knot: EtcKnot(lasso: knotName))
                                } else if knotName == "술" {
                                    newKnot = Knot.etc(knot: EtcKnot(tassel:  knotName))
                                } else {
                                    newKnot = Knot.etc(knot: EtcKnot(interval:  0.0))
                                }
                                
                            }
                            knotDataManager.knotList.append(newKnot)
                            pattern.knotList = knotDataManager.knotList
                        }
                }
            }
            .padding(24) /// 백그라운드와 그리드 사이 패딩값
        }
        .frame(maxWidth: .infinity)
    }
}


struct TabButton: View {
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


struct KnotButton: View {
    var knotName: String
    
    var body: some View {
        VStack {
            Image("\(knotName)버튼")
                .frame(width: 84, height: 84)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Text("\(knotName)")
                .font(.caption)
        }
    }
}


