//
//  File.swift
//  Jokes
//
//  Created by Aklesh on 30/10/22.
//

import Foundation
import UIKit


class AppCoordinator: NSObject {
    
    override init() {
        super.init()

    }
    
    var rootVC: UIViewController {
        let viewModel = JokesViewModel()
        let JokesVC = JokesViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: JokesVC)
    }
}
