//
//  TabBarView.swift
//  Milho
//
//  Created by Anderson  Vulto on 01/11/23.
//
import SwiftUI

class RedoTest: ObservableObject {
    @Published var didRedoTest = false
}

struct TabBar: View {
    
    @State private var selectedTab = 0
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @AppStorage("result") var result: Bool?
    @AppStorage("paletteNumber") var paletteNumber: Int?
    @EnvironmentObject var redoTest: RedoTest
    
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
            
            if let result = result {
                if !result {
                    PersonalColoringTabItem()
                        .tabItem {
                            
                            Text("Coloração pessoal")
                            Image(systemName: "swatchpalette.fill")
                            
                        }.tag(1)
                        .toolbar(.hidden, for: .tabBar)
                    
                } else {
                    if let paletteNumber = paletteNumber {
                        ResultsView(paletteNumber: paletteNumber)
                            .tabItem {
                                
                                Text("Coloração pessoal")
                                Image(systemName: "swatchpalette.fill")
                                
                            }.tag(1)
                            .toolbar(.hidden, for: .tabBar)
                    }
                }
            } else {
                PersonalColoringTabItem()
                    .tabItem {
                        
                        Text("Coloração pessoal")
                        Image(systemName: "swatchpalette.fill")
                        
                    }.tag(1)
                    .toolbar(.hidden, for: .tabBar)
            }
            
            
//            Text("Aba de Estilos")
//                .tabItem {
//                    
//                    Text("Estilos")
//                    Image(systemName: "rectangle.fill.badge.person.crop")
//                    
//                }.tag(2)
//            
//            Text("Aba de Inspirações")
//                .tabItem {
//                    
//                    Text("Inspirações")
//                    Image(systemName: "wand.and.rays")
//                    
//                }.tag(3)
        })
        .onChange(of: redoTest.didRedoTest) {
            if redoTest.didRedoTest == true {
                result = true
                redoTest.didRedoTest = false
            }
        }
        
        
    }
}
