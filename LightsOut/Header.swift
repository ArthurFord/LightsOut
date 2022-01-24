//
//  Header.swift
//  LightsOut
//
//  Created by Arthur Ford on 1/23/22.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Text("Lights")
                .foregroundColor(.green)
                .shadow(color: .green, radius: 10, x: 0, y: 0)
                .shadow(color: .green, radius: 20, x: 0, y: 0)
            Text("Out ")
                .foregroundColor(.cyan)
                .shadow(color: .cyan, radius: 10, x: 0, y: 0)
                .shadow(color: .cyan, radius: 20, x: 0, y: 0)
        }
        .font(Font.custom("Neonderthaw-Regular", size: 66))
        .padding()
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
