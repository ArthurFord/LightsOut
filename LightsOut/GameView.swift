    //
    //  GameView.swift
    //  LightsOut
    //
    //  Created by Arthur Ford on 1/22/22.
    //

import SwiftUI

struct GameView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var gameBoard = cellArray
    @State var numberOfTurns = 0
    @State var gameWon = false
    @State var gameInProgress = false
    @State var newGameAlertIsShowing = false
    @State var musicOn = true
    
    func gameSetup() {
        numberOfTurns = 0
        for cell in gameBoard {
            let rand = Double.random(in: 0...1)
            if rand > 0.5 {
                gameBoard[cell.id].lit = true
            } else {
                gameBoard[cell.id].lit = false
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
        
        gameBoard[cellNumber].lit.toggle()
        if cellNumber > 5 {
            gameBoard[cellNumber-5].lit.toggle()
        }
        if cellNumber < 20 {
            gameBoard[cellNumber+5].lit.toggle()
        }
        if topRow.contains(cellNumber)  {
            
        } else {
            gameBoard[cellNumber-1].lit.toggle()
        }
        if bottomRow.contains(cellNumber)  {
            
        } else {
            gameBoard[cellNumber+1].lit.toggle()
        }
        
        numberOfTurns += 1
        print(numberOfTurns)
        checkForWin()
    }
    
    func checkForWin() {
        var localWin = true
        for cell in gameBoard {
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
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        if musicOn {
                            BGMusic.shared.stopBGMusic()
                        } else {
                            BGMusic.shared.startBGMusic()
                        }
                        musicOn.toggle()
                    } label: {
                        if musicOn {
                            Image(systemName: "speaker.slash.circle")
                        } else {
                            Image(systemName: "speaker.wave.2.circle")
                        }
                    }
                   
                }
                .font(.largeTitle)
                .foregroundColor(.orange)
                .padding(.horizontal, 40)
                Header()
                LazyHGrid(rows: rows, spacing: 0) {
                    ForEach(gameBoard, id: \.id) {cell in
                        Cell(cell: cell)
                            .onTapGesture {
                                if gameInProgress && !gameWon{
                                    clicked(cellNumber: cell.id)
                                }
                            }
                    }
                }
                Text("Turns Taken: \(numberOfTurns)")
                    .foregroundColor(.orange)
                    .font(.title2)
                    .padding()
                Spacer()
                HStack {
                    Button {
                        newGameAlertIsShowing = true
                    } label: {
                        Text("Start new game")
                            .font(.title2)
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .cornerRadius(16)
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
                }
                Spacer()
            }
        }
        .onAppear(perform: gameSetup)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        
    }
}
