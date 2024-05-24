//
//  TextPatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct TextPatternView: View {
    @Environment(KnotDataManager.self) var knotDataManager: KnotDataManager
    
    // 홈뷰에서 가져오는 첫 번째 Pattern 타입 knotList
    @State private var braid = "" //끈목
    @State private var loopTextfiled = "" //귀
    @State private var intervalTextfiled = "" //간격
    @State private var textfiled = [String]()
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    print(intervalTextfiled)
                }, label: {
                    Text("바보가 되")
                })
                // 끈목, 끈목 텍스트필드 스택
                HStack {
                    Text("끈목")
                        .padding(.trailing, 40)
                    TextField("끈목을 입력해주세요.", text: $braid)
                        .textFieldStyle(.plain)
                }
                
                Divider()
                
                // 배열에 들어가있는 데이터 뽑는 리스트
                List {
                    ForEach(knotDataManager.knotList) { knot in
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
        knotDataManager.knotList.remove(atOffsets: offsets)
    }
    private func moveItems(from source: IndexSet, to destination: Int) {
        knotDataManager.knotList.move(fromOffsets: source, toOffset: destination)
    }
    
    @ViewBuilder
    func plainView(for knot: Knot) -> some View {
        switch knot {
        case .basic(let oldBasicKnot):
            if let loop = oldBasicKnot.loop, !loop.isEmpty {
                DisclosureGroup(oldBasicKnot.knotName.rawValue) {
                    LoopListView(loopList: loop) { loop in
                        knotDataManager.knotList = knotDataManager.knotList.map { knotItem in
                            if case Knot.basic(let newBasicKnot) = knotItem {
                                if newBasicKnot.id == oldBasicKnot.id {
                                    var tempBasicKnot = newBasicKnot
                                    tempBasicKnot.loop = loop
                                    let newKnot: Knot = .basic(knot: tempBasicKnot)
                                    return newKnot
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
                    Text(oldBasicKnot.knotName.rawValue)
                }
            }
            
        case .applied(let knot):
            //TODO: - 1. 개수만 있는 애들, 2. 귀만 있는 애들, 3. 귀, 개수 둘 다 있는 애들, 4. 기본만 있는 애들
            //            Text(knot.knotName.rawValue)
            DisclosureGroup(
                content: {
                    // 내용들
                    ForEach(knot.subKnotList) { subKnot in
                        HStack {
                            Circle().frame(width: 5)
                            Text("\(subKnot.knotName)")
                            if subKnot.knotCount > 1 {
                                Text("\(subKnot.knotCount)")
                            }
                        }
                    }
                    .deleteDisabled(true)
                    .moveDisabled(true)
                    
                }, label: {
                    HStack {
                        Image(knot.knotName.rawValue)
                        //                            .resizable()
                        Text(knot.knotName.rawValue)
                    }
                })
            
        case .etc(let knot):
            if let interval = knot.interval {
                HStack {
                    Image("간격")
                    //                        .resizable()
                    Text("간격")
                    TextField("간격(cm)을 입력해주세요.", text: $intervalTextfiled)
                        .onChange(of: intervalTextfiled) { oldValue, newValue in
                            if !newValue.isEmpty && Int(newValue) == nil {
                                intervalTextfiled = String(newValue.prefix(newValue.count - 1))
                            }
                        }
                        .textFieldStyle(.plain)
                        .keyboardType(.numberPad)
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
    @State var loopList: [String]
    var changeLoop: ((_ loop: [String]) -> Void)
    
    var body: some View {
        List($loopList, id: \.self) { $text in
            HStack {
                Text("귀 \(loopList.count)")
                Image(systemName: "1.circle")
                TextField("cm", text: $text)
            }
        }
        .deleteDisabled(true)
        .moveDisabled(true)
        .onChange(of: loopList) { oldValue, newValue in
            changeLoop(newValue)
        }
    }
}



#Preview {
    TextPatternView()
        .environment(KnotDataManager())
}
