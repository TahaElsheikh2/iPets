//
//  ViewControllerInitializable.swift
//  iPets
//
//  Created by Taha on 10/08/2023.
//

import UIKit

protocol ViewControllerInitializable {
    static func instantiate(coordinator: Coordinator) -> UIViewController
}
