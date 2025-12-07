//
//  SessionDetailsViewController.swift
//  throw
//
//  Created by Nitya Baddam on 11/17/25.
//

import UIKit
import Foundation

class SessionDetailsViewController: UIViewController {
    
    var session: Session!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.session = Session(title: "Default", date: Date.now ,types: [.firing])
        view.backgroundColor = .systemMint
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
