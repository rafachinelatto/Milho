//
//  TabBarView.swift
//  Milho
//
//  Created by Anderson  Vulto on 01/11/23.
//
import SwiftUI

struct TabBar: View {
    
    @State private var selectedTab = 0
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
            
            PersonalColoringTabItem()
                .tabItem {
                    
                    Text("Coloração pessoal")
                    Image(systemName: "swatchpalette.fill")
                    
                }.tag(1)
            
            Text("Aba de Estilos")
                .tabItem {
                    
                    Text("Estilos")
                    Image(systemName: "rectangle.fill.badge.person.crop")
                    
                }.tag(2)
            
            Text("Aba de Inspirações")
                .tabItem {
                    
                    Text("Inspirações")
                    Image(systemName: "wand.and.rays")
                    
                }.tag(3)
        })
    }
}
