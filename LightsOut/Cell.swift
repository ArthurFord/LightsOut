    //
    //  Cell.swift
    //  LightsOut
    //
    //  Created by Arthur Ford on 1/23/22.
    //

import SwiftUI



struct Cell: View {
    var cell: cellPrototype
    
    var body: some View {
        Rectangle()
            .fill(cell.lit ? Color.orange : Color.gray)
            .border(Color.black)
            .frame(width: 60, height: 60)
            
    }
    
    struct Cell_Previews: PreviewProvider {
        static var previews: some View {
            Cell(cell: cellArray[0])
        }
    }
}
