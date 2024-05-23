//
//  HomeView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct HomeView: View {
    let patterns = [
        "화려한 곡선",
        "기하학적 패턴",
        "심플한 점선",
        "추상적 예술",
        "현대적 디자인",
        "자연의 아름다움",
        "고전적 장식",
        "미니멀리즘"
    ]
    
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
                    NavigationLink(destination: PatternView()) {
                        HomeNewPatternItem()
                            .padding()
                    }
                    
                    ForEach(patterns, id: \.self) { pattern in
                        NavigationLink(destination: PatternView()) {
                            HomePatternItem()
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

#Preview {
    HomeView()
}
