//
//  TextPatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct TextPatternView: View {
    @Environment(KnotDataManager.self) var knotDataManager: KnotDataManager
    @State private var braid = "" //끈목
    @State private var intervalTextfiled = "" //간격
    
    var body: some View {
        VStack {
            // 상단 고정 Bar
            VStack {
                // 글 도안 + EditButton
                HStack(alignment: .top) {
                    Text("글 도안")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    EditButton()
                        .font(.title2)
                        .foregroundStyle(.red)
                }
                
                // 끈목 + 끈목 textfiled
                HStack {
                    Text("끈목")
                        .padding(.trailing, 40)
                    TextField("끈목을 입력해주세요.", text: $braid)
                        .textFieldStyle(.roundedBorder)
                }
                
                Divider()
            }
            
            // 리스트로 매듭 가져오는 View
            List {
                ForEach(knotDataManager.knotList) { knot in
                    showKnotList(for: knot)
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            .listStyle(.plain)
//            Divider()
        }
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 30))
    }
    
    // 리스트 내에서 노트 지우는 기능
    private func deleteItems(at offsets: IndexSet) {
        knotDataManager.knotList.remove(atOffsets: offsets)
    }
    
    // 리스트 내에서 노트 움직이는 기능
    private func moveItems(from source: IndexSet, to destination: Int) {
        knotDataManager.knotList.move(fromOffsets: source, toOffset: destination)
    }
    
    // 매듭을 하나씩 가져와서 분기처리 해서 뷰로 return
    @ViewBuilder
    func showKnotList(for knot: Knot) -> some View {
        switch knot {
            // 기본 매듭일 경우
        case .basic(let oldBasicKnot):
            // 기본 매듭이면서 귀가 있는 경우
            if let loop = oldBasicKnot.loop, !loop.isEmpty {
                DisclosureGroup(
                    content: {
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
                    },
                    label: {
                        HStack {
                            Image("\(oldBasicKnot.knotName.rawValue)버튼")
                            Text("\(oldBasicKnot.knotName.rawValue)")
                        }
                    }
                )}
            
            
            // 응용 매듭일 경우
        case .applied(let oldAppliedKnot):
            DisclosureGroup(
                content: {
                    ForEach(oldAppliedKnot.subKnotList) { subKnot in
                        HStack {
                            Spacer().frame(width: 50)
                            Circle().frame(width: 5)
                            Text("\(subKnot.knotName.rawValue)")
                            if subKnot.knotCount > 1 {
                                Text("\(subKnot.knotCount)")
                            }
                        }
                        
                        if let loop = subKnot.loop, !loop.isEmpty {
                            LoopListView(loopList: loop) { loop in
                                knotDataManager.knotList = knotDataManager.knotList.map { knotItem in
                                    if case Knot.applied(let appliedKnot) = knotItem {
                                        if let subKnotIndex = appliedKnot.subKnotList.firstIndex(where: { $0.id == subKnot.id }) {
                                            var updatedSubKnot = subKnot
                                            updatedSubKnot.loop = loop
                                            var updatedAppliedKnot = appliedKnot
                                            updatedAppliedKnot.subKnotList[subKnotIndex] = updatedSubKnot
                                            return .applied(knot: updatedAppliedKnot)
                                        } else {
                                            return knotItem
                                        }
                                    }
                                    return knotItem
                                }
                            }
                            .deleteDisabled(true)
                        }
                    }
                    .deleteDisabled(true)
                    .moveDisabled(true)
                    
                }, label: {
                    HStack {
                        Image("\(oldAppliedKnot.knotName)버튼")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("\(oldAppliedKnot.knotName)")
                    }
                })
            
        case .etc(let oldEtcKnot):
            // 간격일 때
            if let interval = oldEtcKnot.interval {
                HStack {
                    Image("간격매듭버튼")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    Text("간격")
                    
                    TextField("간격(cm)을 입력해주세요.", text: $intervalTextfiled)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: intervalTextfiled) { oldValue, newValue in
                            let allowedCharacters = CharacterSet(charactersIn: "0123456789.").inverted
                            if newValue.rangeOfCharacter(from: allowedCharacters) != nil || newValue.components(separatedBy: ".").count > 2 {
                                intervalTextfiled = oldValue
                            } else if !newValue.isEmpty, Double(newValue) == nil {
                                intervalTextfiled = String(newValue.prefix(newValue.count - 1))
                            }
                        }
                        .textFieldStyle(.plain)
                        .keyboardType(.numberPad)
                }
                // 고일 때
            } else if let lasso = oldEtcKnot.lasso {
                HStack {
                    Image("고매듭버튼")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("\(lasso)")
                }
            }
            // 술일 때
            else if let tassel = oldEtcKnot.tassel {
                HStack {
                    Image("술매듭버튼")
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    Text("\(tassel)")
                }
            }
        }
    }
}

// 매듭 리스트에서 호출 되어 사용되는 loopListView
fileprivate struct LoopListView: View {
    @State var loopList: [String] = []
    var changeLoop: ((_ loop: [String]) -> Void)
    
    var body: some View {
        ForEach(loopList.indices, id: \.self) { index in
            HStack {
                Spacer().frame(width: 80)
                Text("귀(cm)")
                Image(systemName: "\(index+1).circle")
                TextField("cm", text: $loopList[index])
                    .textFieldStyle(.roundedBorder)
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
