//
//  SessionsDataSource.swift
//  throw
//
//  Created by Nitya Baddam on 12/27/25.
//

import Foundation
import UIKit

class SessionsDataSource {
    
    lazy var session1: Session = {
        let title = "First class"
        let body = "Today I had my first class and we learned how to center clay!"
        let images = [UIImage(named: "Nitya_Throwing_First")!, UIImage(named: "First_Vase_Thrown")!]
        let types: [SessionType] = [
            .throwing,
            .trimming,
            .glazing,
            .firing,
            .handbuilding
        ]
                        
        return Session(title: title, date: Date.getRandomDate(), types: types, body: body, images: images)
    }()
    
    lazy var session2: Session = {
        let title = "Second throwing attempt"
        let images = [UIImage(named: "Nitya_Throwing_Cup")!, UIImage(named: "First_Cup_Thrown")!]
        let types: [SessionType] = [
            .throwing
        ]
                        
        return Session(title: title, date: Date.getRandomDate(), types: types, body: nil, images: images)
    }()
    
    lazy var session3: Session = {
        let title = "The time I realized the importance of centering"
        let images = [UIImage(named: "Nitya_Throwing_Carafe")!]
        let types: [SessionType] = [
            .trimming
        ]
                        
        return Session(title: title, date: Date.getRandomDate(), types: types, body: nil, images: images)
    }()
    
    lazy var session4: Session = {
        let title = "Trimming extravanganza!"
        let images = [UIImage(named: "Flower_Cup_Etched")!, UIImage(named: "Flower_Cup_Crack")!, UIImage(named: "Tumbler_Thrown")!]
        let types: [SessionType] = [
            .trimming
        ]
                        
        return Session(title: title, date: Date.getRandomDate(), types: types, body: nil, images: images)
    }()
    
    lazy var allSessions: [Session] = {
        return [session1, session2, session3, session4]
    }()
}
