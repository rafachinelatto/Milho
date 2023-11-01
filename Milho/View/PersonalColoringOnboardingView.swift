//
//  PersonalColoringOnboardingView.swift
//  Milho
//
//  Created by Anderson  Vulto on 01/11/23.
//

import SwiftUI

struct PersonalColoringOnboardingView: View {
    
    var data: OnboardingData
    
    var body: some View {
        VStack {
            Image(data.backgroundImage)
                .resizable()
                .ignoresSafeArea(.all)
                .scaledToFit()
            
            VStack (spacing: 16) {
                Text(data.titleText)
                    .font(.title)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                Text(data.bodyText)
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalColoringOnboardingView(data: OnboardingData.list.first!)
    }
}
