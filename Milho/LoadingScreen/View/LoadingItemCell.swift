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
    
    let time: Double

    
    var body: some View {
        if isComplete {
            Image(systemName: "checkmark")
                .foregroundStyle(.gray)
        } else {
            ProgressView(value: progress, total: time)
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
            if progress < time {
                progress += 0.1
            } else {
                timer?.invalidate()
                isComplete = true
            }
        }
    }
}

#Preview {
    LoadingItemCell(time: 2.0)
}
