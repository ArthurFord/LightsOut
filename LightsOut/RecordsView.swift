    //
    //  RecordsView.swift
    //  LightsOut
    //
    //  Created by Arthur Ford on 1/23/22.
    //

import SwiftUI

struct RecordsView: View {
    
    @FetchRequest(sortDescriptors: []) var records: FetchedResults<Record>
    @Environment(\.managedObjectContext) var moc
    @State var deleteRecordsAlertIsShowing = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(records) {record in
                            HStack {
                                Text(record.date?.formatted(date: .abbreviated, time: .omitted) ?? "None")
                                Spacer()
                                Text("Turns: \(record.turns)")
                                Spacer()
                                Text("Result: \(record.result ?? "None")")
                            }
                            .foregroundColor(.white)
                            .padding(8)
                        }
                    }
                    .padding()
                }
                .padding(.top)
                Button {
                    deleteRecordsAlertIsShowing = true
                } label: {
                    Text("Delete all records")
                }
                .alert("Are you sure? This action can't be undone.", isPresented: $deleteRecordsAlertIsShowing) {
                    Button("Yes", role: .destructive) {
                        for record in records {
                            moc.delete(record)
                        }
                        try? moc.save()
                    }
                }
                Spacer()
            }
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView()
    }
}
