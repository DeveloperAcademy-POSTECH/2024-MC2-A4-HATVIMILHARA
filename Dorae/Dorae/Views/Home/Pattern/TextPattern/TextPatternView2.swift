//
//  TextPatternView.swift
//  Dorae
//
//  Created by Damin on 5/20/24.
//

import SwiftUI

struct TextPatternView2: View {
    struct ListItem: Identifiable, Hashable {
        var id = UUID()
        var name: String
        var imgName: String
        var ear: [String]?
    }
    
    @State var sharedData: [ListItem] = [
        ListItem(name: 도래매듭.매듭이름.rawValue, imgName: 도래매듭.매듭이름.rawValue, ear: nil),
        ListItem(name: 귀도래매듭.매듭이름.rawValue, imgName: 귀도래매듭.매듭이름.rawValue, ear: [""]),
        ListItem(name: 단추매듭.매듭이름.rawValue, imgName: 단추매듭.매듭이름.rawValue, ear: nil),
        ListItem(name: 가락지매듭.매듭이름.rawValue, imgName: 가락지매듭.매듭이름.rawValue, ear: nil)
    ]
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    Section(content: {
                        ForEach(sharedData) { item in
                            HStack {
                                Image(systemName: "mic.fill")
                                Text(item.name)
                            }
                        }
                        .onDelete(perform: removeList)
                        .onMove(perform: moveList)
                    }, header: {
                        HStack {
                            Text("글 도안")
                                .font(.title)
                                .bold()
                                .foregroundStyle(.black)
                            
                            Spacer()
                            
                            Text("이동/삭제")
                                .font(.subheadline)
                                .bold()
                                .foregroundStyle(.red)
                        }
                        .padding(.bottom, 23)
                        
                    })
                }
                .listStyle(.plain)
            }
            
            Button {

            } label: {
                Text("Add Button")
            }

        }
    }
    
    func removeList(at offsets: IndexSet) {
        sharedData.remove(atOffsets: offsets)
    }
    
    func moveList(from source: IndexSet, to destination: Int) {
        sharedData.move(fromOffsets: source, toOffset: destination)
    }
    
    func addPlainItem() {
        //TODO: - 토글x, 기본매듭 추가시
    }
    
    func addDisclosureGroupItem() {
        //TODO: - 토글 버튼있는 응용매듭 추가시
    }
}

#Preview {
    TextPatternView2()
}
