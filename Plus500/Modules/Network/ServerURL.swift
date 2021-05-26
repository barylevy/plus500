//
//  AppURL.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import Foundation

enum ServerRoute: String {
    case feeds = "/api/feeds"
    case stock = "/api/stock"
}

enum ServerURL{
    
    static func urlRunning(route:ServerRoute) -> URL {
        return ServerURL.remote(route: route).url
        
    }
    case local( route:ServerRoute)
    case remote( route:ServerRoute)
    
    var url: URL {
        switch self {
        case .local( let route): return URL(string: "\(self.hostName):\(self.port)\(route.rawValue)")!
        case .remote(let route): return URL(string: "\(self.hostName)\(route.rawValue)")!
        }
    }
    
    var hostName:String{
        switch self {
        case .local:    return "http://localhost"
        case .remote:   return "http://35.234.67.223"
        }
    }
    
    var port:String{
        switch self {
        case .local:    return "3000"
        case .remote:   return ""
        }
    }
}
