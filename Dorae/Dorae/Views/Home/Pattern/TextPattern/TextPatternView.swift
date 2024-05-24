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
    //    @State private var textfiled = [String]()
    //    @State private var loopTextfiled = "" //귀
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("글 도안")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                EditButton()
                    .font(.title2)
                    .foregroundStyle(.red)
            }
            
            HStack {
                Text("끈목")
                    .padding(.trailing, 40)
                TextField("끈목을 입력해주세요.", text: $braid)
                    .textFieldStyle(.roundedBorder)
            }
            
            Divider()
            
            List {
                ForEach(knotDataManager.knotList) { knot in
                    showKnotList(for: knot)
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            .listStyle(.plain)
            
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        knotDataManager.knotList.remove(atOffsets: offsets)
    }
    
    private func moveItems(from source: IndexSet, to destination: Int) {
        knotDataManager.knotList.move(fromOffsets: source, toOffset: destination)
    }
    
    
    @ViewBuilder
    func showKnotList(for knot: Knot) -> some View {
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
                    Image("\(oldBasicKnot.knotName.rawValue)버튼")
                        .resizable()
                        .frame(width: 64, height: 64)
                    Text(oldBasicKnot.knotName.rawValue)
                }
            }
            
        case .applied(let knot):
            DisclosureGroup(
                content: {
                    ForEach(knot.subKnotList) { subKnot in
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
                        Image("\(knot.knotName)매듭")
                            .resizable()
                            .frame(width: 64, height: 64)
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
