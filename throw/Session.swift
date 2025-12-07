//
//  Session.swift
//  throw
//
//  Created by Nitya Baddam on 11/16/25.
//

import Foundation
import Algorithms
import UIKit

struct Session {
    var title: String
    var date: Date
    var types: [SessionType]
    var body: String?
    var image: UIImage?
    
    init(title: String,
         date: Date,
         types: [SessionType],
         body: String? = nil,
         image: UIImage? = nil) {
        
        self.title = title
        self.date = date
        self.body = body
        self.image = image
    
        // additional processing of properties
        self.types = Array(types.uniqued())
        
        // TODO: potential to add whitespace removal here for title and body
    }
}

enum SessionType: String, Codable {
    case throwing
    case trimming
    case glazing
    case firing
    case handbuilding
    
    var displayName: String {
        switch self {
        case .throwing: return "Throwing"
        case .trimming: return "Trimming"
        case .glazing: return "Glazing"
        case .firing: return "Firing"
        case .handbuilding: return "Hand Building"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .throwing: return UIColor.systemBrown.withAlphaComponent(0.15)
        case .trimming: return UIColor.systemOrange.withAlphaComponent(0.15)
        case .glazing: return UIColor.systemBlue.withAlphaComponent(0.15)
        case .firing: return UIColor.systemRed.withAlphaComponent(0.15)
        case .handbuilding: return UIColor.systemGreen.withAlphaComponent(0.15)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .throwing: return .systemBrown
        case .trimming: return .systemOrange
        case .glazing: return .systemBlue
        case .firing: return .systemRed
        case .handbuilding: return .systemGreen
        }
    }
}
