//
//  ManualTestV2.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 06/12/23.
//

import SwiftUI

struct ManualTestV2: View {
    
    var image: UIImage
    
    @State private var manualCurrentPage = 0
    @State private var temperature =  0
    @State private var lastManualPage = false
    @State private var results: [Int] = [0, 0, 0, 0, 0]
    
    @ObservedObject var viewModel = ImageComparisonTableCellViewModel()
    
    var icons = ["flame", "snowflake", "sleep.circle"]
    var names = ["Quente", "Frio", "Neutro"]
    
    @State var hotSelected: Bool = true
    
    var body: some View {
        List {
            Section {
                VStack {
                    if let cutImage = viewModel.cutImage {
                        
                        if temperature == 2 {
                            Image(uiImage: cutImage)
                                .resizable()
                                .scaledToFit()
                                .background(LinearGradient(colors: [colorsArray[self.manualCurrentPage].colors[0], colorsArray[self.manualCurrentPage].colors[1]], startPoint: UnitPoint(x: -0.06, y: 0.5), endPoint: UnitPoint(x: 1, y: 0.5)))
                        }
                        else {
                            Image(uiImage: cutImage)
                                .resizable()
                                .scaledToFit()
                                .background(colorsArray[self.manualCurrentPage].colors[self.temperature])
                        }
                    }
                }
                .mask {
                    RoundedRectangle(cornerSize: CGSize(width: UIScreen.main.bounds.height / 40, height: UIScreen.main.bounds.height / 40))
                }
                .onAppear {
                    viewModel.getRect(image: image)
                }
                .listRowBackground(Color.clear)
            }
            
            
            Section {
                
                HStack {
                    TemperatureSelectionView(selected: self.temperature == 0, icon: icons[0], name: names[0])
                        .onTapGesture {
                            temperature = 0
                        }
                    
                    Spacer()
                    
                    TemperatureSelectionView(selected: self.temperature == 1, icon: icons[1], name: names[1])
                        .onTapGesture {
                            temperature = 1
                        }
                    
                    Spacer()
                    
                    TemperatureSelectionView(selected: self.temperature == 2, icon: icons[2], name: names[2])
                        .onTapGesture {
                            temperature = 2
                        }
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollIndicators(.hidden)
        .listSectionSpacing(4)
    }
}

