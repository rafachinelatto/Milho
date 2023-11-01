//
//  PersonalColoringView.swift
//  Milho
//
//  Created by Anderson  Vulto on 01/11/23.
//

import SwiftUI

struct PersonalColoringView: View {
    
    @State private var currentTab = 0
    @State private var enable = false
    
    var body: some View {
        VStack (spacing: 42){
            TabView (selection: $currentTab) {
                ForEach (OnboardingData.list) {viewData in
                    PersonalColoringOnboardingView(data: viewData)
                        .tag(viewData.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            .onChange(of: currentTab) {
                if currentTab == 4 {
                    enable = true
                }
            }
            Button(action: {
                
            }, label: {
                Text("Fazer o teste")
                    .font(.system(size: 19, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding(5)
            })
            .buttonStyle(.borderedProminent)
            .disabled(!enable)
            
        }
        .padding(16)
    }
}
