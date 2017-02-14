//
//  Line.swift
//  viet_chu
//
//  Created by Tri on 11/14/16.
//  Copyright © 2016 efode. All rights reserved.
//

import Foundation
import UIKit

class Line {
    
    var startPoint: CGPoint!
    var endPoint: CGPoint!
    var color: CGColor!
    
    init(_ start: CGPoint, _ end: CGPoint, _ color: CGColor) {
        startPoint = start
        endPoint = end
        self.color = color
    }
}
