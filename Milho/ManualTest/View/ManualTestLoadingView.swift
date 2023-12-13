//
//  ManualTestLoadingView.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 12/12/23.
//

import SwiftUI

struct ManualTestLoadingView: View {
    
    
    enum LoadingState {
        case loading
        case loaded
    }
    
    @State var state: LoadingState = .loading
    var paletteNumber: Int
    
    var body: some View {
        VStack {
            switch state {
            case .loading:
                LoadingResultsView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                            state = .loaded
                        }
                    }
                
            case .loaded:
                PositiveFeedbackView(paletteNumberResult: paletteNumber)
            }
            
        }
    }
}

#Preview {
    ManualTestLoadingView(paletteNumber: 3)
}
