//
//  AnalyzingImageView.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 23/11/23.
//

import SwiftUI

struct AnalyzingImageView: View {
    
    var image: UIImage
    @ObservedObject var viewModel = ColorAnalysis()
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
                .onAppear{
                    viewModel.inputImage = image
                    viewModel.analysis()
                    
                }
        case .loading:
            LoadingResultsView()
                
        case .failed:
            NegativeFeedbackView()
            
        case .loaded:
            PositiveFeedbackView()
        }
    
    }
}

#Preview {
    AnalyzingImageView(image: UIImage())
}
