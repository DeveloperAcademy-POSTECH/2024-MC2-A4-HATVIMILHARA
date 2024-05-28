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

extension View {
    @ViewBuilder func `if`<Content: View>(_ editMode: Bool, view: (Self) -> Content) -> some View {
        if editMode {
            view(self)
        } else {
            self
        }
    }
}

struct TextPatternView: View {
    @Bindable var pattern: Pattern
    @Environment(\.modelContext) var modelContext
    @Environment(\.editMode) var editMode

    @State private var braid = "" // 끈목
    @State private var intervalTextfield = "" // 간격
    @State private var isEditMode = true
    
    var body: some View {
        VStack {
            headerView
            inputView
            Divider()
            knotListView
        }
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 30))
    }
    
    private var headerView: some View {
        HStack(alignment: .top) {
            Text("글 도안")
                .font(.title)
                .bold()
            Spacer()
            
            EditButton()
                .font(.title2)
                .foregroundStyle(.red)
        }
    }
    
    private var inputView: some View {
        HStack {
            Text("끈목")
                .padding(.trailing, 40)
            TextField("끈목을 입력해주세요.", text: $braid)
                .textFieldStyle(.plain)
        }
    }
    
    private var knotListView: some View {
        List {
            ForEach(pattern.knotList) { knot in
                showKnotList(for: knot)
            }
            .if(editMode?.wrappedValue.isEditing == true) { view in
                view
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
            }
            .deleteDisabled(editMode?.wrappedValue.isEditing == false)
            .moveDisabled(editMode?.wrappedValue.isEditing == false)
        }
        .listStyle(.plain)
    }
    
    private func deleteItems(at offsets: IndexSet) {
        pattern.knotList.remove(atOffsets: offsets)
    }
    
    private func moveItems(from source: IndexSet, to destination: Int) {
        pattern.knotList.move(fromOffsets: source, toOffset: destination)
    }
    
    @ViewBuilder
    private func showKnotList(for knot: Knot) -> some View {
        switch knot {
        case .basic(let basicKnot):
            BasicKnotView(pattern: pattern, knot: basicKnot)
        case .applied(let appliedKnot):
            AppliedKnotView(knot: appliedKnot, pattern: pattern)
        case .etc(let etcKnot):
            EtcKnotView(knot: etcKnot, intervalTextfield: $intervalTextfield)
        }
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
            Image("\(knot.knotName.rawValue)버튼")
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
                    Spacer().frame(width: 50)
                    Circle().frame(width: 5)
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
                    .frame(width: 50, height: 50)
                Text(knot.knotName.rawValue)
            }
        }
    }
}

fileprivate struct EtcKnotView: View {
    let knot: EtcKnot
    @Binding var intervalTextfield: String
    
    var body: some View {
        if let interval = knot.interval {
            intervalView
        } else if let lasso = knot.lasso {
            lassoView(lasso: lasso)
        } else if let tassel = knot.tassel {
            tasselView(tassel: tassel)
        }
    }
    
    private var intervalView: some View {
        HStack {
            Image("간격버튼")
                .resizable()
                .frame(width: 50, height: 50)
            Text("간격")
            TextField("간격(cm)을 입력해주세요.", text: $intervalTextfield)
                .textFieldStyle(.plain)
                .keyboardType(.numberPad)
                .onChange(of: intervalTextfield) { oldValue, newValue in
                    validateIntervalTextfield(oldValue: oldValue, newValue: newValue)
                }
        }
    }
    
    private func validateIntervalTextfield(oldValue: String, newValue: String) {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.").inverted
        if newValue.rangeOfCharacter(from: allowedCharacters) != nil || newValue.components(separatedBy: ".").count > 2 {
            intervalTextfield = oldValue
        } else if !newValue.isEmpty, Double(newValue) == nil {
            intervalTextfield = String(newValue.prefix(newValue.count - 1))
        }
    }
    
    private func lassoView(lasso: String) -> some View {
        HStack {
            Image("고버튼")
                .resizable()
                .frame(width: 50, height: 50)
            Text(lasso)
        }
    }
    
    private func tasselView(tassel: String) -> some View {
        HStack {
            Image("술버튼")
                .resizable()
                .frame(width: 50, height: 50)
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
                Spacer().frame(width: 80)
                Text("귀(cm)")
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
