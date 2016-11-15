//
//  DrawView.swift
//  viet_chu
//
//  Created by Tri on 11/14/16.
//  Copyright © 2016 efode. All rights reserved.
//

import UIKit
import AVFoundation

class DrawView: UIView {
    var character: String!
    var lines = [Line]()
    var lastPoint: CGPoint!
    var colorFlag = false
    var originalPath: CGPath!
    var drawPath = UIBezierPath()
    var pointArray = [CGPoint]()
    var pointArrays = [[CGPoint]]()
    var label = UILabel()
    var arrows = [UIBezierPath]()
    var isCompleted = false
    let synthesizer = AVSpeechSynthesizer()
    
    func addLabel() {
        label.text = "0,0"
        label.adjustsFontSizeToFitWidth = true
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.addSubview(label)
    }
    
    func setOriginal(_ path: CGPath){
        originalPath = path
    }
    
    var firstPoint: CGPoint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstPoint = touches.first?.location(in: self) // TODO
        lastPoint = touches.first?.location(in: self)
        if drawPath.contains(lastPoint) {
            print("exist")
        }
        drawPath.move(to: lastPoint)
        drawPath.addLine(to: lastPoint)
        let line = Line(lastPoint, lastPoint!)
        lines.append(line)
        label.text = lastPoint.debugDescription
        print(lastPoint)
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newPoint = touches.first?.location(in: self)
        label.text = newPoint!.debugDescription
        //        if !(newPoint?.equalTo(lastPoint))! {
        //            let line = Line(lastPoint, newPoint!)
        //            drawPath.addLine(to: newPoint!)
        //            lines.append(line)
        //            lastPoint = newPoint
        //            self.setNeedsDisplay()
        //        }
        let line = Line(lastPoint, newPoint!)
        drawPath.addLine(to: newPoint!)
        lines.append(line)
        lastPoint = newPoint
        
        if pointArrays.count > 0 {
            pointArray = pointArrays[0]
            if pointArray.count > 0 {
                let point = pointArray[0]
                if compareTwoPoint(point, newPoint!) {
                    print("Removed \(point)")
                    pointArray.remove(at: 0)
                    pointArrays[0] = pointArray
                    
                }
            }
            if pointArray.count == 0 {
                print("Remove array")
                pointArrays.remove(at: 0)
                if !arrows.isEmpty {
                    arrows.remove(at: 0)
                }
                
            }
        }
        
        if pointArrays.count == 0 {
            isCompleted = true
            print("Completed")
            // talk
            let utterance = AVSpeechUtterance(string: character)
            utterance.voice = AVSpeechSynthesisVoice(language: "vn")
            synthesizer.stopSpeaking(at: .immediate)
            synthesizer.speak(utterance)
        }
        
        self.setNeedsDisplay()
        
    }
    
    var conLabel = UILabel()
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isCompleted {
            conLabel.frame = CGRect(x: 0, y: 10, width: self.frame.width, height: 20)
            conLabel.textAlignment = .center
            conLabel.textColor = UIColor.blue
            conLabel.text = "Đúng rồi"
            self.addSubview(conLabel)
        }
    }
    
    func compareTwoPoint(_ point1: CGPoint, _ point2: CGPoint) -> Bool {
        if abs(point1.x - point2.x) < 10 && abs(point1.y - point2.y) < 10 {
            print("Passed")
            return true
        }
        return false
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.beginPath()
        context!.setLineCap(.round)
        //        context!.setLineJoin(.bevel)
        
        if originalPath != nil {
            context!.setLineWidth(1)
            context!.setLineDash(phase: 1, lengths: [7,7])
            context?.addPath(originalPath)
            context!.strokePath()
        }
        context!.setLineWidth(2)
        context!.setLineDash(phase: 2, lengths: [])
        context!.setStrokeColor(UIColor.yellow.cgColor)
        let arrow = arrows.first
        if arrow != nil {
            //            print(arrow)
            UIColor.yellow.setFill()
            arrow?.fill()
            context!.addPath((arrow?.cgPath)!)
            //            let xxPath = UIBezierPath.arrow(from: CGPoint(x: 0, y: 0), to: CGPoint(x: 100, y: 100), tailWidth: 1, headWidth: 10, headLength: 10)
            //            context!.addPath(xxPath.cgPath)
            context!.strokePath()
        }

        
        
        context!.setLineWidth(5)
        context!.setStrokeColor(UIColor.blue.cgColor)
        var points = pointArrays.first
        if points != nil {
            context!.setStrokeColor(UIColor.yellow.cgColor)
            let fPoint = points?.remove(at: 0)
            context!.move(to: fPoint!)
            context!.addLine(to: fPoint!)
            context!.strokePath()
            context!.setStrokeColor(UIColor.blue.cgColor)
            for point in points! {
                context!.move(to: point)
                context!.addLine(to: point)
                context!.strokePath()
            }
        }
        
        context!.setStrokeColor(UIColor.red.cgColor)
        
        context!.setLineWidth(20)
        for line in lines {
            context!.move(to: line.startPoint)
            context!.addLine(to: line.endPoint)
        }
        context!.strokePath()
    }
    
}
