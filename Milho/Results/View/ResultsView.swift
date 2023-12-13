//
//  ResultsView.swift
//  Milho
//
//  Created by Anderson  Vulto on 22/11/23.
//

import SwiftUI

struct ResultsView: View {
    
    var shareResultsModel = ShareResultsModel()
    @EnvironmentObject var manualTestModel: ManualTestModel
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("result") var result: Bool?
    @State private var redoTest = false
    @State var paletteNumber: Int
    @State var paletteNumberManualTest: Int = -1
    @State var showResults: Bool = false
    @State var shareImage: UIImage = UIImage()
    
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
                .sheet(isPresented: $manualTestModel.showManualTest, content: {
                    ManualTestV2(paletteNumber: $paletteNumberManualTest, showResults: $showResults)
                })
                .navigationDestination(isPresented: $showResults) {
                    ManualTestLoadingView(paletteNumber: paletteNumberManualTest)
                        .navigationBarBackButtonHidden()
                        .toolbar(.hidden, for: .tabBar)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        ShareLink(item: PNG(shareImage.pngData() ?? Data()), preview: SharePreview("Minha paleta de cores", image: Image(uiImage: shareImage))) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                    }
                }
                .onAppear {
                    DispatchQueue.main.async {
                        self.shareImage = self.shareResultsModel.shareImage(paletteNumberResult: paletteNumber)
    
                        
                    }
                }
            
            
                //Spacer()
        }
//        }
        
    }
}

//#Preview {
    //ResultsView(paletteNumber: 11)
//}
