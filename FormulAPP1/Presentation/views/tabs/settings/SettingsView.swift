import SwiftUI
import WidgetKit

struct SettingsView: View {
    
    @AppStorage("selectedLanguage", store: UserPreferencesManager.sharedDefaults) private var selectedLanguage: String = "system"
    @AppStorage("selectedColorScheme", store: UserPreferencesManager.sharedDefaults) private var selectedColorScheme: String = "system"
    
    @State private var showAppInfo: Bool = false
    @State private var showDeveloperInfo: Bool = false

    var body: some View {
        VStack (alignment: .leading) {
            Text("settings.title")
                .font(.largeTitle)
                .bold()
                .padding(.all, 24)
            Form {
                Section(header: Text("settings.appearance")) {

                    Picker("settings.theme", selection: $selectedColorScheme) {
                        Text("settings.systemdefault").tag("system")
                        Text("settings.light").tag("light")
                        Text("settings.dark").tag("dark")
                    }
                    
                    Picker("settings.language", selection: $selectedLanguage) {
                        Text("settings.systemdefault").tag("system")
                        Text("settings.english").tag("en")
                        Text("settings.spanish").tag("es")
                        Text("settings.basque").tag("eu")
                    }
                    
                }
                
                Section(header: Text("settings_about")) {
                    Button("settings.app_info") {
                        showAppInfo.toggle()
                    }
                    .sheet(isPresented: $showAppInfo) {
                        AppInfoView()
                    }
                    
                    Button("settings.dev_info") {
                        showDeveloperInfo.toggle()
                    }
                    .sheet(isPresented: $showDeveloperInfo) {
                        DeveloperInfoView()
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .onChange(of: selectedLanguage) {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

// Divisor personalizado, reciclado de proyectos anteriores y adaptado a SwiftUI
struct DividerInfoView: View {
    
    let isSmall: Bool
    
    var body: some View {
        if isSmall {
            Divider()
                .frame(width: 50)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 10)
        } else {
            HStack(spacing: 25) {
                Rectangle()
                    .fill(Color(.separator))
                    .frame(width: 50, height: 2)
                    .cornerRadius(1)
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 28/255, green: 176/255, blue: 168/255))
                        .frame(width: 9, height: 9)
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .frame(width: 10, height: 9)
                        .foregroundColor(Color(red: 252/255, green: 182/255, blue: 67/255))
                        .offset(x: -18)
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color(red: 239/255, green: 64/255, blue: 86/255))
                        .frame(width: 9, height: 9)
                        .offset(x: 18)
                }
                .frame(width: 9, height: 9)
                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(width: 50, height: 2)
                    .cornerRadius(1)
            }
        }
    }
}

#Preview {
    SettingsView()
}
