//
//  TextKnotListView.swift
//  Dorae
//
//  Created by Damin on 6/12/24.
//

import SwiftUI

struct TextKnotListView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var pattern: Pattern
    @Binding var listUpdateTrigger: Bool
    
    public var body: some View {
        List {
            ForEach(Array(pattern.knotList.enumerated()), id: \.offset) { idx, knot in
                showKnotList(index: idx,for: knot)
            }
            .onDelete(perform: deleteItems)
            .onMove(perform: moveItems)
        }
        .listStyle(.plain)
        .id(listUpdateTrigger) // 리스트가 바뀔 때마다 ID가 바뀌도록 설정
    }
    
    private func deleteItems(at offsets: IndexSet) {
        pattern.knotList.remove(atOffsets: offsets)
        try? modelContext.save()
        listUpdateTrigger.toggle()
    }
    
    private func moveItems(from source: IndexSet, to destination: Int) {
        pattern.knotList.move(fromOffsets: source, toOffset: destination)
        try? modelContext.save()
        listUpdateTrigger.toggle()
    }
    
    @ViewBuilder
    private func showKnotList(index: Int, for knot: Knot) -> some View {
        if !pattern.knotList.isEmpty && index < pattern.knotList.count {
            switch knot {
            case .basic(let basicKnot):
                BasicKnotView(pattern: pattern, knot: basicKnot)
                    .frame(height: 44)
                    .listRowInsets(.init())
                    .environment(\.defaultMinListRowHeight,0)
                    .padding(.horizontal)
            case .applied(let appliedKnot):
                AppliedKnotView(knot: appliedKnot, pattern: pattern)
                    .frame(height: 44)
                    .listRowInsets(.init())
                    .environment(\.defaultMinListRowHeight,0)
                    .padding(.horizontal)
            case .etc(let etcKnot):
                EtcKnotView(etcknot: etcKnot,
                            knot: $pattern.knotList[index], textFieldString: String(etcKnot.interval ?? 0.0))
                .frame(height: 44)
                .listRowInsets(.init())
                .environment(\.defaultMinListRowHeight,0)
                .padding(.horizontal)
            }
        } else {
            Text("이스터 에그")
        }
    }
    
    fileprivate struct BasicKnotView: View {
        @Bindable var pattern: Pattern
        let knot: BasicKnot
        
        var body: some View {
            if let loop = knot.loop, !loop.isEmpty {
                DisclosureGroup {
                    LoopListView(loopList: loop) { loop in
                        pattern.knotList = pattern.knotList.map { knotItem in
                            if case Knot.basic(let newBasicKnot) = knotItem {
                                if newBasicKnot.id == knot.id {
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
                } label: {
                    knotHeaderView
                }
            } else {
                knotHeaderView
            }
        }
        
        private var knotHeaderView: some View {
            HStack {
                Image("\(knot.knotName)버튼")
                    .resizable()
                    .scaledToFit()
                Text(knot.knotName.rawValue)
            }
        }
    }
    
    fileprivate struct AppliedKnotView: View {
        let knot: AppliedKnot
        @Bindable var pattern: Pattern
        
        var body: some View {
            DisclosureGroup {
                ForEach(knot.subKnotList) { subKnot in
                    HStack {
                        Spacer()
                            .frame(width: 50)
                        Circle()
                            .frame(width: 5)
                        Text(subKnot.knotName.rawValue)
                        if subKnot.knotCount > 1 {
                            Text("\(subKnot.knotCount)")
                        }
                    }
                    if let loopList = subKnot.loop, !loopList.isEmpty {
                        LoopListView(loopList: loopList) { loop in
                            // Handle loop list change
                            pattern.knotList = pattern.knotList.map { knotItem in
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
            } label: {
                HStack {
                    Image("\(knot.knotName)버튼")
                        .resizable()
                        .scaledToFit()
                    Text(knot.knotName.rawValue)
                }
            }
        }
    }
    
    fileprivate struct EtcKnotView: View {
        @Environment(\.editMode) var editMode
        let etcknot: EtcKnot
        @Binding var knot: Knot
        @State var textFieldString: String
        
        var body: some View {
            if let interval = etcknot.interval {
                intervalView
            } else if let lasso = etcknot.lasso {
                lassoView(lasso: lasso)
            } else if let tassel = etcknot.tassel {
                tasselView(tassel: tassel)
            }
        }
        
        private var intervalView: some View {
            HStack {
                //FIXME: 이미지 크기
                Image("\(EtcKnotName.간격.rawValue)버튼")
                    .resizable()
                    .scaledToFit()
                Text("간격")
                TextField("간격(cm)을 입력해주세요.", text: $textFieldString)
                    .disabled(editMode?.wrappedValue.isEditing == true)
                    .textFieldStyle(.plain)
                    .keyboardType(.numberPad)
                    .onChange(of: textFieldString) { oldValue, newValue in
                        validateIntervalTextfield(oldValue: oldValue, newValue: newValue)
                        
                        if case Knot.etc(let etcKnot) = knot {
                            knot = .etc(knot: EtcKnot(id: etcKnot.id, interval: Float(textFieldString) ?? 0.0))
                        }
                    }
            }
        }
        
        private func validateIntervalTextfield(oldValue: String, newValue: String) {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789.").inverted
            if newValue.rangeOfCharacter(from: allowedCharacters) != nil || newValue.components(separatedBy: ".").count > 2 {
                textFieldString = oldValue
            } else if !newValue.isEmpty, Float(newValue) == nil {
                textFieldString = String(newValue.prefix(newValue.count - 1))
            }
        }
        
        private func lassoView(lasso: String) -> some View {
            HStack {
                Image("\(EtcKnotName.고.rawValue)버튼")
                    .resizable()
                    .scaledToFit()
                Text(lasso)
            }
        }
        
        private func tasselView(tassel: String) -> some View {
            HStack {
                Image("\(EtcKnotName.술.rawValue)버튼")
                    .resizable()
                    .scaledToFit()
                Text(tassel)
            }
        }
    }
    
    fileprivate struct LoopListView: View {
        @Environment(\.editMode) var editMode
        @State var loopList: [String]
        var changeLoop: ([String]) -> Void
        
        var body: some View {
            ForEach(loopList.indices, id: \.self) { index in
                HStack {
                    Spacer()
                        .frame(width: 70)
                    Text("귀(cm)")
                        .frame(width: 70)
                    Image(systemName: "\(index+1).circle")
                    TextField("cm", text: $loopList[index])
                        .disabled(editMode?.wrappedValue.isEditing == true)
                        .textFieldStyle(.plain)
                }
            }
            .deleteDisabled(true)
            .moveDisabled(true)
            .onChange(of: loopList) { oldValue, newValue in
                changeLoop(newValue)
            }
        }
    }
}
