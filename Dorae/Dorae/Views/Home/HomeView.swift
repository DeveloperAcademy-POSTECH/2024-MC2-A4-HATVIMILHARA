//
//  HomeView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct HomeView: View {
    let patterns = [
        nil,
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
                    ForEach(patterns, id: \.self) { pattern in
                        if pattern == nil {
                            HomeNewPatternItem()
                                .padding()
                                .onTapGesture {
                                    print("새 도안 생성")
                                }
                        } else {
                            HomePatternItem()
                                .padding()
                                .onTapGesture {
                                    print("각 도안으로 이동")
                                }
                        }
                    }
                }
                .padding(68)
            }
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("갤러리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("공유") {
                        print("헤이즐화이링")
                    }
                    .tint(Color.red)
                }
            }
            .background(Color(hex: "2B2B2B"))
        }
    }
}

#Preview {
    HomeView()
}
