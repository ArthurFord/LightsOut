    //
    //  GameView.swift
    //  LightsOut
    //
    //  Created by Arthur Ford on 1/22/22.
    //

import SwiftUI

struct GameView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var game = cellArray
    @State var numberOfTurns = 0
    @State var gameWon = false
    @State var gameInProgress = false
    @State var newGameAlertIsShowing = false
    
    func gameSetup() {
        numberOfTurns = 0
        for cell in game {
            let rand = Double.random(in: 0...1)
            if rand > 0.5 {
                game[cell.id].lit = true
            } else {
                game[cell.id].lit = false
            }
        }
        gameInProgress = true
    }
    
    let rows = [
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
    ]
    
    func clicked(cellNumber: Int) {
        let topRow = [0,5,10,15,20]
        let bottomRow = [4,9,14,19,24]
        
        game[cellNumber].lit.toggle()
        if cellNumber > 5 {
            game[cellNumber-5].lit.toggle()
        }
        if cellNumber < 20 {
            game[cellNumber+5].lit.toggle()
        }
        if topRow.contains(cellNumber)  {
            
        } else {
            game[cellNumber-1].lit.toggle()
        }
        if bottomRow.contains(cellNumber)  {
            
        } else {
            game[cellNumber+1].lit.toggle()
        }
        
        numberOfTurns += 1
        print(numberOfTurns)
        checkForWin()
    }
    
    func checkForWin() {
        var localWin = true
        for cell in game {
            if cell.lit == true {
                localWin = false
            }
        }
        gameWon = localWin
        if gameWon {
            playerWon()
        }
    }
    
    func playerWon() {
        let record = Record(context: moc)
        record.id = UUID()
        record.turns = Int64(numberOfTurns)
        record.date = .now
        record.result = "Won"
        
        try? moc.save()
    }
    
    func playerLost() {
        let record = Record(context: moc)
        record.id = UUID()
        record.turns = Int64(numberOfTurns)
        record.date = .now
        record.result = "Lost"
        try? moc.save()
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Header()
                LazyHGrid(rows: rows, spacing: 0) {
                    ForEach(game, id: \.id) {cell in
                        Cell(cell: cell)
                            .onTapGesture {
                                if gameInProgress && !gameWon{
                                    clicked(cellNumber: cell.id)
                                }
                            }
                    }
                }
                Text("Turns Taken: \(numberOfTurns)")
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                Button {
                    newGameAlertIsShowing = true
                } label: {
                    Text("Start new game")
                }
                .alert("Start new game?", isPresented: $newGameAlertIsShowing) {
                    Button("Yes", role: .destructive) {
                        gameInProgress = true
                        
                        newGameAlertIsShowing = false
                        print(numberOfTurns)
                        if numberOfTurns > 0 {
                            playerLost()
                        }
                        gameSetup()
                    }
                }
                .alert("You won in \(numberOfTurns) turns! Play again?", isPresented: $gameWon) {
                    Button("Yes", role: .destructive) {
                        gameInProgress = true
                        gameSetup()
                        newGameAlertIsShowing = false
                    }
                }
                Spacer()
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        
    }
}
