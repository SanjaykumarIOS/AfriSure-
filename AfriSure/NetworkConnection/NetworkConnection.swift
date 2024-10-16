import SwiftUI
import Network
import Foundation

class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self?.isConnected = true
                    print("Internet is connected")

                }
            } else {
                DispatchQueue.main.async {
                    self?.isConnected = false
                    print("Internet is not connected")

                }
            }
        }
        monitor.start(queue: queue)
    }
}
 
struct NetworkConnection: View {
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        VStack {
            if networkMonitor.isConnected {
            
            } else {
                ErrorView()
            }
        }
    }
}
