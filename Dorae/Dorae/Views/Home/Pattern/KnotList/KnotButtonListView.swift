//
//  KnotButtonListView.swift
//  Dorae
//
//  Created by 지영 on 5/26/24.
//

import SwiftUI

struct KnotButtonListView: View {
    @Bindable var pattern: Pattern
    @Environment(\.modelContext) private var modelContext
    @Binding var selectedTab: KnotCategory
    
    let knotNameList: [String]
    let columns = [
        GridItem(.flexible(), spacing: 16, alignment: .top),
        GridItem(.flexible(), spacing: 16, alignment: .top)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 16) { ///상하간격
                    ForEach(knotNameList, id: \.self) { knotName in
                        KnotButton(knotName: knotName)
                            .onTapGesture {
                                var newKnot: Knot? = nil
                                switch selectedTab {
                                case .basicCategory:
                                    basicKnotCollection.forEach { basicKnot in
                                        if knotName == basicKnot.knotName.rawValue {
                                            let newBasicKnot = BasicKnot(basicKnot: basicKnot)
                                            newKnot = Knot.basic(knot: newBasicKnot)
                                        }
                                    }
                                case .appliedCategory:
                                    appliedKnotCollection.forEach { appliedKnot in
                                        if knotName == appliedKnot.knotName.rawValue {
                                            let newAppliedKnot = AppliedKnot(appliedKnot: appliedKnot)
                                            newKnot = Knot.applied(knot: newAppliedKnot)
                                        }
                                    }
                                case .etcCategory:
                                    if knotName == EtcKnotName.고.rawValue {
                                        newKnot = Knot.etc(knot: EtcKnot(lasso: knotName))
                                    } else if knotName == EtcKnotName.술.rawValue {
                                        newKnot = Knot.etc(knot: EtcKnot(tassel:  knotName))
                                    } else {
                                        newKnot = Knot.etc(knot: EtcKnot(interval:  0.0))
                                    }
                                case .templateCategory:
                                    if let templatePattern = Pattern.predefinedTemplates.first(where: { $0.title == knotName }) {
                                        // 템플릿 패턴의 매듭들을 현재 패턴에 추가
                                        pattern.knotList.append(contentsOf: templatePattern.knotList)
                                        try? modelContext.save()
                                    }
                                }
                                if let newKnot = newKnot {
                                    pattern.knotList.append(newKnot)
                                    try? modelContext.save()
                                }
                            }
                    }
                }
                .padding(.horizontal, max(16, min(24, (geometry.size.width - 184) / 2)))
                .padding(.vertical, 24)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
