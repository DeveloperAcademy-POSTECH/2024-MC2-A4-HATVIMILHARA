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
    @Environment(\.openURL) var openURL
    @State private var newPattern: Pattern = Pattern(knotList: [], createdAt: .now, title: .localized("제목없음"), braid: "")
    
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
                        newPattern = Pattern(knotList: [], createdAt: .now, title: .localized("제목없음"), braid: "")
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    InfoButton(openURL: openURL)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

private struct InfoButton: View {
    let openURL: OpenURLAction
    
    var body: some View {
        Button {
            let languageCode = Locale.preferredLanguages.first ?? "en"
            
            let url: URL? = {
                switch languageCode {
                case _ where languageCode.hasPrefix("ja"):
                    return WebLinks.jaInfoNotion
                case _ where languageCode.hasPrefix("ko"):
                    return WebLinks.krInfoNotion
                default:
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
