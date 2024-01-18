//
//  ContentView.swift
//  FontPicker
//
//  Created by Gene Bogdanovich on 18.01.24.
//

import SwiftUI

// MARK: - CustomFont

enum CustomFont: String, CaseIterable, Identifiable {
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

enum AppFont: Hashable {
    case `default`
    case custom(font: CustomFont)
}

// MARK: - ContentView

struct ContentView: View {
    @State private var selectedFont: AppFont = .custom(font: .baskerville)
    
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
