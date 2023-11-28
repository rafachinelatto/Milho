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
    @State var paletteNumber: Int = 0
    
    var body: some View {
        
        if redoTest {
            NavigationView {
                PersonalColorTestChooserView()
            }
        }
        else {
            
            List {
                Button(action: {            // botão para passar para o proximo elemento do modelo de paletas, nao vai existir
                    paletteNumber += 1
                    paletteNumber = paletteNumber % 12
                }, label: {
                    Text("Próxima paleta")
                })
                
                ResultsListView(paletteNumber: $paletteNumber)
                
//                Button(action: {
//                    redoTest = true
//                    self.presentationMode.wrappedValue.dismiss()
//                }, label: {
//                    Text("Realizar o teste novamente")
//                        .frame(maxWidth: .infinity)
//                })
//                
//                .buttonStyle(.borderedProminent)
//                .listRowBackground(Color(.accent))
            }
            .navigationTitle("Coloração pessoal")
            .navigationBarTitleDisplayMode(.automatic)
            //Spacer()
        }

        
    }
}

#Preview {
    ResultsView()
}
