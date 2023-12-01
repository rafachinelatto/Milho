//
//  ResultsView.swift
//  Milho
//
//  Created by Anderson  Vulto on 22/11/23.
//

import SwiftUI

struct ResultsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("result") var result: Bool?
    @State private var redoTest = false
    @State var paletteNumber: Int
    
    var body: some View {
        
        NavigationStack {
            
//            if redoTest {
//                NavigationStack {
//                    PersonalColorTestChooserView()
//                }
//            }
//            else {
                
                List {
                    //                Button(action: {            // botão para passar para o proximo elemento do modelo de paletas, nao vai existir
                    //                    paletteNumber += 1
                    //                    paletteNumber = paletteNumber % 12
                    //                }, label: {
                    //                    Text("Próxima paleta")
                    //                })
                    
                    ResultsListView(paletteNumber: $paletteNumber)
                    
                    
                    Button(action: {
                        redoTest = true
                        //self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Realizar o teste novamente")
                            .frame(maxWidth: .infinity)
                    })
                    
                    .buttonStyle(.borderedProminent)
                    .listRowBackground(Color(.accent))
                }
                .navigationTitle("Coloração pessoal")
                .navigationBarTitleDisplayMode(.automatic)
                .navigationDestination(isPresented: $redoTest) {
                    PersonalColorTestChooserView()
                }
                //Spacer()
        }
//        }
        
    }
}

#Preview {
    ResultsView(paletteNumber: 11)
}
