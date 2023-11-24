//
//  PersonalColoringTabItem.swift
//  Milho
//
//  Created by Anderson  Vulto on 01/11/23.
//

import SwiftUI

struct PersonalColoringTabItem: View {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()

                Text("Você ainda não realizou o teste de coloração pessoal :(")
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                NavigationLink {
                    PersonalColorTestChooserView()
                } label: {
                    Text("Fazer o teste")
                        .frame(height: UIScreen.main.bounds.height/21)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Button(action: {
                    isOnboarding = true
                }, label: {
                    Text("Rever as dicas para o teste")
                })
            }
            .navigationTitle("Coloração pessoal") //Change font to SF Pro Rounded or Pally
            .navigationBarTitleDisplayMode(.automatic)
            .padding(24)
        }
    }
}
