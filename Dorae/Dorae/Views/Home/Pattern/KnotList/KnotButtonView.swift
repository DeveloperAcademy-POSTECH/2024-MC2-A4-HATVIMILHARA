//
//  KnotButtonView.swift
//  Dorae
//
//  Created by 지영 on 5/21/24.
//

import SwiftUI

struct KnotButtonView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let knots = ["도래매듭", "귀도래매듭", "단추매듭", "가락지매듭", "생쪽매듭", "나비매듭", "거꾸로나비매듭", "두벌매화", "세벌매화", "두벌국화", "세벌국화", "네벌국화"]
    
    var body: some View {
        HStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(knots, id: \.self) { knot in
                        KnotButtonCell(knotName: knot)
                            .onTapGesture {
                                // 줄글도안에 띄우기
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    KnotButtonView()
}
