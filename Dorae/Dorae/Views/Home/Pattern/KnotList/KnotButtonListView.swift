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
                            }
                            pattern.knotList.append(newKnot)
                            try? modelContext.save()
                        }
                }
            }
            .padding(24) /// 백그라운드와 그리드 사이 패딩값
        }
        .frame(maxWidth: .infinity)
    }
}
