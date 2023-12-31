//
//  PersonalColoringView.swift
//  Milho
//
//  Created by Anderson  Vulto on 01/11/23.
//

import SwiftUI

struct PersonalColoring: View {
    
    @State private var currentTab = 0
    @State private var completeOnboarding = false
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        VStack (spacing: 24){
            TabView (selection: $currentTab) {
                ForEach (OnboardingData.list) {viewData in
                    PersonalColoringOnboarding(data: viewData)
                        .tag(viewData.id)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            .onChange(of: currentTab) {
                if currentTab == 4 {
                    completeOnboarding = true
                }
            }
            
            Button {
               isOnboarding = false
            } label: {
                Text("Navegar pelo app")
                    .frame(height: UIScreen.main.bounds.height/25)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!completeOnboarding)
            
        }
        .padding(16)
    }
}

#Preview {
    PersonalColoring()
}
