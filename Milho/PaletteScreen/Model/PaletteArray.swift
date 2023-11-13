//
//  PaletteArray.swift
//  Milho
//
//  Created by Ana Elisa Lima on 10/11/23.
//

import Foundation

class PaletteArray {
    var palette: [PaletteData] = []
    
    init() {
        let pureSpring: PaletteData = PaletteData(paletteImage: "primaveraPura", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(pureSpring)
        
        let brightSpring: PaletteData = PaletteData(paletteImage: "primaveraIntensa", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(brightSpring)
        
        let clearSpring: PaletteData = PaletteData(paletteImage: "primaveraClara", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(clearSpring)
        
        let pureSummer: PaletteData = PaletteData(paletteImage: "veraoPuro", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(pureSummer)
        
        let softSummer: PaletteData = PaletteData(paletteImage: "veraoSuave", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(softSummer)
        
        let clearSummer: PaletteData = PaletteData(paletteImage: "veraoClaro", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(clearSummer)
        
        let pureAutumn: PaletteData = PaletteData(paletteImage: "outonoPuro", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(pureAutumn)
        
        let softAutumn: PaletteData = PaletteData(paletteImage: "outonoSuave", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(softAutumn)
        
        let darkAutumn: PaletteData = PaletteData(paletteImage: "outonoProfundo", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(darkAutumn)
        
        let pureWinter: PaletteData = PaletteData(paletteImage: "invernoPuro", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(pureWinter)
        
        let brightWinter: PaletteData = PaletteData(paletteImage: "invernoIntenso", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(brightWinter)
        
        let darkWinter: PaletteData = PaletteData(paletteImage: "invernoProfundo", paletteDescription: "Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.")
        palette.append(darkWinter)
    }
}
