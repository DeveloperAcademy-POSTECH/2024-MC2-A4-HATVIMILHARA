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
    @State private var textfiled = ""
//    @State private var textFields: [String] = []
    
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
                        plainView(for: knot)
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
    
    @ViewBuilder
    func plainView(for knot: Knot) -> some View {
        switch knot {
        case .basic(let knot):
            if let loop = knot.loop, !loop.isEmpty {
                DisclosureGroup("\(knot.knotName.rawValue)") {
                    //TODO: - 빈 String 배열 만들어서 인덱스값이랑 엮기
                    ForEach(0..<loop.count, id: \.self) { index in
                        HStack {
                            Text("귀")
                            Image(systemName: "\(index+1).circle")
                            TextField("cm", text: $textfiled)
                        }
                    }
                }
            } else {
                Text(knot.knotName.rawValue)
            }
            
        case .applied(let knot):
            //TODO: - 1. 개수만 있는 애들, 2. 귀만 있는 애들, 3. 귀, 개수 둘 다 있는 애들, 4. 기본만 있는 애들
            DisclosureGroup("\(knot.knotName)") {
                
            }
            
        case .etc(let knot):
            if let braid = knot.braid {
                Text(braid) // 끈목임
            } else if let interval = knot.interval {
                HStack {
                    Image(systemName: "1.circle")
                    Text("간격")
                }
            } else if let lasso = knot.lasso {
                HStack {
                    Image(systemName: "3.circle")
                    Text(lasso)
                }
            } else {
                Text("없는 애임")
            }
        }
    }
}


#Preview {
    TextPatternView()
}
