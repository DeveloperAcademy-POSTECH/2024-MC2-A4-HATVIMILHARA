//
//  TextPatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct TextPatternView: View {
    @Environment(\.editMode) var editMode
    @Bindable var pattern: Pattern
    @State private var listUpdateTrigger = false
    @State private var keyBoardResponder = KeyboardResponder()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            braidView
            Divider()
            TextKnotListView(pattern: pattern, listUpdateTrigger: $listUpdateTrigger)
        }
        .gesture(
            editMode?.wrappedValue.isEditing == true ? nil : TapGesture().onEnded {
                hideKeyboard()
            }
        )
        .onChange(of: keyBoardResponder.isKeyboardVisible) { oldValue, newValue in
            if !newValue {
                listUpdateTrigger.toggle()
            }
        }
    }
    
    private var braidView: some View {
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

