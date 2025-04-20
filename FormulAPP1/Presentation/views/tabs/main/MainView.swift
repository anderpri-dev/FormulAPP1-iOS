import SwiftUI
import Foundation

struct MainView: View {
    
    @EnvironmentObject var racesVM: RacesViewModel
    @EnvironmentObject var driversVM: DriversViewModel
    @EnvironmentObject var constructorsVM: ConstructorsViewModel
    
    @State private var timeRemaining: String = "--:--:--"
    @State private var timer: Timer?
    @State private var selectedConstructor: ConstructorStandingDomainModel? = nil
    @State private var selectedDriver: DriverStandingDomainModel? = nil
    
    let userPreferencesManager = UserPreferencesManager.shared
    
    var body: some View {
        ScrollView {
            
            HStack {
                Spacer()
                /*
                Text("main.app_name")
                    .textCase(.uppercase)
                    .font(.custom("Futura-MediumItalic", size: 30))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                 */
                Image("text_w")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(.vertical, 16)
                Spacer()
            }.frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Color(hex: "#BB1313")
                    /*
                    LinearGradient(stops: [
                        .init(color: Color(hex: "#BB1313"), location: 0.05),
                        .init(color: Color(hex: "#BB1313"), location: 0.20),
                        .init(color: Color(hex: "#BB1313"), location: 0.80),
                        .init(color: Color(hex: "#BB1313"), location: 0.95)
                    ], startPoint: .top, endPoint: .bottom)
                     */
                )
            
            VStack(spacing: 24) {
                
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("main.next_race")
                        .textCase(.uppercase)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack {
                        VStack(alignment: .leading) {
                            Text(racesVM.nextRace?.raceName ?? "main.no_next_race")
                                .font(.title2)
                                .bold()
                            Text(timeRemaining)
                                .font(.title)
                                .monospacedDigit()
                                .onAppear(perform: startTimer)
                                .monospaced()
                        }
                        Spacer()
                        if let circuitMapName = racesVM.nextRace?.circuit.circuitId {
                            Image(circuitMapName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 60)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                                .padding(.trailing, 8)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.1))
                                .frame(width: 100, height: 60)
                                .cornerRadius(8)
                                .padding(.trailing, 8)
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("main.fav_drv")
                            .textCase(.uppercase)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        let favouriteId = UserPreferencesManager.shared.getFavouriteDriver()
                        let driver = favouriteId.flatMap { driversVM.getDriverStandingById(driverId: $0) }
                        
                        if(driver != nil) {
                            DriverStandingCard(standing: driver!)
                        } else {
                            EmptyCard(title: LocalizedStringKey("main.no_fav_drv"))
                                .frame(height: 150)
                                .cornerRadius(8)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("main.fav_ctr")
                            .textCase(.uppercase)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        let favouriteId = UserPreferencesManager.shared.getFavouriteConstructor()
                        let constructor = favouriteId.flatMap { constructorsVM.getConstructorStandingById(constructorId: $0) }
                        
                        if let constructor = constructor {
                            Button {
                                selectedConstructor = constructor
                            } label: {
                                ConstructorStandingCard(standing: constructor, fromMainView: true)
                            }
                            .buttonStyle(.plain)
                        } else {
                            EmptyCard(title: LocalizedStringKey("main.no_fav_ctr"))
                                .frame(height: 150)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("main.data_upd_header")
                            .textCase(.uppercase)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        VStack(alignment: .leading) {
                            Text("main.data_upd")
                                .font(.headline)
                            Text(formattedDate())
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                
                Spacer()

            }
            .padding()
            .onAppear {
                racesVM.getNextRace()
            }
            .onChange(of: racesVM.nextRace) {
                updateTime()
            }
            
            
            Spacer()
        }
        .refreshable {
            ViewModelProvider.shared.fetchAllData()
        }
        
    }
    
    private func formattedDate() -> String {
        let userPreferencesManager = UserPreferencesManager.shared
        let lastUpdateDate = userPreferencesManager.getLastUpdateDate()
        
        let languageCode = UserPreferencesManager.shared.getLanguage()
        let locale: Locale = getLocaleFromLanguageCode(languageCode)
    
        guard let date = lastUpdateDate else { return String(localized: "main.data_upd_never") }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        formatter.locale = locale
        return formatter.string(from: date)
    }
    
    func startTimer() {
        updateTime()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateTime()
        }
    }
    
    func updateTime() {
        guard let nextRace = racesVM.nextRace,
              let raceDate = formatDateFromSessionDateTime(date: nextRace.raceSession.date, time: nextRace.raceSession.time) else {
            timeRemaining = "--:--:--"
            return
        }
        let now = Date()
        let diff = raceDate.timeIntervalSince(now)
        if diff > 0 {
            let days = Int(diff) / 86400
            let hours = (Int(diff) % 86400) / 3600
            let minutes = (Int(diff) % 3600) / 60
            let seconds = Int(diff) % 60
            if days > 0 {
                timeRemaining = String(format: "%d:%02d:%02d:%02d", days, hours, minutes, seconds)
            } else {
                timeRemaining = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        } else {
            timeRemaining = "00:00:00"
            racesVM.getNextRace()
        }
    }
}

struct EmptyCard: View {
    
    let title: LocalizedStringKey
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
                .foregroundColor(.gray)
                
            Text(title)
                .textCase(.uppercase)
                .foregroundColor(.gray)
                .font(.headline)
        }
    }
}

#Preview {
    MainView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(ViewModelProvider.shared.racesVM)
        .environmentObject(ViewModelProvider.shared.constructorsVM)
        .environmentObject(ViewModelProvider.shared.driversVM)
}
