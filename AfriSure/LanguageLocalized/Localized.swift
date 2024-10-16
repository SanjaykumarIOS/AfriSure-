

import Foundation
extension String{
    func localized() -> String {
        let path = Bundle.main.path(forResource:Extensions.selectedLanguage, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: "", bundle: bundle!, value: "", comment: "")
    }
}
