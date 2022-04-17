//
//  Extension+UIApplication.swift
//  TVSeries
//
//  Created by Danilo Henrique on 17/04/22.
//

import Foundation
import UIKit

extension UIApplication {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
