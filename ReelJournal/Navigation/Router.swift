//
//  Router.swift
//  ReelJournal
//
//  Created by Dom S on 4/4/26.
//

import SwiftUI

@Observable
class Router {
    var path: [Screen] = []
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
