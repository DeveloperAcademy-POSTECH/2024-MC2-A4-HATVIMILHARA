//
//  TextPatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct TextPatternView: View {
    // 홈뷰에서 가져오는 첫 번째 Pattern 타입 knotList
    @State var knotList = PatternDummy.patternList[0].knotList
    @State private var braid = "" //끈목

    
    var body: some View {
        NavigationStack {
            VStack {
                // 끈목, 끈목 텍스트필드 스택
                HStack {
                    Text("끈목")
                        .padding(.trailing, 40)
                    TextField("끈목을 입력해주세요.", text: $braid)
                }
                
                Divider()
                
                // 배열에 들어가있는 데이터 뽑는 리스트
                List {
                    ForEach(knotList) { knot in
                        switch knot {
                        case .basic(let knot):
                            Text("\(knot.knotName)")
                        case .applied(let knot):
                            Text("\(knot.knotName)")
                        case .etc(let knot):
                            Text("\(knot.braid ?? "")")
                        }
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("글 도안")
                        .font(.title)
                        .bold()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                        .font(.title2)
                        .foregroundStyle(.red)
                }
            }
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        knotList.remove(atOffsets: offsets)
    }
    private func moveItems(from source: IndexSet, to destination: Int) {
        knotList.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    TextPatternView()
}
