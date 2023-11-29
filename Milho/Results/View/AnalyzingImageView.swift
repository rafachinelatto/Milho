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
    @ObservedObject var viewModelV2 = ImageAnalysisViewModel()
    
    var body: some View {
        VStack {
            //            switch viewModel.state {
            //            case .idle:
            //                Color.clear
            //                    .onAppear{
            //                        DispatchQueue.main.async {
            //                            viewModelV2.getColorPallet(image: image)
            //                        }
            //                    }
            //            case .loading:
            //                LoadingResultsView()
            //
            //            case .failed:
            //                NegativeFeedbackView()
            //
            //            case .loaded:
            //                PositiveFeedbackView()
            //            }
            
            
            if let skinColorImage = viewModelV2.skinColorImage {
                Image(uiImage: skinColorImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Button("Ver imagem") {
                    DispatchQueue.main.async {
                        viewModelV2.getColorPallet(image: image)
                    }
                }
            }
            
        }
    }
}

#Preview {
    AnalyzingImageView(image: UIImage())
}
