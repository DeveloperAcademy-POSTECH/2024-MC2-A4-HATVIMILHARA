//
//  HomePatternCell.swift
//  Dorae
//
//  Created by 지영 on 5/21/24.
//

import SwiftUI

struct Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }
    public var image: Image
}

struct HomePatternItem: View {
    @Bindable var pattern: Pattern
    @Environment(\.modelContext) var modelContext

    @State private var renderedPatternImage = Image(systemName: "tortoise")
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        VStack(alignment: .leading) {
            ImagePatternView(pattern: pattern)
                .frame(width: 160, height: 180)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .contextMenu {
                    Button(role: .destructive) {
                        modelContext.delete(pattern)
                    } label: {
                        Label("삭제", systemImage: "trash")
                    }

                    ShareLink(
                        "공유",
                        item: renderedPatternImage,
                        preview: SharePreview(
                            pattern.title, 
                            image: renderedPatternImage
                        )
                    )
                    .onAppear { render() }
                }
            Spacer()
                .frame(height: 16)
            Text(pattern.title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
            Text(pattern.createdAt.toString())
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.white)
        }
    }
    
    @MainActor
    func render() {
        let renderer = ImageRenderer(content: ImagePatternView(pattern: pattern))
        
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            renderedPatternImage = Image(uiImage: uiImage)
        }
    }
}
