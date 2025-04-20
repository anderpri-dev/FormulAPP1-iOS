//
//  AppInfoView.swift
//  FormulAPP1
//
//  Created by ANDER on 14/5/25.
//
import SwiftUI

struct AppInfoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Logo principal
                Image("logo_w_text")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .mask(
                        RoundedRectangle(cornerRadius: 30)
                    )
                
                DividerInfoView(isSmall: false)
                
                // Desarrollada en:
                VStack(spacing: 12) {
                    Text("appinfo.languages")
                        .font(.headline)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Image("swift")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            Text(verbatim: "Swift")
                                .font(.subheadline)
                        }.frame(maxWidth: .infinity)
                        
                        Divider()
                            .frame(height: 40)
                        
                        VStack {
                            Image("swiftui")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        Text(verbatim: "SwiftUI")
                                .font(.subheadline)
                        }.frame(maxWidth: .infinity)
                    }
                }
                
                DividerInfoView(isSmall: false)
                
                // Información:
                VStack(spacing: 12) {
                    Text("appinfo.data")
                        .font(.headline)
                    
                    VStack {
                        //Image("jolpica")
                        //    .resizable()
                        //    .frame(width: 50, height: 50)
                        Text(verbatim: "Jolpica F1 API")
                            .font(.subheadline)
                    }
                }
                
                DividerInfoView(isSmall: false)
                
                // Imágenes:
                VStack(spacing: 12) {
                    Text("appinfo.images")
                        .font(.headline)
                    
                    VStack {
                        Image("f1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                        Text(verbatim: "© 2003-2025 Formula One World Championship Limited")
                            .font(.subheadline)
                    }
                }
                
                DividerInfoView(isSmall: false)
            }
            .padding()
        }
    }
}



#Preview {
    AppInfoView()
}
