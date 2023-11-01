//
//  PersonalColoringView.swift
//  Milho
//
//  Created by Anderson  Vulto on 01/11/23.
//

import SwiftUI

struct PersonalColoringView: View {
    
    @State private var currentTab = 0
    @State private var completeOnboarding = false
    
    var body: some View {
        VStack (spacing: 24){
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
                    completeOnboarding = true
                }
            }
            
            Button {
                //End onboarding and navigate to app (TabBarView)
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
