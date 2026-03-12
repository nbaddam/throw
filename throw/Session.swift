//
//  Session.swift
//  throw
//
//  Created by Nitya Baddam on 11/16/25.
//

import Foundation
import Algorithms
import UIKit

class Session {
    var title: String
    var date: Date
    var types: [SessionType]
    var body: String?
    var images: [UIImage]
    
    init(title: String,
         date: Date,
         types: [SessionType],
         body: String? = nil,
         images: [UIImage] = []) {
        
        self.title = title
        self.date = date
        self.body = body
        self.images = images
    
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
        case .throwing: return .kaleBackground
        case .trimming: return .eggplantBackground
        case .glazing: return .butterflyPeaFlowerBackground
        case .firing: return .tomatoBackground
        case .handbuilding: return .taroBackground
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .throwing: return .kale
        case .trimming: return .eggplant
        case .glazing: return .butterflyPeaFlower
        case .firing: return .tomato
        case .handbuilding: return .taro
        }
    }
}
