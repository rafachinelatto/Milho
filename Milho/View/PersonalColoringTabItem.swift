//
//  PersonalColoringTabItem.swift
//  Milho
//
//  Created by Anderson  Vulto on 01/11/23.
//

import SwiftUI

struct PersonalColoringTabItem: View {
    var body: some View {
        NavigationView {
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
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Coloração pessoal") //Change font to SF Pro Rounded or Pally
            .navigationBarTitleDisplayMode(.automatic)
            .padding(24)
        }
    }
}
