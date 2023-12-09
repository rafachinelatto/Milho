//
//  MilhoApp.swift
//  Milho
//
//  Created by Rafael Antonio Chinelatto on 03/10/23.
//

import SwiftUI

@main
struct MilhoApp: App {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @State var showModal: Bool = false
    
    var body: some Scene {
        
        WindowGroup {
            if isOnboarding {
                PersonalColoring()
            } else {
                NavigationStack {
                    
                    Text("Mostrar Modal")
                        .onTapGesture {
                            showModal = true
                        }
                        .sheet(isPresented: $showModal, content: {
                            ManualTestV2(image: UIImage(named: "eu") ?? UIImage())
                        })
                }
                //TabBar()
            }
            
            }
        }
    }
