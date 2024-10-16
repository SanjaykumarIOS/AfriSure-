//
//  ApiService.swift
//  Patabima
//
//  Created by SwiftAntMac2 on 06/04/23.
//

import Foundation
import Alamofire
import SwiftUI
import CoreLocation
import UIKit



var deviceUDID = getDeviceID()

var currentDateTime = getCurrentDateTime()

var currentTimeZone = getCurrentTimeZone()

var strIPAddress = getIPAddress()

var systemOsVersion = systemVersion()

var devicemodel = deviceModels()

var deviceLatitude: String = ""

var devicelongitude: String = ""

var deviceJailbroken = jailbroken()


func getCurrentTimeZone() -> String {
    let timezone =  TimeZone.current.identifier
//    timeZone = getCurrentTimeZone()
    print(timezone)
    return timezone
}

func getCurrentDateTime()->String {
    let date = Date()
    
    let df = DateFormatter()
    
    df.dateFormat = "dd-MMM-yyyy HH:mm"
    
    let dateString = df.string(from: date)
//    currentDateTime = getCurrentDateTime()
    print(dateString)
    return dateString
}

func getDeviceID() -> String {
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? "Unknown"
    
//    deviceUDID = getDeviceID()
    print(udid)
    return udid
}


func getIPAddress() -> String {
    var address: String?
    var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next }
            guard let interface = ptr?.pointee else { return "" }
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                let name: String = String(cString: (interface.ifa_name))
                if name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
    }
//    strIPAddress = getIPAddress()
    return address ?? ""
}

func systemVersion() -> String {
    
    let systemVersion = UIDevice.current.systemVersion
//    systemOsVersion = systemVersion
    print(systemVersion)
    return systemVersion
}

func deviceModels() -> String {
    
    let deviceModel = UIDevice.current.model
//    devicemodel = deviceModel
    print(deviceModel)
    return deviceModel
}


class LocationManagerDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
        
        // Update global variables here
        deviceLatitude = String(latitude)
        devicelongitude = String(longitude)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location request failed with error: \(error.localizedDescription)")
    }
}


func jailbroken() -> Bool {
    if TARGET_OS_SIMULATOR != 0 {
        return false
    }

    let fileManager = FileManager.default

    if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
        fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
        fileManager.fileExists(atPath: "/bin/bash") ||
        fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
        fileManager.fileExists(atPath: "/etc/apt") ||
        fileManager.fileExists(atPath: "/private/var/lib/apt/") ||
        fileManager.fileExists(atPath: "/private/var/lib/cydia/") ||
        fileManager.fileExists(atPath: "/private/var/stash") ||
        fileManager.fileExists(atPath: "/usr/bin/ssh") ||
        fileManager.fileExists(atPath: "/usr/libexec/sftp-server") {
        return true
    }

    if let path = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision"),
        let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
        let string = String(data: data, encoding: .ascii),
        string.contains("<key>get-task-allow</key><true/>") {
        return true
    }
    return false
}





// Protocol for API Endpoint
protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var bodyData: [String: Any] { get }
    // Add other properties like headers, query parameters, etc.
}

// Create a struct conforming to the protocol
struct MyEndpoint: APIEndpoint {
    var baseURL: URL
    var path: String
    var method: String
    var bodyData: [String: Any]

    // Implement other properties and methods if needed
}

// Generic API Service Method
class APIService {
    static func request<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let mobileParameters: [String: Any] = [
            "deviceID": deviceUDID,
            "deviceID2": "",
            "deviceTimeZone": currentTimeZone,
            "deviceDateTime": currentDateTime,
            "deviceIpAddress": strIPAddress,
            "deviceUserID": Extensions.userUid,
            "deviceLatitude": deviceLatitude,
            "deviceLongitude": devicelongitude,
            "deviceType": "iOS",
            "deviceVersion": systemOsVersion,
            "deviceAppVersion": "1.0.0",
            "deviceModel": devicemodel,
            "deviceIsJailBroken": deviceJailbroken
        ]
            print("mobileParameters = \(mobileParameters)")

        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = endpoint.method
        
        var postData : Data
     
        postData = try! JSONSerialization.data(withJSONObject: mobileParameters, options: JSONSerialization.WritingOptions(rawValue: 0))
     
        let theJSONData = (NSString(data: postData, encoding: String.Encoding.utf8.rawValue)! as String).replacingOccurrences(of: "%20", with: " ")

        let authToken:String! = "Bearer " + Extensions.token
        print(authToken as Any)
        
        if endpoint.path.contains("Login"){
            request.addValue(Extensions.organisationAppID, forHTTPHeaderField: "orgAppID")
            
        }
                
        request.addValue("\(theJSONData)", forHTTPHeaderField: "clientInfo")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        request.addValue("D450B9D0-C614-4E8E-B058-DD0AE7D8D7FF", forHTTPHeaderField: "fingerprint")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: endpoint.bodyData,options: .fragmentsAllowed) else {
        return
        }
        
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError()))
                return
            }
            
            do {
                
                var resultDictionary:NSDictionary! = NSDictionary()
                resultDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                print("Responces = \(String(describing: resultDictionary))")
                
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}






