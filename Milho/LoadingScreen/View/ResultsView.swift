//
//  ResultsView.swift
//  Milho
//
//  Created by Anderson  Vulto on 22/11/23.
//

import SwiftUI

struct ResultsView: View {
    
    @AppStorage("testCompleted") var testCompleted: Bool?
    
    var body: some View {
        NavigationView {
            
            ResultsListView()
            
            Button(action: {
                testCompleted = true
            }, label: {
                Text("Fazer o teste novamente")
            })
            .frame(width: 100, height: 200)
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ResultsView()
}
