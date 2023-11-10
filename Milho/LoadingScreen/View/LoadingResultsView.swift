//
//  LoadingResultsView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct LoadingResultsView: View {

    @State private var activeImageIndex = 0
    @State private var show = false
    
    var body: some View {
            VStack (alignment: .center, spacing: 32) {
                LoadingImage()
                LoadingInfoView()
            }
        }
    }

#Preview {
    LoadingResultsView()
}
