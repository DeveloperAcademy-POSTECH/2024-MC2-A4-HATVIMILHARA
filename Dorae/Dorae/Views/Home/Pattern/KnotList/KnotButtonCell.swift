//
//  KnotButtonView.swift
//  Dorae
//
//  Created by 지영 on 5/21/24.
//

import SwiftUI

struct KnotButtonCell: View {
    var knotName: String
    var body: some View {
        VStack {
            Image(systemName: "tornado")
                .resizable()
                .padding(20)
                .frame(width: 84, height: 84)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Text("\(knotName)")
        }
    }
}


