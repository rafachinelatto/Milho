//
//  LoadingImageView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct LoadingItemCell: View {
    
    @State private var progress: Double = 0.0
    @State private var timer: Timer? = nil
    @State private var isComplete = false

    
    var body: some View {
        if isComplete {
            Image(systemName: "checkmark")
        } else {
            ProgressView(value: progress, total: 1.3)
                .font(Font.custom("SF Pro", size: 17))
                .progressViewStyle(.circular)
                .onAppear {
                    startProgress()
                }
        }
        
    }
    
    func startProgress() {
        progress = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if progress < 1.3 {
                progress += 0.1
            } else {
                timer?.invalidate()
                isComplete = true
            }
        }
    }
}

#Preview {
    LoadingItemCell()
}
