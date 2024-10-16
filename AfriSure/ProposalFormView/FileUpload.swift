

import SwiftUI
import UIKit
import MobileCoreServices

var fileUploadlength = 0

struct UIKitDocumentPickerViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIDocumentPickerViewController
    
    let allowedFileTypes: [String]
    let filelength: Int
    let isMultiple: Bool

    let completion: ([URL]) -> Void
//    let showAlertCallback: () -> Void
    
    @Binding var alertItem: AlertItem?
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let allowedUTTypes = mimeTypesToUTTypes(mimeTypes: allowedFileTypes)
        let documentPicker = UIDocumentPickerViewController(documentTypes: allowedUTTypes, in: .import)
        documentPicker.delegate = context.coordinator
        documentPicker.allowsMultipleSelection = isMultiple // Allow multiple file selection
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: UIKitDocumentPickerViewController

        init(_ parent: UIKitDocumentPickerViewController) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            
            // If multiple files are selected and the number of selected files exceeds the maximum allowed
            if parent.isMultiple && urls.count > parent.filelength {
                // Take only the first `filelength` number of files
                let selectedURLs = Array(urls.prefix(parent.filelength))
                parent.completion(selectedURLs)
                
//                parent.showAlertCallback()
                
                // Display an error message indicating that only a limited number of files have been attached
                print("Maximum number of files exceeded. Attached \(parent.filelength) files.")
                
                parent.alertItem = AlertItem(title: Text("ERR021 \n Uh-oh! You can only upload up to \(fileUploadlength) files at once. Please choose fewer files"))
            } else {
                // If the number of selected files is within the allowed limit, pass them to the completion handler
                parent.completion(urls)
                
                for url in urls {
                    let fileName = url.lastPathComponent
                    print("Selected file name: \(fileName)")
                }
            }
        }


    }
}




func mimeTypesToUTTypes(mimeTypes: [String]) -> [String] {
    return mimeTypes.compactMap { mimeType in
        if let utType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() {
            return utType as String
        } else {
            return nil
        }
    }
}


func fileSizeInMB(for url: URL) -> Double {
      do {
          let fileAttributes = try FileManager.default.attributesOfItem(atPath: url.path)
          if let fileSize = fileAttributes[.size] as? Int64 {
              // Convert bytes to megabytes
              return Double(fileSize) / (1024 * 1024)
          }
      } catch {
          print("Error: \(error)")
      }
      return 0
  }


//self.alertItem = AlertItem(title: Text("ERR021 \n Uh-oh! You can only upload up to \(proposalFileslength) files at once. Please choose fewer files"))
