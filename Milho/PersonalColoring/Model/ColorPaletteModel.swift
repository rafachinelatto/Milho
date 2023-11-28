import SwiftUI

struct HexColor: Comparable, Hashable {
    let hexCode: String
    
    static func < (lhs: HexColor, rhs: HexColor) -> Bool {
        return lhs.hexCode < rhs.hexCode
    }
}

struct ColorPalette: Hashable, Identifiable {
    let id: Int
    let backgroundImage: String
    let description: String
    let idealColors: [HexColor]
    let neutralColors: [HexColor]
    let accessoriesColors: [HexColor]
}

let paletteList: [ColorPalette] = [
    
    //Primavera Pura
    ColorPalette(
        id: 0,
        backgroundImage: "primaveraPura",
        description: "Capta a energia e o frescor da estação, perfeita para um estilo enérgico e radiante, refletindo a vitalidade da primavera.",
        idealColors: [
            HexColor(hexCode: "FFD568"), HexColor(hexCode: "FFA26A"), HexColor(hexCode: "FE4C64"),
            HexColor(hexCode: "FF5245"), HexColor(hexCode: "4BB162"), HexColor(hexCode: "59CCD9"),
            HexColor(hexCode: "F2A78F"), HexColor(hexCode: "EF8077"), HexColor(hexCode: "CFD167"),
            HexColor(hexCode: "AEAF4C"), HexColor(hexCode: "3C8F69"), HexColor(hexCode: "98E097"),
            HexColor(hexCode: "76C16B"), HexColor(hexCode: "5ED6C5"), HexColor(hexCode: "48A9BC"),
            HexColor(hexCode: "2F739B"), HexColor(hexCode: "3A5CBC"), HexColor(hexCode: "CDC5EF"),
            HexColor(hexCode: "AFA5E9"), HexColor(hexCode: "9384DA"), HexColor(hexCode: "D598DA"),
            HexColor(hexCode: "9D43AF")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "FDEFCD"), HexColor(hexCode: "F2C1A6"), HexColor(hexCode: "EBE5E4"),
            HexColor(hexCode: "A99395"), HexColor(hexCode: "DDB088"), HexColor(hexCode: "9B7458")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "F9E193")
        ].sorted(by: >)
    ),
    
    //Primavera Intensa
    ColorPalette(
        id: 1,
        backgroundImage: "primaveraIntensa",
        description: "Tons vibrantes e marcantes que capturam a exuberância e intensidade da estação, ideais para um visual cativante e cheio de vitalidade.",
        idealColors: [
            HexColor(hexCode: "F9F185"), HexColor(hexCode: "EF8261"), HexColor(hexCode: "F2B297"),
            HexColor(hexCode: "DF5661"), HexColor(hexCode: "58CB91"), HexColor(hexCode: "364FA9"),
            HexColor(hexCode: "CF6933"), HexColor(hexCode: "F3A9BD"), HexColor(hexCode: "EB6683"),
            HexColor(hexCode: "ED70B1"), HexColor(hexCode: "B73B84"), HexColor(hexCode: "D4E494"),
            HexColor(hexCode: "B6C863"), HexColor(hexCode: "659E3A"), HexColor(hexCode: "2A673D"),
            HexColor(hexCode: "C5F3F9"), HexColor(hexCode: "60DEF0"), HexColor(hexCode: "439CAA"),
            HexColor(hexCode: "A4BCDD"), HexColor(hexCode: "D9D1F0"), HexColor(hexCode: "C697E3"),
            HexColor(hexCode: "7C3EA6")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "F9F6E2"), HexColor(hexCode: "E3E2DF"), HexColor(hexCode: "83888D"),
            HexColor(hexCode: "292638"), HexColor(hexCode: "998A83"), HexColor(hexCode: "4E3D3E")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "E0D8DD"), HexColor(hexCode: "F9E193")
        ].sorted(by: >)
    ),
    
    //Primavera Clara
    ColorPalette(
        id: 2,
        backgroundImage: "primaveraClara",
        description: "Suave e luminosa, reflete a delicadeza da estação proporcionando um estilo radiante e suave",
        idealColors: [
            HexColor(hexCode: "F9E585"), HexColor(hexCode: "F18B63"), HexColor(hexCode: "F18B80"),
            HexColor(hexCode: "71C661"), HexColor(hexCode: "4FB9E3"), HexColor(hexCode: "C79AE5"),
            HexColor(hexCode: "FCF79D"), HexColor(hexCode: "F6BF7C"), HexColor(hexCode: "F4C0C6"),
            HexColor(hexCode: "ED6362"), HexColor(hexCode: "F195AF"), HexColor(hexCode: "B0E19C"),
            HexColor(hexCode: "4AAD81"), HexColor(hexCode: "7BE1D2"), HexColor(hexCode: "46A3A4"),
            HexColor(hexCode: "CDE0FB"), HexColor(hexCode: "A7BDEF"), HexColor(hexCode: "A0D9F6"),
            HexColor(hexCode: "B9B6E5"), HexColor(hexCode: "7B64C1"), HexColor(hexCode: "583C9B"),
            HexColor(hexCode: "975DA9")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "FBF7E2"), HexColor(hexCode: "F9E8D6"), HexColor(hexCode: "F3D5B7"),
            HexColor(hexCode: "CFC2B2"), HexColor(hexCode: "958B89"), HexColor(hexCode: "8C6852")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "E0D8DD"), HexColor(hexCode: "F9E193")
        ].sorted(by: >)
    ),
    
    //Verão Puro
    ColorPalette(
        id: 3,
        backgroundImage: "veraoPuro",
        description: "Frescor e serenidade, capturando a essência calma e tranquila da estação para um estilo refinado e delicado.",
        idealColors: [
            HexColor(hexCode: "F1ECB4"), HexColor(hexCode: "F0AAC3"), HexColor(hexCode: "AB3965"),
            HexColor(hexCode: "63C6A9"), HexColor(hexCode: "91D7F9"), HexColor(hexCode: "998BBE"),
            HexColor(hexCode: "E3CCCC"), HexColor(hexCode: "654C4D"), HexColor(hexCode: "B99290"),
            HexColor(hexCode: "9E9EAC"), HexColor(hexCode: "7EA2B4"), HexColor(hexCode: "317589"),
            HexColor(hexCode: "FF979E"), HexColor(hexCode: "D2546A"), HexColor(hexCode: "A54953"),
            HexColor(hexCode: "4096C0"), HexColor(hexCode: "C1CFF4"), HexColor(hexCode: "88AAD3"),
            HexColor(hexCode: "6373AD"), HexColor(hexCode: "44518C"), HexColor(hexCode: "CDBFE8"),
            HexColor(hexCode: "795996")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "F5EFEB"), HexColor(hexCode: "D6D7DE"), HexColor(hexCode: "C3BEB3"),
            HexColor(hexCode: "AF9D99"), HexColor(hexCode: "8B7A68"), HexColor(hexCode: "767275")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "E0D8DD")
        ].sorted(by: >)
    ),
    
    //Verão Suave
    ColorPalette(
        id: 4,
        backgroundImage: "veraoSuave",
        description: "Tons suaves e serenos que refletem a calma e a delicadeza da estação, ideais para um estilo elegante e sutil.",
        idealColors: [
            HexColor(hexCode: "F7E9C1"), HexColor(hexCode: "D58DA5"), HexColor(hexCode: "A73E4D"),
            HexColor(hexCode: "84A997"), HexColor(hexCode: "B3CFE0"), HexColor(hexCode: "8B6D83"),
            HexColor(hexCode: "C1A5A4"), HexColor(hexCode: "DED5DC"), HexColor(hexCode: "F7DAE7"),
            HexColor(hexCode: "F5B3B9"), HexColor(hexCode: "EF748B"), HexColor(hexCode: "C05052"),
            HexColor(hexCode: "BA4562"), HexColor(hexCode: "6C364E"), HexColor(hexCode: "BCD3BB"),
            HexColor(hexCode: "35644B"), HexColor(hexCode: "79B1BE"), HexColor(hexCode: "6D8AA3"),
            HexColor(hexCode: "4B6470"), HexColor(hexCode: "BDBED9"), HexColor(hexCode: "7A7598"),
            HexColor(hexCode: "3F3150")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "F9F3E7"), HexColor(hexCode: "E8DBD9"), HexColor(hexCode: "79564E"),
            HexColor(hexCode: "DAD3D0"), HexColor(hexCode: "8B8381"), HexColor(hexCode: "51443A")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "E0D8DD"), HexColor(hexCode: "F9E193")
        ].sorted(by: >)
    ),
    
    //Verão Claro
    ColorPalette(
        id: 5,
        backgroundImage: "veraoClaro",
        description: "Tons suaves e luminosos, transmitindo leveza e delicadeza, perfeitos para um estilo refinado e sofisticado.",
        idealColors: [
            HexColor(hexCode: "FBF3BD"), HexColor(hexCode: "F4BDD6"), HexColor(hexCode: "9FE7D9"),
            HexColor(hexCode: "5ED7E6"), HexColor(hexCode: "9EBDCD"), HexColor(hexCode: "C1A1DD"),
            HexColor(hexCode: "895F68"), HexColor(hexCode: "F4B2AA"), HexColor(hexCode: "EF8A77"),
            HexColor(hexCode: "DC5565"), HexColor(hexCode: "F8D1D9"), HexColor(hexCode: "F083A6"),
            HexColor(hexCode: "D37092"), HexColor(hexCode: "3F9578"), HexColor(hexCode: "429CA6"),
            HexColor(hexCode: "9FDBF3"), HexColor(hexCode: "80A6E3"), HexColor(hexCode: "3A6FB2"),
            HexColor(hexCode: "BBBCE7"), HexColor(hexCode: "898ACC"), HexColor(hexCode: "A27CBE"),
            HexColor(hexCode: "7E4F9D")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "FAF9EE"), HexColor(hexCode: "E3DDD9"), HexColor(hexCode: "D4C2BE"),
            HexColor(hexCode: "B9BBC0"), HexColor(hexCode: "959B9D"), HexColor(hexCode: "97857D")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "E0D8DD"), HexColor(hexCode: "F9E193")
        ].sorted(by: >)
    ),
    
    //Outono Puro
    ColorPalette(
        id: 6,
        backgroundImage: "outonoPuro",
        description: "Tons terrosos quentes para um estilo natural e sóbrio, evocando a beleza característica da estação.",
        idealColors: [
            HexColor(hexCode: "FBE997"), HexColor(hexCode: "EC5E41"), HexColor(hexCode: "B0323C"),
            HexColor(hexCode: "CDB863"), HexColor(hexCode: "52873B"), HexColor(hexCode: "3EA3A2"),
            HexColor(hexCode: "F5C1A5"), HexColor(hexCode: "D18A70"), HexColor(hexCode: "6B342F"),
            HexColor(hexCode: "A27F51"), HexColor(hexCode: "F3AD64"), HexColor(hexCode: "E87A46"),
            HexColor(hexCode: "BA6140"), HexColor(hexCode: "F08588"), HexColor(hexCode: "A34537"),
            HexColor(hexCode: "B2C598"), HexColor(hexCode: "358357"), HexColor(hexCode: "194535"),
            HexColor(hexCode: "5AC4E3"), HexColor(hexCode: "255B81"), HexColor(hexCode: "9D9DD1"),
            HexColor(hexCode: "6B5B9C")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "F9E1CE"), HexColor(hexCode: "E3D5D4"), HexColor(hexCode: "BCA8AA"),
            HexColor(hexCode: "846568"), HexColor(hexCode: "B3958A"), HexColor(hexCode: "64574E")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "F9E193")
        ].sorted(by: >)
    ),
    
    //Outono Suave
    ColorPalette(
        id: 7,
        backgroundImage: "outonoSuave",
        description: "Tons terrosos acolhedores para um estilo versátil e tranquilo, destacando a beleza sutil da estação.",
        idealColors: [
            HexColor(hexCode: "FFE5AC"), HexColor(hexCode: "F6BEBC"), HexColor(hexCode: "EA525E"),
            HexColor(hexCode: "EC8D47"), HexColor(hexCode: "8B9D83"), HexColor(hexCode: "708BBB"),
            HexColor(hexCode: "A6A124"), HexColor(hexCode: "72705C"), HexColor(hexCode: "F4C9A8"),
            HexColor(hexCode: "C18D7A"), HexColor(hexCode: "753A3A"), HexColor(hexCode: "B14131"),
            HexColor(hexCode: "F1919B"), HexColor(hexCode: "DB6D76"), HexColor(hexCode: "BEE1D3"),
            HexColor(hexCode: "48A0A1"), HexColor(hexCode: "2F6765"), HexColor(hexCode: "2F6942"),
            HexColor(hexCode: "A3B5D9"), HexColor(hexCode: "53437B"), HexColor(hexCode: "B8A8D3"),
            HexColor(hexCode: "9682B1")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "F4EFE7"), HexColor(hexCode: "DFD3C7"), HexColor(hexCode: "957E81"),
            HexColor(hexCode: "ABA2A9"), HexColor(hexCode: "7A7079"), HexColor(hexCode: "755345")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "E0D8DD"), HexColor(hexCode: "F9E193")
        ].sorted(by: >)
    ),
    
    //Outono Profundo
    ColorPalette(
        id: 8,
        backgroundImage: "outonoProfundo",
        description: "Tons terrosos intensos para um estilo marcante e sofisticado, refletindo a elegância da estação.",
        idealColors: [
            HexColor(hexCode: "FFBF00"), HexColor(hexCode: "F98D28"), HexColor(hexCode: "B0323C"),
            HexColor(hexCode: "CECF90"), HexColor(hexCode: "8E8750"), HexColor(hexCode: "515A7E"),
            HexColor(hexCode: "F3E0E0"), HexColor(hexCode: "875B6C"), HexColor(hexCode: "F8D39A"),
            HexColor(hexCode: "E59F7A"), HexColor(hexCode: "F1A4A1"), HexColor(hexCode: "EA736C"),
            HexColor(hexCode: "AD514A"), HexColor(hexCode: "4F4B33"), HexColor(hexCode: "425E5B"),
            HexColor(hexCode: "6CCBDB"), HexColor(hexCode: "63A5A1"), HexColor(hexCode: "9BC0E0"),
            HexColor(hexCode: "458DB3"), HexColor(hexCode: "D584AB"), HexColor(hexCode: "B9547A"),
            HexColor(hexCode: "562B66")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "F7F3E7"), HexColor(hexCode: "F7DBCA"), HexColor(hexCode: "FAE6C9"),
            HexColor(hexCode: "B89D99"), HexColor(hexCode: "8F7670"), HexColor(hexCode: "4A403B")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "E0D8DD")
        ].sorted(by: >)
    ),
    
    //Inverno Puro
    ColorPalette(
        id: 9,
        backgroundImage: "invernoPuro",
        description: "Cores frias e elegantes para um estilo refinado, transmitindo a sobriedade e a pureza da estação.",
        idealColors: [
            HexColor(hexCode: "F385B9"), HexColor(hexCode: "CC1565"), HexColor(hexCode: "CA4253"),
            HexColor(hexCode: "1DA38D"), HexColor(hexCode: "265AA1"), HexColor(hexCode: "5630A0"),
            HexColor(hexCode: "EE5F5C"), HexColor(hexCode: "57CA99"), HexColor(hexCode: "40995D"),
            HexColor(hexCode: "184438"), HexColor(hexCode: "52BEDA"), HexColor(hexCode: "54A0B6"),
            HexColor(hexCode: "86BBFA"), HexColor(hexCode: "2E72A3"), HexColor(hexCode: "F3ACE4"),
            HexColor(hexCode: "CB418A"), HexColor(hexCode: "872654"), HexColor(hexCode: "C470C6"),
            HexColor(hexCode: "944E97"), HexColor(hexCode: "8E5CAE"), HexColor(hexCode: "6858AF"),
            HexColor(hexCode: "46387B")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "F6F5F3"), HexColor(hexCode: "BEAAAA"), HexColor(hexCode: "E9E5EA"),
            HexColor(hexCode: "BAB6B9"), HexColor(hexCode: "7E7A80"), HexColor(hexCode: "52270E")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "E0D8DD")
        ].sorted(by: >)
    ),
    
    //Inverno Intenso
    ColorPalette(
        id: 10,
        backgroundImage: "invernoIntenso",
        description: "Tons marcantes que transmitem força e intensidade para um estilo ousado e sofisticado, destacando a profundidade das cores da estação.",
        idealColors: [
            HexColor(hexCode: "06BB94"), HexColor(hexCode: "F93B8D"), HexColor(hexCode: "D8115F"),
            HexColor(hexCode: "69199A"), HexColor(hexCode: "0272AB"), HexColor(hexCode: "1926A4"),
            HexColor(hexCode: "F2EEAB"), HexColor(hexCode: "C8DE5E"), HexColor(hexCode: "F3A59D"),
            HexColor(hexCode: "F0796E"), HexColor(hexCode: "C64C68"), HexColor(hexCode: "F199C1"),
            HexColor(hexCode: "E564B5"), HexColor(hexCode: "AF3C92"), HexColor(hexCode: "975FC1"),
            HexColor(hexCode: "5AD1A5"), HexColor(hexCode: "358050"), HexColor(hexCode: "2E7174"),
            HexColor(hexCode: "60DBF2"), HexColor(hexCode: "49A8E7"), HexColor(hexCode: "A4BFEF"),
            HexColor(hexCode: "B196DF")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "F5F2F0"), HexColor(hexCode: "DEDCE0"), HexColor(hexCode: "C5B9C1"),
            HexColor(hexCode: "8D8784"), HexColor(hexCode: "596567"), HexColor(hexCode: "4F342F")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "E0D8DD"), HexColor(hexCode: "F9E193")
        ].sorted(by: >)
    ),
    
    //Inverno Profundo
    ColorPalette(
        id: 11,
        backgroundImage: "invernoProfundo",
        description: "Tons ricos e sofisticados, expressando a elegância e refinamento da estação para um estilo marcante e distinto, enfatizando a profundidade das cores invernais.",
        idealColors: [
            HexColor(hexCode: "9F114E"), HexColor(hexCode: "156558"), HexColor(hexCode: "113A71"),
            HexColor(hexCode: "3F3F91"), HexColor(hexCode: "8F5389"), HexColor(hexCode: "632D6B"),
            HexColor(hexCode: "F2EEAB"), HexColor(hexCode: "F7D79E"), HexColor(hexCode: "B8CF82"),
            HexColor(hexCode: "709352"), HexColor(hexCode: "F3A4AE"), HexColor(hexCode: "ED7995"),
            HexColor(hexCode: "EB5F5E"), HexColor(hexCode: "50B9A0"), HexColor(hexCode: "5ACFD1"),
            HexColor(hexCode: "47A6C9"), HexColor(hexCode: "8CC6EF"), HexColor(hexCode: "95AEE9"),
            HexColor(hexCode: "6570B8"), HexColor(hexCode: "D2ACD4"), HexColor(hexCode: "C86C8E"),
            HexColor(hexCode: "613045")
        ].sorted(by: >),
        neutralColors: [
            HexColor(hexCode: "E6DFDD"), HexColor(hexCode: "BFB4B3"), HexColor(hexCode: "516066"),
            HexColor(hexCode: "27323C"), HexColor(hexCode: "A15D48"), HexColor(hexCode: "704A45")
        ].sorted(by: >),
        accessoriesColors: [
            HexColor(hexCode: "E0D8DD"), HexColor(hexCode: "F9E193")
        ].sorted(by: >)
    )

]



func hexColorFromString(_ hexString: String) -> HexColor {
    return HexColor(hexCode: hexString)
}
