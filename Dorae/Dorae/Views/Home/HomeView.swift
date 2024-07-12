//
//  HomeView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: \Pattern.createdAt, order: .reverse) var patternList: [Pattern]
    @Environment(\.modelContext) private var modelContext
    @State private var newPattern: Pattern = Pattern(knotList: [], createdAt: .now, title: "제목없음", braid: "")
    
    let columns = [
        GridItem(.adaptive(minimum: 200, maximum: .infinity), alignment: .top)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    NavigationLink(destination: PatternView(pattern: newPattern)) {
                        HomeNewPatternItem()
                            .padding()
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        newPattern = Pattern(knotList: [], createdAt: .now, title: "제목없음", braid: "")
                        modelContext.insert(newPattern)
                    })
                    
                    ForEach(patternList) { pattern in
                        NavigationLink(destination: PatternView(pattern: pattern)) {
                            HomePatternItem(pattern: pattern)
                                .padding()
                        }
                    }
                }
                .padding(68)
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("갤러리")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.background)
        }
        .frame(maxWidth: .infinity)
    }
}
