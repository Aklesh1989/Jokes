//
//  File.swift
//  Jokes
//
//  Created by Aklesh on 30/10/22.
//

import Foundation
import UIKit

extension NSObject {
    class var nameOfClass: String {
        let componentsList = NSStringFromClass(self).split(separator: ".").map(String.init)
        return componentsList.last!
    }
}

