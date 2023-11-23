//
//  ResultsView.swift
//  Milho
//
//  Created by Anderson  Vulto on 22/11/23.
//

import SwiftUI

struct ResultsView: View {
    
    @State private var redoTest = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        if redoTest {
            NavigationView {
                PersonalColorTestChooserView()
            }
        }
        else {
            List {
                
                ResultsListView()
                
                Button(action: {
                    redoTest = true
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Realizar o teste novamente")
                        .frame(maxWidth: .infinity)
                })
                
                .buttonStyle(.borderedProminent)
                .listRowBackground(Color(.accent))
            }
            .navigationTitle("Coloração pessoal")
            .navigationBarTitleDisplayMode(.automatic)
        }

        
    }
}

#Preview {
    ResultsView()
}
