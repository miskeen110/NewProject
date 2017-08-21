//
//  CellInterface.swift
//  TeamWorkProject
//
//  Created by Miskeen Jatoi on 8/20/17.
//  Copyright © 2017 myorg. All rights reserved.
//
import UIKit

protocol CellInterface {
    
    static var id: String { get }
    static var cellNib: UINib { get }
    
}

extension CellInterface {
    
    static var id: String {
        return String(describing: Self.self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
    
}
