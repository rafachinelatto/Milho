//
//  AnalyzingImageView.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 23/11/23.
//

import SwiftUI

struct AnalyzingImageView: View {
    
    enum LoadingState {
        case idle
        case loading
        case loaded
    }
    
    var image: UIImage
    
    @EnvironmentObject var manualTestModel: ManualTestModel
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModelV2 = ImageAnalysisViewModel()
    var isManualTest: Bool
    @State var state: LoadingState = .idle
    @State var paletteNumber: Int?
    
    var body: some View {
        VStack {
            
            switch state {
            case .idle:
                
                if !isManualTest {
                    
                    Color.clear
                        .onAppear {
                            DispatchQueue.main.async {
                                viewModelV2.getColorPallet(image: image)
                                paletteNumber = viewModelV2.colorPalette?.rawValue
                                state = .loading
                            }
                        }
                } else {
                    TabBar()
                        .onAppear {
                            manualTestModel.image = image
                            manualTestModel.showManualTest = true
                        }
                        
                }
                
                
                
            case .loading:
                LoadingResultsView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                            state = .loaded
                        }
                    }
            case .loaded:
                if let paletteNumber = paletteNumber {
                    PositiveFeedbackView(paletteNumberResult: paletteNumber)
                } else {
                    NegativeFeedbackView()
                }
            }
            
            
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
//                if let paletteNumber = viewModelV2.colorPalette {
//                    PositiveFeedbackView(paletteNumberResult: paletteNumber.rawValue)
//                }
//            }
            
        }
    }
}

#Preview {
    AnalyzingImageView(image: UIImage(), isManualTest: false)
}
