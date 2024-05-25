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
    
    //TODO: 공유 이미지 수정
    private let photo = Photo(image: Image("육립매듭"))
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("육립매듭")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 180)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .contextMenu {
                    Button(role: .destructive) {
                        // TODO: delete
                    } label: {
                        Label("삭제", systemImage: "trash")
                    }

                    ShareLink(
                        "공유",
                        item: photo,
                        preview: SharePreview(
                            "Share Preview", image: photo.image
                        )
                    )
                    
                }
            Spacer()
                .frame(height: 16)
            Text(pattern.title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
            Text(pattern.createdAt)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.white)
        }
        
    }
}

struct HomeNewPatternItem: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "plus")
                .padding(.bottom, 12)
            Text("새 매듭 도안")
            Text("생성하기")
        }
        .frame(width: 160, height: 180)
            .clipShape(
            RoundedRectangle(cornerRadius: 15)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
        )
        .foregroundStyle(Color.newKnotButton)
    }
}

//#Preview {
//    HomePatternItem()
//}
