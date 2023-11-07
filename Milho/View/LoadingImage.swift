//
//  LoadingImageView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct LoadingImage: View {
    let images = ["magglassLoading", "mibLoading", "shoeLoading"]
    @State var activeImageIndex = 0
    @State var show = false
    
    let imageSwitchTimer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        Image(images[activeImageIndex])
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
            .animation(.interpolatingSpring, value: show)
            .onReceive(imageSwitchTimer) { _ in
                self.activeImageIndex = (self.activeImageIndex + 1) % self.images.count
            }
    }
}

#Preview {
    LoadingImage()
}
