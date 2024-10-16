

import SwiftUI

struct Country: Decodable {
    let name: String
    let dial_code: String
    let code: String
    let blocks: [Int]
    let currency_code: String
}
 
