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
    @Query(sort: \Pattern.createdAt, order: .reverse) var patternList: [Pattern]
    @Environment(\.modelContext) private var modelContext
    @Environment(KnotDataManager.self) var knotDataManager: KnotDataManager
    @Environment(\.openURL) var openURL
    @State private var tempPattern: Pattern = Pattern(knotList: [], createdAt: .now, title: "제목없음", braid: "")
    
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
                    NewPatternButtonView(tempPattern: $tempPattern)
                    
                    ForEach(patternList, id: \.self) { pattern in
                        PatternLinkView(pattern: pattern)
                    }
                }
                .padding(68)
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("갤러리")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.background)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    InfoButton(openURL: openURL)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

private struct NewPatternButtonView: View {
    @Binding var tempPattern: Pattern
    @Environment(\.modelContext) private var modelContext
    @Environment(KnotDataManager.self) private var knotDataManager

    var body: some View {
        NavigationLink(destination: PatternView(pattern: tempPattern)) {
            HomeNewPatternItem()
                .padding()
        }
        .simultaneousGesture(TapGesture().onEnded {
            tempPattern = Pattern(knotList: [], createdAt: .now, title: "제목없음", braid: "")
            modelContext.insert(tempPattern)
            knotDataManager.knotList = tempPattern.knotList
        })
    }
}

private struct PatternLinkView: View {
    let pattern: Pattern
    @Environment(KnotDataManager.self) var knotDataManager: KnotDataManager
    
    var body: some View {
        NavigationLink(destination: PatternView(pattern: pattern)) {
            HomePatternItem(pattern: pattern)
                .padding()
        }
        .simultaneousGesture(TapGesture().onEnded {
            knotDataManager.knotList = pattern.knotList
        })
    }
}

private struct InfoButton: View {
    let openURL: OpenURLAction

    var body: some View {
        Button {
            let languageCode = Locale.preferredLanguages.first ?? "en"
            
            let url: URL? = {
                if languageCode.hasPrefix("ja") {
                    print("일본 사람: \(languageCode)")
                    return WebLinks.jaInfoNotion
                } else if languageCode.hasPrefix("ko") {
                    print("한국 사람: \(languageCode)")
                    return WebLinks.krInfoNotion
                } else {
                    print("그 외: \(languageCode)")
                    return WebLinks.enInfoNotion
                }
            }()
            
            if let url {
                openURL(url)
            }
            
        } label: {
            Image(systemName: "info.circle")
                .foregroundStyle(.black)
        }
    }
}
