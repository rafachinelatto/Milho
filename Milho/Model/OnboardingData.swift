//
//  OnboardingData.swift
//  Milho
//
//  Created by Anderson  Vulto on 01/11/23.
//

import SwiftUI

struct OnboardingData: Hashable, Identifiable {
    let id: Int
    let backgroundImage: String
    let titleText: String
    let bodyText: String
    
    static let list: [OnboardingData] = [
        OnboardingData(id: 0, 
                       backgroundImage: "onboarding1",
                       titleText: "O círculo cromático",
                       bodyText: "O círculo cromático organiza as cores em 12 tons principais, facilitando a combinação na moda. Compreendê-lo ajuda a criar looks harmoniosos e expressivos."),
        OnboardingData(id: 1,
                       backgroundImage: "onboarding2",
                       titleText: "Dicas de iluminação",
                       bodyText: "Boa iluminação para o teste de coloração pessoal requer luz natural e incandescente para revelar cores com precisão e destacar sua aparência."),
        OnboardingData(id: 2,
                       backgroundImage: "onboarding3",
                       titleText: "Pele, olhos e cabelo!",
                       bodyText: "Conhecer sua cor de cabelo, tom de pele e cor dos olhos é essencial para looks que realçam sua beleza natural de forma impactante e harmoniosa."),
        OnboardingData(id: 3,
                       backgroundImage: "onboarding4",
                       titleText: "Tons quentes",
                       bodyText: "Tons quentes, como vermelho e laranja, irradiam energia e vitalidade. Na moda, trazem ousadia e vivacidade ao seu estilo."),
        OnboardingData(id: 4,
                       backgroundImage: "onboarding5",
                       titleText: "Tons frios",
                       bodyText: "Tons frios, como azul e verde, transmitem calma e elegância. Na moda, proporcionam uma estética sofisticada e equilibrada.")
    ]
}
