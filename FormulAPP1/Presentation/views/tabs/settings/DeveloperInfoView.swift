//
//  DeveloperInfoView.swift
//  FormulAPP1
//
//  Created by ANDER on 14/5/25.
//

import SwiftUI

struct DeveloperInfoView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Foto mía
                Image("ander")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .padding(.top, 12)
                
                // Nombre y descripción
                VStack {
                    Text(verbatim: "ANDER PRIETO")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("devinfo.position")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                DividerInfoView(isSmall: false)

                // Formación académica
                VStack(alignment: .leading, spacing: 10) {
                    Text("devinfo.academic")
                        .font(.headline)

                    HStack(alignment: .top, spacing: 20) {
                        VStack {
                            Image(colorScheme == .dark ? "ehu_w" : "ehu_b")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            Text(verbatim: "Universidad del País Vasco / Euskal Herriko Unibertsitatea (UPV/EHU)")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }.frame(maxWidth: .infinity)

                        VStack {
                            Image("upsa")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            Text(verbatim: "Universidad Pontificia de Salamanca (UPSA)")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }.frame(maxWidth: .infinity)
                    }
                }

                DividerInfoView(isSmall: false)

                // Experiencia laboral
                VStack(alignment: .leading, spacing: 10) {
                    Text("devinfo.work")
                        .font(.headline)

                    HStack(alignment: .top, spacing: 20) {
                        VStack {
                            Image(colorScheme == .dark ? "teknei_w" : "teknei_b")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            Text(verbatim: "Teknei")
                                .font(.caption)
                        }.frame(maxWidth: .infinity)

                        VStack {
                            Image("gv")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                            Text("devinfo.gv")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }.frame(maxWidth: .infinity)
                    }

                    DividerInfoView(isSmall: true)

                    VStack(alignment: .center) {
                        Image("logirail")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Text(verbatim: "LogiRAIL")
                            .font(.caption)
                    }.frame(maxWidth: .infinity)

                    DividerInfoView(isSmall: true)

                    VStack {
                        Image("ntt")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Text(verbatim: "NTT Data")
                            .font(.caption)
                    }.frame(maxWidth: .infinity)
                }

                DividerInfoView(isSmall: false)

                // Botones con enlaces
                HStack(spacing: 20) {
                    Button(action: {
                        openLink(link: "https://www.linkedin.com/in/ander-prieto/")
                    }) {
                        VStack {
                            Image(systemName: "link")
                                .font(.title)
                            Text(verbatim: "LinkedIn")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    Button(action: {
                        openLink(link: "https://github.com/anderra57/")
                    }) {
                        VStack {
                            Image(systemName: "chevron.left.slash.chevron.right")
                                .font(.title)
                            Text(verbatim: "GitHub")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    Button(action: {
                        openLink(link: "mailto:anderpri.dev@gmail.com")
                    }) {
                        VStack {
                            Image(systemName: "envelope")
                                .font(.title)
                            Text("devinfo.contact")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.top)
            }
            .padding()
        }
    }

    func openLink(link: String) {
        if let url = URL(string: "mailto:anderpri.dev@gmail.com") {
            UIApplication.shared.open(url)
        }
    }
}
