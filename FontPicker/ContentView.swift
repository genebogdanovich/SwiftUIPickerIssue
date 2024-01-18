//
//  ContentView.swift
//  FontPicker
//
//  Created by Gene Bogdanovich on 18.01.24.
//

import SwiftUI

// MARK: - CustomFont

enum CustomFont: String, CaseIterable, Identifiable, Codable {
    case baskerville = "Baskerville"
    case chalkboardSE = "ChalkboardSE-Regular"
    
    var displayTitle: String {
        switch self {
        case .baskerville:
            return "Baskerville"
        case .chalkboardSE:
            return "Chalkboard SE"
        }
    }
    
    var id: String {
        rawValue
    }
}

// MARK: - AppFont

enum AppFont: Hashable, Codable {
    case `default`
    case custom(font: CustomFont)
}

#warning("Try Data")
extension AppFont: RawRepresentable {
    init?(rawValue: String) {
        let data = rawValue.data(using: .utf8)!
        self = try! JSONDecoder().decode(AppFont.self, from: data)
    }
    
    var rawValue: String {
        let data = try! JSONEncoder().encode(self)
        return String(decoding: data, as: UTF8.self)
    }
    
    typealias RawValue = String
    
    
}

// MARK: - ContentView

struct ContentView: View {
    @AppStorage("selectedFont") private var selectedFont: AppFont = .custom(font: .baskerville)
    
    var body: some View {
        VStack {
            Picker(selection: $selectedFont) {
                Text("Default")
                    .tag(AppFont.default)
                
                ForEach(CustomFont.allCases) { customFont in
                    Text(customFont.displayTitle)
                        .tag(AppFont.custom(font: customFont))
                }
                
            } label: {
                Text("Select font")
            }
            
            if case let .custom(font) = selectedFont {
                Text("Hello, world!")
                    .font(.custom(font.rawValue, size: 17))
            } else {
                Text("Hello, world!")
            }
            
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
