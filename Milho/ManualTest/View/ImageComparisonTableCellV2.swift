//
//  ImageComparisonTableCellV2.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 06/12/23.
//

import SwiftUI

struct ImageComparisonTableCellV2: View {
    
    
    var colors: [Color]
    var image: UIImage
    
    @ObservedObject var viewModel = ImageComparisonTableCellViewModel()
    
    var body: some View {
        
        VStack {
            if let cutImage = viewModel.cutImage {
                Image(uiImage: cutImage)
                    .resizable()
                    .scaledToFit()
                    .background(LinearGradient(colors: [.cyan, .orange], startPoint: UnitPoint(x: -0.06, y: 0.5), endPoint: UnitPoint(x: 1, y: 0.5)))
            }
        }
        .mask {
            RoundedRectangle(cornerSize: CGSize(width: UIScreen.main.bounds.height / 40, height: UIScreen.main.bounds.height / 40))
        }
        .onAppear {
            viewModel.getRect(image: image)
        }
        
    }
}


#Preview {
    ImageComparisonTableCellV2(colors: [], image: UIImage(named: "eu") ?? UIImage())
}
