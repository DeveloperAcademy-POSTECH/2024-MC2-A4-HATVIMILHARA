//
//  HomeView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    //TODO: 날짜에 따라서 sort해주기
    @Query var patternList: [Pattern]
    @Environment(\.modelContext) private var modelContext
    @Environment(KnotDataManager.self) var knotDataManager: KnotDataManager
    @State private var tempPattern: Pattern = Pattern(knotList: [], createdAt: "", title: "제목없음", braid: "")
    
    let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    NavigationLink(destination: PatternView(pattern: tempPattern)) {
                        HomeNewPatternItem()
                            .padding()
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        tempPattern = Pattern(knotList: [], createdAt: "", title: "제목없음", braid: "")
                        modelContext.insert(tempPattern)
                        knotDataManager.knotList = tempPattern.knotList
                    })
                    
                    ForEach(patternList, id: \.self) { pattern in
                        NavigationLink(destination: PatternView(pattern: pattern)) {
                            HomePatternItem(pattern: pattern)
                                .padding()
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            knotDataManager.knotList = pattern.knotList
                        })
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

//#Preview {
//    HomeView()
//        .modelContainer(previewContainer)
//        .environment(KnotDataManager())
//}
