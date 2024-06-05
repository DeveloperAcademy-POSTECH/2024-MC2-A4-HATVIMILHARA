//
//  TextPatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

//
//  TextPatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct TextPatternView: View {
    @Bindable var pattern: Pattern
    @Environment(\.modelContext) var modelContext
    @Environment(\.editMode) var editMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            inputView
            Divider()
        }
    }
    
    private var inputView: some View {
        HStack(spacing: 0) {
            Text("끈목")
                .font(.body)
                .frame(width: 70)
            Spacer()
            TextField("끈목을 입력해주세요.", text: $pattern.braid)
                .textFieldStyle(.plain)
        }
        .frame(height: 44)
    }
}

public struct knotListView: View {
    @Bindable var pattern: Pattern
    @Environment(\.modelContext) var modelContext
    @Environment(\.editMode) var editMode
    
    public var body: some View {
        List {
            ForEach(Array(pattern.knotList.enumerated()), id: \.offset) { idx, knot in
                showKnotList(index: idx,for: knot)
            }
            .onDelete(perform: deleteItems)
            .onMove(perform: moveItems)
            .deleteDisabled(editMode?.wrappedValue == .inactive)
            .moveDisabled(editMode?.wrappedValue == .inactive)
            
            
        }
        .listStyle(.plain)
    }
    
    private func deleteItems(at offsets: IndexSet) {
        pattern.knotList.remove(atOffsets: offsets)
        try? modelContext.save()
    }
    
    private func moveItems(from source: IndexSet, to destination: Int) {
        pattern.knotList.move(fromOffsets: source, toOffset: destination)
        try? modelContext.save()
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
                        // Handle loop list change
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
            } else if !newValue.isEmpty, Double(newValue) == nil {
                textFieldString = String(newValue.prefix(newValue.count - 1))
            }
        }
        
        private func lassoView(lasso: String) -> some View {
            HStack {
                //FIXME: 이미지 크기
                Image("\(EtcKnotName.고.rawValue)버튼")
                    .resizable()
                    .scaledToFit()
                Text(lasso)
            }
        }
        
        private func tasselView(tassel: String) -> some View {
            HStack {
                //FIXME: 이미지 크기
                Image("\(EtcKnotName.술.rawValue)버튼")
                    .resizable()
                    .scaledToFit()
                Text(tassel)
            }
        }
    }
    
    fileprivate struct LoopListView: View {
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
