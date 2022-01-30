    //
    //  Header.swift
    //  LightsOut
    //
    //  Created by Arthur Ford on 1/23/22.
    //

import SwiftUI

struct Header: View {
    
    let lightColor = Color.orange
    let outColor = Color.blue
    
    var body: some View {
        
        TimelineView(.periodic(from: .now, by: 2)) {timeline in
            let radius1 = CGFloat.random(in: 0.0...30.0)
            let radius2 = CGFloat.random(in: 0.0...30.0)
            let radius3 = CGFloat.random(in: 0.0...30.0)
            let radius4 = CGFloat.random(in: 0.0...30.0)
            let duration1 = Double.random(in: 1...2)
            let duration2 = Double.random(in: 1...2)
            
            HStack {
                Text("Lights")
                    .foregroundColor(lightColor)
                    .shadow(color: lightColor, radius: radius1, x: 0, y: 0)
                    .animation(.easeInOut(duration: duration1), value: radius1)
                    .shadow(color: lightColor, radius: radius2, x: 0, y: 0)
                    .animation(.easeInOut(duration: duration1), value: radius2)
                    
                    
                
                Text("Out ")
                    .foregroundColor(outColor)
                    .shadow(color: outColor, radius: radius3, x: 0, y: 0)
                    .animation(.easeInOut(duration: duration2), value: radius3)
                    .shadow(color: outColor, radius: radius4, x: 0, y: 0)
                    .animation(.easeInOut(duration: duration2), value: radius4)
                
            }
            .font(Font.custom("Neonderthaw-Regular", size: 66))
            .padding()
            
        }
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .background(Color.black)
            
    }
}
