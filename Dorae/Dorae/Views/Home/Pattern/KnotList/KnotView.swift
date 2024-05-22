//
//  KnotView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

enum KnotCategory {
    case basic
    case applied
    case etc
}

struct KnotView: View {
    @State private var selectedTab: KnotCategory = .basic
    
    var body: some View {
        HStack(spacing: 0) {
            switch selectedTab {
            case .basic:
                // TODO: 카테고리 따라 다르게 뷰 그려주기
                KnotButtonView()
            case .applied:
                KnotButtonView()
            case .etc:
                KnotButtonView()
            }
            
            VStack(spacing: 0) {
                TabButton(title: "기본", isSelected: selectedTab == .basic) {
                    selectedTab = .basic
                }
                
                TabButton(title: "응용", isSelected: selectedTab == .applied) {
                    selectedTab = .applied
                }
                
                TabButton(title: "기타", isSelected: selectedTab == .etc) {
                    selectedTab = .etc
                }
                
                Spacer()
            }
            .padding(.top, 50)
            .background(Color(hex: "505050"))
        }
        .background(Color(hex: "E9E9E9"))
        .roundedCorner(24, corners: [.bottomLeft, .topLeft])
    }
}


struct KnotButtonView: View {
    let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
    let knots = ["도래매듭", "귀도래매듭", "단추매듭", "가락지매듭", "생쪽매듭", "나비매듭", "거꾸로나비매듭", "두벌매화", "세벌매화", "두벌국화", "세벌국화", "네벌국화", "도래매듭", "귀도래매듭", "단추매듭", "가락지매듭", "생쪽매듭", "나비매듭", "거꾸로나비매듭", "두벌매화", "세벌매화", "두벌국화", "세벌국화", "네벌국화"]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(knots, id: \.self) { knot in
                    KnotButton()
                        .onTapGesture {
                            // TODO: 줄글 도안, 이미지 도안 띄우기
                        }
                }
            }
            .padding(24)
        }
    }
}


struct TabButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2.bold())
                .foregroundColor(isSelected ? Color(hex: "505050"): .white)
        }
        .frame(height: 50)
        .padding()
        .background(isSelected ? Color(hex: "E9E9E9"): Color(hex: "505050"))
    }
}


struct KnotButton: View {
    var body: some View {
        VStack {
            Image(systemName: "tornado")
                .resizable()
                .padding(20)
                .frame(width: 84, height: 84)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Text("도래매듭")
                .font(.caption)
                .tint(Color(hex: "545454"))
        }
    }
}

#Preview {
    KnotView()
}
