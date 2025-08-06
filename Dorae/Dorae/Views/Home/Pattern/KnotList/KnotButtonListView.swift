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
                                addKnot(name: knotName)
                            }
                    }
                }
                .padding(.horizontal, max(16, min(24, (geometry.size.width - 184) / 2)))
                .padding(.vertical, 24)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func addKnot(name: String) {
        if selectedTab == .templateCategory {
            let knotList = KnotFactory.createKnotList(templateName: name)
            pattern.knotList.append(contentsOf: knotList)
        }
        
        else if let knot = KnotFactory.createKnot(name: name, category: selectedTab) {
            pattern.knotList.append(knot)
        }
        try? modelContext.save()
    }
}
