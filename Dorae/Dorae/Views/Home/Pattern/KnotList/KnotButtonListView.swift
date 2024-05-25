//
//  KnotButtonListView.swift
//  Dorae
//
//  Created by 지영 on 5/26/24.
//

import SwiftUI

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
                            let newKnot: Knot
                            switch selectedTab {
                            case .basicCategory:
                                newKnot = Knot.basic(knot: BasicKnot(knotName: BasicKnotName(rawValue: knotName)!))
                            case .appliedCategory:
                                newKnot = Knot.applied(knot: AppliedKnot(knotName: AppliedKnotName(rawValue: knotName)!))
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
