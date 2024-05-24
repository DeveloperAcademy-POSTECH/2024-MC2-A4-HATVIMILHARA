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
    @State private var loopTextfiled = ""
    @State private var intervalTextfiled = ""
    @State private var textfiled = [String]()
    let 매듭1 = 도래매듭
    let 매듭2 = 도래매듭
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
                DisclosureGroup(knot.knotName.rawValue) {
                    //TODO: - 빈 String 배열 만들어서 인덱스값이랑 엮기
//                    ForEach(0..<loop.count, id: \.self) { index in
//                        HStack {
//                            Text("귀")
//                            Image(systemName: "\(index+1).circle")
//                            TextField("cm", text: $loopTextfiled)
//                        }
//                    }
                    LoopListView(loop: loop) { loop in
                        knotList = knotList.map { knotItem in
                            if case .basic(let data) = knotItem {
                                if data.id == knot.id {
                                    var tempBasicKnot = data
                                    tempBasicKnot.loop = loop
                                    let newBasicKnot: Knot = .basic(knot: tempBasicKnot)
                                    return newBasicKnot
                                } else {
                                    return knotItem
                                }
                            }
                            return knotItem
                        }
                    }
                    .deleteDisabled(true)

                }
            } else {
                HStack {
                    Image(BasicKnotName.도래매듭.rawValue)
                    Text(knot.knotName.rawValue)
                }
            }
            
        case .applied(let knot):
            //TODO: - 1. 개수만 있는 애들, 2. 귀만 있는 애들, 3. 귀, 개수 둘 다 있는 애들, 4. 기본만 있는 애들
//            Text(knot.knotName.rawValue)
            DisclosureGroup(
                content: {
                    // 내용들
                }, label: {
                    HStack {
                        Image("공작매듭")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(knot.knotName.rawValue)
                    }
                })

        case .etc(let knot):
            if let interval = knot.interval {
                HStack {
                    Image("간격")
                    Text("간격")
                    TextField("간격(cm)을 입력해주세요.", text: $intervalTextfiled)
                }
            } else if let lasso = knot.lasso {
                HStack {
                    Image("고")
                    Text("\(lasso) 고 임")
                }
            } else {
                Text("없는 애임")
            }
        }
    }
}

fileprivate struct LoopListView: View {
    @State var loop: [String] = []
    var changeLoop: ((_ loop: [String]) -> Void)
    
    var body: some View {
        VStack {
            ForEach($loop, id: \.self) { $text in
                HStack {
                    Text("귀")
                    TextField("cm", text: $text)
                }
                .deleteDisabled(true)
            }
        }
        .onChange(of: loop) { oldValue, newValue in
            changeLoop(newValue)
        }
    }
}


#Preview {
    TextPatternView()
}
