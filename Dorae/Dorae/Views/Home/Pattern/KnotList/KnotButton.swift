//
//  KnotButton.swift
//  Dorae
//
//  Created by 지영 on 5/26/24.
//

import SwiftUI

struct KnotButton: View {
    var knotName: String
    
    var body: some View {
        VStack {
            Image("\(knotName)버튼")
                .frame(width: 84, height: 84)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Text("\(knotName)")
                .font(.caption)
        }
    }
}
