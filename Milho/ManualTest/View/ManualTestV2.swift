//
//  ManualTestV2.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 06/12/23.
//

import SwiftUI

struct ManualTestV2: View {
    
    var image: UIImage
    
    @Environment(\.dismiss) var dismiss
    
    @State private var manualCurrentPage = 0
    @State private var temperature: [Int] =  [0, 0, 0, 0, 0]
    @State private var lastManualPage = false
    @State private var results: [Int?] = [nil, nil, nil, nil, nil]
    
    @ObservedObject var viewModel = ImageComparisonTableCellViewModel()
    
    var icons = ["flame", "snowflake", "sleep.circle"]
    var names = ["Quente", "Frio", "Neutro"]
    
    @State var hotSelected: Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    HStack {
                        Spacer()
                        Text("\(manualCurrentPage + 1) de 5")
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                
                Section {
                    
                    
                    
                    VStack {
                        if let cutImage = viewModel.cutImage {
                            
                            if temperature[self.manualCurrentPage] == 2 {
                                HStack {
                                    Spacer()
                                    Image(uiImage: cutImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: UIScreen.main.bounds.height*0.4)
                                        .background(LinearGradient(colors: [colorsArray[self.manualCurrentPage].colors[0], colorsArray[self.manualCurrentPage].colors[1]], startPoint: UnitPoint(x: -0.06, y: 0.5), endPoint: UnitPoint(x: 1, y: 0.5)))
                                        .mask {
                                            RoundedRectangle(cornerSize: CGSize(width: UIScreen.main.bounds.height / 40, height: UIScreen.main.bounds.height / 40))
                                        }
                                    Spacer()
                                }
                            }
                            else {
                                HStack {
                                    Spacer()
                                    Image(uiImage: cutImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: UIScreen.main.bounds.height*0.4)
                                        .background(colorsArray[self.manualCurrentPage].colors[self.temperature[self.manualCurrentPage]])
                                        .mask {
                                            RoundedRectangle(cornerSize: CGSize(width: UIScreen.main.bounds.height / 40, height: UIScreen.main.bounds.height / 40))
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .onAppear {
                        viewModel.getRect(image: image)
                    }
                    .listRowBackground(Color.clear)
                }
                
                
                Section(content: {
                    
                    HStack {
                        TemperatureSelectionView(selected: self.temperature[self.manualCurrentPage] == 0, icon: icons[0], name: names[0])
                            .onTapGesture {
                                temperature[self.manualCurrentPage] = 0
                            }
                        
                        Spacer()
                        
                        TemperatureSelectionView(selected: self.temperature[self.manualCurrentPage] == 1, icon: icons[1], name: names[1])
                            .onTapGesture {
                                temperature[self.manualCurrentPage] = 1
                            }
                        
                        Spacer()
                        
                        TemperatureSelectionView(selected: self.temperature[self.manualCurrentPage] == 2, icon: icons[2], name: names[2])
                            .onTapGesture {
                                temperature[self.manualCurrentPage] = 2
                            }
                    }
                }, header: {
                    Text("Selecione a temperatura")
                }) {
                    Text("Saiba qual é o subtom mais adequado para sua pele. Alterne entre as temperaturas quente, frio e neutro para descobrir.")
                }
                
                Section {
                    
                    if manualCurrentPage == 4 {
                        
                        Button(action: {
                            self.results[self.manualCurrentPage] = self.temperature[self.manualCurrentPage]
                            print(results)
                            dismiss()
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Finalizar")
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                        })
                        
                    } else {
                        
                        Button(action: {
                            self.results[self.manualCurrentPage] = self.temperature[self.manualCurrentPage]
                            self.manualCurrentPage += 1
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Próxima")
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                        })
                    }
                }
                .listRowBackground(Color.accentColor)
                
                
            }
            .listStyle(.insetGrouped)
            .scrollIndicators(.hidden)
            .listSectionSpacing(4)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button (action: {
                        if self.manualCurrentPage != 0 {
                            self.manualCurrentPage -= 1
                        } else {
                            dismiss()
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Voltar")
                        }
                        
                    })
                }
            }
            .navigationTitle("Teste manual")
        }
    }
}

