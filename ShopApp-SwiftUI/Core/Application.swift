//
//  Application.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 15.04.2025.
//

import Foundation
import UIKit

final class Application_Utility {
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
