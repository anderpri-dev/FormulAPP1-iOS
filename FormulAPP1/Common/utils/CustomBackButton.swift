//
//  CustomBackButton.swift
//  FormulAPP1
//
//  Created by ANDER on 20/5/25.
//

import SwiftUI

struct CustomBackButton: ViewModifier {
    
    @Environment(\.dismiss) private var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text(LocalizedStringKey("app.back"))
                        }
                    }
                }
            }
    }
}

extension View {
    func withLocalizedBackButton() -> some View {
        self.modifier(CustomBackButton())
    }
}
