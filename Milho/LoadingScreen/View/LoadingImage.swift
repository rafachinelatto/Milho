//
//  LoadingImageView.swift
//  Milho
//
//  Created by Ana Elisa Lima on 06/11/23.
//

import SwiftUI

struct LoadingImage: View {
    
    let images = ["magglassLoading", "mibLoading", "shoeLoading"]
    let texts = ["Procurando algum pelo no ovo", "Verificando com a equipe de segurança", "Levantando voo rumo à lua"]
    
    @State var activeImageIndex = 0
    @State var show = false
    
    let imageSwitchTimer = Timer.publish(every: 1.3, on: .main, in: .common)
        .autoconnect()
    
    let textSwitchTimer = Timer.publish(every: 1.3, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        VStack (spacing: 64){
            Image(images[activeImageIndex])
                .clipShape(.rect(cornerRadius: 40))
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .animation(.interpolatingSpring, value: show)
                .onReceive(imageSwitchTimer) { _ in
                    self.activeImageIndex = (self.activeImageIndex + 1) % self.images.count
                }
            
            Text(texts[activeImageIndex])
                .font(Font.custom("SF Pro Rounded", size: 19)
                .weight(.semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .padding()
                .onReceive(textSwitchTimer) { _ in
                    self.activeImageIndex = (self.activeImageIndex + 1) % self.texts.count
                }
        }
    }
}

#Preview {
    LoadingImage()
}
