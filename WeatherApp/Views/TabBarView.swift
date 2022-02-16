
import SwiftUI

struct TabBarView: View {
    
    enum Screen: Int {
        case forecast = 0
        case profile = 1
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            TabView {
               MainView().tabItem{
                    Image(icon: .placeholder)
                    Text("Forecast")
                }.tag(Screen.forecast)
                
                ProfileView().tabItem {
                    Image(icon: .profile)
                    Text("Profile")
                }.tag(Screen.profile)
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
