

import SwiftUI
import CoreData
import Firebase
import UIKit
import Foundation




struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest (
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @StateObject var networkMonitor = NetworkMonitor()
    @State private var userUID: String?
    @State private var handle: AuthStateDidChangeListenerHandle?

    
    var body: some View {
        VStack {
//            if networkMonitor.isConnected {
                if Extensions.token == "" {
                    LandingPage()
                } else {
                    
                    DashboardView(navigateOtpPage: .constant(false))
//                    GeneratePolicy(isOverlayVisible: .constant(false))
//                    ProposalForms(navigateProposalForm: .constant(false))
//                    CustomForms(navigateCustomPage: .constant(false))
//                    QuotationPage(navigateQuotationPage: .constant(false))
//                    SelfAssessment(navigateSelfAssessment: .constant(false))
                }

//            } else {
//                ErrorView()
//            }
        }.onAppear {
            handle = Auth.auth().addStateDidChangeListener { auth, user in
                if Auth.auth().currentUser != nil {
                  // User is signed in.
                    let user = Auth.auth().currentUser
                    if let user = user {
                      // The user's ID, unique to the Firebase project.
                      // Do NOT use this value to authenticate with your backend server,
                      // if you have one. Use getTokenWithCompletion:completion: instead.
                      let uid = user.uid
                      let email = user.email
                      let photoURL = user.photoURL
                      var multiFactorString = "MultiFactor: "
                      for info in user.multiFactor.enrolledFactors {
                        multiFactorString += info.displayName ?? "[DispayName]"
                        multiFactorString += " "
                      }
                      // ...
                    }
                } else {
                  // No user is signed in.
                  // ...
                }
            }
            
            
            Auth.auth().signInAnonymously { authResult, error in
                guard let user = authResult?.user else { return }
//                let isAnonymous = user.isAnonymous  // true
                let uid = user.uid
                Extensions.userUid = uid
            }
            if let user = Auth.auth().currentUser {
                let userID = user.uid
                print("User ID: \(userID)")
            } else {
                // User is not signed in
                print("User is not signed in")
            }

        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
