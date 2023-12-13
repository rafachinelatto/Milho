//
//  ManualTestV2.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 06/12/23.
//

import SwiftUI

struct ManualTestV2: View {
    
    @EnvironmentObject var manualTestModel: ManualTestModel
    @Environment(\.dismiss) var dismiss
    
    
    @State private var testFaild: Bool = false
    @State private var manualCurrentPage = 0
    @State private var temperature: [Int] =  [0, 0, 0, 0, 0]
    @State private var results: [Int?] = [nil, nil, nil, nil, nil] // Variável que pode estar salvando no user defaults.
    @State private var hairColor = "Castanho Claro"
    @State private var eyeColor = "Castanho Claro"
    
    @ObservedObject var viewModel = ImageComparisonTableCellViewModel()
    
    var eyeColors = ["Azul", "Verde", "Castanho Claro", "Castanho Escuro", "Cinza"]
    var hairColors = ["Castanho Claro", "Castanho Escuro", "Preto", "Loiro", "Ruivo"]
    var icons = ["flame", "snowflake", "sleep.circle"]
    var names = ["Quente", "Frio", "Neutro"]
    
    @Binding var paletteNumber: Int
    @Binding var showResults: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Spacer()
                        Text("\(manualCurrentPage + 1) de 6")
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                
                
                if manualCurrentPage != 5 {
                    
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
                            viewModel.getRect(image: manualTestModel.image)
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
                    .listRowBackground(Color.accentColor)
                    
                }
                
                else {
                    
                    Section {
                        HStack {
                            Spacer()
                            Image(uiImage: manualTestModel.image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: UIScreen.main.bounds.height*0.4)
                                .mask {
                                    RoundedRectangle(cornerSize: CGSize(width: UIScreen.main.bounds.height / 40, height: UIScreen.main.bounds.height / 40))
                                }
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.clear)
                    
                    
                    Section {
                        Picker("Cor do cabelo:", selection: $hairColor) {
                            ForEach(hairColors, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section {
                        Picker("Cor dos olhos:", selection: $eyeColor) {
                            ForEach(eyeColors, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Spacer()
                        .listRowBackground(Color.clear)
                    
                    Section {
                        Button(action: {
                            
                            if let contrast = viewModel.contrast {
                                let palette = getResults(temperatures: self.temperature, contrast: contrast.rawValue, eyeColor: eyeColor, hairColor: hairColor)
                                
                                self.paletteNumber = palette.rawValue
                                self.showResults = true
                                
                                dismiss()
                                
                            } else {
                                self.testFaild = true
                                dismiss()
                            }
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Finalizar")
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                        })
                    }
                    .listRowBackground(Color.accentColor)
                }
                
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
                            manualTestModel.showManualTest = false
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
    
    
    private func getResults(temperatures: [Int], contrast: Int, eyeColor: String, hairColor: String) -> Seasons {
        
        enum Temperature {
            case hot
            case cold
        }
        
        var skinTemperature: Temperature
        
        var coldQuant = 0
        var hotQaunt = 0
        var neutralQuant = 0
        for i in 0..<temperatures.count {
            if temperatures[i] == 0 {
                hotQaunt += 1
            } else if temperatures[i] == 1 {
                coldQuant += 1
            } else {
                neutralQuant += 1
            }
        }
        
        if hotQaunt > coldQuant {
            skinTemperature = .hot
        } else {
            skinTemperature = .cold
        }
        
        if contrast == 2 {
            if skinTemperature == .hot {
                return .outonoPuro
            }
            else {
                if hairColor == "Preto" {
                    return .invernoIntenso
                } else {
                    if eyeColor == "Azul" || eyeColor == "Verde" {
                        return .invernoIntenso
                    } else {
                        return .veraoPuro
                    }
                }
            }
        }
        
        else if contrast == 1 {
            if skinTemperature == .hot {
                if hairColor == "Loiro" {
                    return .outonoSuave
                } else if hairColor == "Ruivo" {
                    return .primaveraPura
                } else {
                    if eyeColor == "Castanho Escuro" {
                        return .outonoSuave
                    } else {
                        return .primaveraPura
                    }
                }
            }
            else {
                if hairColor == "Preto" {
                    return .invernoPuro
                } else {
                    return .veraoSuave
                }
            }
        }
        
        else {
            if skinTemperature == .cold {
                if hairColor == "Preto" || hairColor == "Castanho Escuro" {
                    return .invernoProfundo
                } else {
                    return .veraoClaro
                }
            } else {
                if hairColor == "Preto"  || hairColor == "Castanho Escuro" {
                    return .outonoProfundo
                } else {
                    if eyeColor == "Castanho Escuro" {
                        return .primaveraClara
                    } else {
                        return .primaveraIntensa
                    }
                }
            }
        }
    }
}

