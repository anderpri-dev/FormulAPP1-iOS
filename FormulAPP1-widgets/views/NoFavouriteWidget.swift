//
//  NoFavouriteWidget.swift
//  FormulAPP1
//
//  Created by ANDER on 20/5/25.
//

import SwiftUI

struct NoFavouriteWidget: View {
    
    let isDriver : Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
                .foregroundColor(.gray)
            Text(LocalizedStringManager.shared.localizedString(isDriver ? "main.no_fav_drv" : "main.no_fav_ctr"))
                .textCase(.uppercase)
                .foregroundColor(.gray)
                .font(.headline)
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}
