//
//  ViewController.swift
//  viet_chu
//
//  Created by Tri on 11/9/16.
//  Copyright © 2016 efode. All rights reserved.
//

import UIKit

import CoreText

class ViewController: UIViewController {
    
    let square = UIView()
    let squarePath = UIBezierPath()
    
    var timer = Timer()
    
    var drawPath = UIBezierPath()
    var path = UIBezierPath()
    let shapeLayer = CAShapeLayer()
    let drawShape = CAShapeLayer()
    var view1 = UIImageView()
    var originalPath : UIBezierPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        path = Alphabet.getM()
//        
//        // Create a CAShapeLayer
//        
        
        
        path = Alphabet.getTest()
        originalPath = path
        let drawView = DrawView()
        drawView.pointArrays = Alphabet.getBPoints()
        drawView.backgroundColor = UIColor.green
        drawView.frame = CGRect(x: 0, y: 200, width: self.view.frame.width, height: self.view.frame.height - 200)
        self.view.addSubview(drawView)
        drawView.setOriginal(originalPath.cgPath)
    }
    var tmpPath = UIBezierPath()
    var tmpShape = CAShapeLayer()
    var pathArray = [UIBezierPath]()
    func drawW(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            let point = sender.location(in: self.view1)
            tmpPath = UIBezierPath()
            //  tmpShape = CAShapeLayer() //            tmpShape.backgroundColor = UIColor.green.cgColor // //            // apply other properties related to the path //            tmpShape.strokeColor = UIColor.black.cgColor //            tmpShape.fillColor = UIColor.white.cgColor //            tmpShape.lineDashPattern = [7, 7] ////            tmpShape.opacity = 1 // //            tmpShape.lineWidth = 2.0 //            tmpShape.lineCap = "round" //            view1.layer.addSublayer(tmpShape) drawPath.move(to: point) path.move(to: point)
        }
        
        if sender.state == .changed {
            let point = sender.location(in: self.view1)
            drawPath.addLine(to: point)
            path.addLine(to: point)
            shapeLayer.path = path.cgPath
            //            tmpShape.path = tmpPath.cgPath
        }
        
        if sender.state == .ended {
            //            pathArray.append(tmpPath) //            drawPath.stroke() //            print(tmpPath.cgPath)
        }
        
    }
    var timerCount:Float = 0.0
    func updateTime() {
        timerCount = timerCount + 0.1
        print(timerCount)
        if timerCount > 5 {
            timer.invalidate()
            print(squarePath)
        } else {
            squarePath.addLine(to: square.frame.origin)
        }
    }
}

class DrawView: UIView {
    var lines = [Line]()
    var lastPoint: CGPoint!
    var colorFlag = false
    var originalPath: CGPath!
    var drawPath = UIBezierPath()
    var pointArray = [CGPoint]()
    var pointArrays = [[CGPoint]]()
    
    func setOriginal(_ path: CGPath){
        originalPath = path
    }
    
    func checkComplete() {
//        let drawP = drawPath.cgPath
    }
    
    var firstPoint: CGPoint!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstPoint = touches.first?.location(in: self) // TODO
        lastPoint = touches.first?.location(in: self)
        if drawPath.contains(lastPoint) { print("exist")
        }
        drawPath.move(to: lastPoint)
        drawPath.addLine(to: lastPoint)
        let line = Line(lastPoint, lastPoint!)
        lines.append(line)
        print(lastPoint)
        //        print(originalPath.getPathElementsPointsAndTypes())
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newPoint = touches.first?.location(in: self)
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
            }
        }
        
        if pointArrays.count == 0 {
            print("Completed")
        }
        
        self.setNeedsDisplay()
        
    }
    
    func compareTwoPoint(_ point1: CGPoint, _ point2: CGPoint) -> Bool {
        if abs(point1.x - point2.x) < 10 && abs(point1.y - point2.y) < 10 {
            print("Passed")
            return true
        }
        return false
    }
    
    override func draw(_ rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        context!.beginPath()
        context!.setLineCap(.round)
        //        context!.setLineJoin(.bevel)
        
        if originalPath != nil {
            context!.setLineWidth(1)
            context!.setLineDash(phase: 1, lengths: [7,7])
            context?.addPath(originalPath)
            context!.strokePath()
        }
        context!.setLineWidth(5)
        context!.setLineDash(phase: 1, lengths: [])
        context!.setStrokeColor(UIColor.blue.cgColor)
        let points = pointArrays.first
        if points != nil {
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
            //            if colorFlag { //                context!.setStrokeColor(UIColor.red.cgColor) //                colorFlag = !colorFlag //            } else { //                context!.setStrokeColor(UIColor.yellow.cgColor) //                colorFlag = !colorFlag //            }
        }
        context!.strokePath()
        
    }
    
}

class Line {
    var startPoint: CGPoint!
    var endPoint: CGPoint!
    init(_ start: CGPoint, _ end: CGPoint) {
        startPoint = start
        endPoint = end
    }
}

class Alphabet {
    
//    class func getC() -> UIBezierPath {
//        
////        pointArray.append(CGPoint(x: 170, y: 26.5 ))
////        pointArray.append(CGPoint(x: 125.5, y: 18.5 ))
////        pointArray.append(CGPoint(x: 91.0, y: 57.5 ))
////        pointArray.append(CGPoint(x: 101.5, y: 105.5 ))
////        pointArray.append(CGPoint(x: 155.5, y: 124.5 ))
////        pointArray.append(CGPoint(x: 188.0, y: 98.0 ))
//        let path = UIBezierPath()
//        path.move(to:  CGPoint(x:117.8125, y:480))
//        path.addQuadCurve(to:  CGPoint(x:115, y:478.375), controlPoint: CGPoint(x:116.125, y:478.75))
//        path.addQuadCurve(to:  CGPoint(x:111.5625, y:477.8125), controlPoint: CGPoint(x:113.71875, y:477.78125))
//        path.addQuadCurve(to:  CGPoint(x:108.40625, y:478.640625), controlPoint: CGPoint(x:110.28125, y:477.84375))
//        path.addQuadCurve(to:  CGPoint(x:105.40625, y:480.5), controlPoint: CGPoint(x:106.53125, y:479.4375))
//        path.addQuadCurve(to:  CGPoint(x:101.75, y:488.09375), controlPoint: CGPoint(x:101.75, y:483.90625))
//        path.addQuadCurve(to:  CGPoint(x:103.75, y:495.21875), controlPoint: CGPoint(x:101.75, y:492.28125))
//        path.addQuadCurve(to:  CGPoint(x:111.5625, y:500), controlPoint: CGPoint(x:107, y:500))
//        path.addQuadCurve(to:  CGPoint(x:117.84375, y:498.375), controlPoint: CGPoint(x:115, y:500))
//        path.addQuadCurve(to:  CGPoint(x:121.28125, y:494.78125), controlPoint: CGPoint(x:120.0625, y:497.09375))
//        return path
//    }
    
    class func getA() -> UIBezierPath {
        let path = UIBezierPath(svgPath: "M168 85q-35 41 -56 86q-23 50 -30 83q-6 24 -14 77q-2 66 11 124q18 76 74 147q50 63 127 93q44 17 95 18q8 0 54 -2q118 -18 174 -115q-2 39 -4 92q-1 24 19 29q48 6 53 -16v-357v-126q0 -73 3 -83q21 -71 65 -69q44 5 95 91q14 23 55 106q7 18 23 52q17 5 27 3 q18 -5 27 -25l-33 -76q-36 -84 -79 -133q-61 -84 -123 -84q-50 0 -84 45q-18 24 -35 77q-14 -19 -24 -33q-16 -22 -45 -40q-17 -15 -64 -33q-22 -12 -75 -17q-50 -4 -75 1q-58 4 -107 41q-12 7 -54 44zM231 588q-60 -67 -87 -156q-11 -46 -9 -106q1 -35 22 -94 q28 -79 65 -104q12 -20 78 -52q60 -24 125 -5q49 14 99 53q39 37 57 82q8 14 22 93l2 135q0 -9 -2 -11q-21 0 -21 42q-2 53 -7 63q-36 65 -90 96q-32 19 -108 26q-90 -13 -146 -62z")
        let trans = CGAffineTransform(scaleX: 0.25, y: -0.25)
        path.apply(trans)
        var translate = CGAffineTransform(translationX:(50 - path.currentPoint.x), y: (100 - path.currentPoint.y))
        path.apply(translate)
        print(path)
        return path
    }
    
    class func getAPoints() ->[[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:139.0,y:  107.5))
        array1.append(CGPoint(x:82.0,y:  76.0))
        array1.append(CGPoint(x:27.0,y:  116.0))
        array1.append(CGPoint(x:21,y:  186.0))
        array1.append(CGPoint(x:80.5,y:  237.5))
        array1.append(CGPoint(x:136.5,y:  209.0))
        pointArrays.append(array1)
        
        array1 = [CGPoint]()
        array1.append(CGPoint(x: 151.5, y: 77.5))
        array1.append(CGPoint(x: 152.5, y: 117.5))
        array1.append(CGPoint(x: 150.5, y: 166.5))
        array1.append(CGPoint(x: 152.0, y: 207.0))
        array1.append(CGPoint(x: 184.5, y: 237.0))
        array1.append(CGPoint(x: 212.0, y: 203.5))
        array1.append(CGPoint(x: 227.0, y: 171.5))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getU() -> UIBezierPath {
        let path = UIBezierPath(svgPath: "M1111 1770l55 -12v-463q14 -113 0 -364v-298q0 -261 9 -301q4 -122 46 -206q22 -25 95 -55q36 7 73 13q53 13 69 40q36 34 93 115q21 46 31 64q19 36 33.5 43.5t35.5 13.5q-2 -8 14 -20.5t13 -22.5q-34 -59 -87 -159q-17 -26 -41 -48q-29 -27 -48 -50q-81 -60 -201 -60q-92 29 -141 98q-27 56 -36 81q-16 51 -22 127q-6 -26 -38 -65q-42 -53 -51 -68l-113 -104q-58 -48 -169 -69q-87 8 -180 60q-81 104 -97 191q-4 31 -7 122q-1 27 -7 69q0 132 -6 234l3 177q-3 81 -3 191l-9 251l-23 139q-14 83 -69 159q-58 62 -174 90q-19 2 -35 2q-38 0 -153 -37q-88 -57 -142 -147q-14 -34 -28 -70t-18 -84q14 -117 72 -185q77 -49 142 -55q28 4 57 9q33 7 53 23q48 29 101 87q12 41 41 136q42 -5 72 -22q-11 -48 -50 -160q-52 -63 -130 -110q-40 -24 -150 -38q-82 11 -162 55q-28 29 -86 119q-21 43 -32 144q5 65 23 122q16 41 84 136q57 63 121 98t168 49q129 -11 193 -44.5t121 -120.5q41 -76 60 -190q18 -107 20 -230l11 -792q1 -105 11.5 -144t55.5 -105q67 -58 143 -58q19 0 45 3q93 36 147 96q51 55 130 165q6 16 47 92q7 4 4 104q-4 109 -1 122l3 304q1 121 -2 221q-4 114 -4 219v341z")
        let trans = CGAffineTransform(scaleX: 0.15, y: -0.15)
        path.apply(trans)
        var translate = CGAffineTransform(translationX:(250 - path.currentPoint.x), y: (100 - path.currentPoint.y))
        path.apply(translate)
        print(path)
        return path
    }
    
    class func getUPoints() ->[[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:124.5,y: 165.5))
        array1.append(CGPoint(x:54.0,y: 188.0))
        array1.append(CGPoint(x:69.0,y: 119.5))
        array1.append(CGPoint(x:136.5,y: 120.5))
        array1.append(CGPoint(x:152.0,y: 187.0))
        array1.append(CGPoint(x:154.0,y: 294.0))
        array1.append(CGPoint(x:171.0,y: 350.0))
        array1.append(CGPoint(x:216.5,y: 350.0))
        array1.append(CGPoint(x:246.0,y: 314.0))
        array1.append(CGPoint(x:252.5,y: 255.5))
        array1.append(CGPoint(x:254.5,y: 181.5))
        array1.append(CGPoint(x:253.0,y: 113.5))
        array1.append(CGPoint(x:267.0,y: 353.5))
        array1.append(CGPoint(x:301.0,y: 353.5))
        array1.append(CGPoint(x:329.0,y: 315.5))
        pointArrays.append(array1)
        
        return pointArrays
    }
    
    class func getZ()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M1291 1790q49 -5 68 -20q-12 -44 -40 -90q-25 -57 -131 -208q-100 -142 -188 -232l-237 -243q-116 -115 -281 -292q-101 -127 -223 -321q-76 -117 -150 -255q120 94 275 119q27 4 57 4q120 0 235 -65q120 -68 147 -79q72 -28 194 -34q140 -7 265 145q102 123 102 181q-1 4 -2 4q65 -16 58 -43q-5 -45 -76 -147q-61 -89 -101 -128q-85 -51 -91 -54q-66 -32 -132 -32q-121 0 -231 42q-44 17 -166 82q-88 46 -144 52q-35 4 -66 4q-107 0 -197 -50q-31 -17 -188 -130q-18 3 -48 37q34 110 103 223q273 449 440 619q200 199 400399q169 180 305 409q-121 -99 -367 -99q-164 0 -393 86q-73 27 -136 32q-77 -8 -130 -29q-15 -8 -113 -95q-34 -47 -44 -157q7 -57 27 -89.t75 -80.5l112 -38q97 2 139 29q27 14 99 70q7 7 46 63q26 0 55 -9q-14 -44 -48 -91q-53 -54 -111 -89q-30 -13 -116 -36q-61 -5 -107 8q-28 -4 -127 48q-55 53 -100 140q-10 77 22 214q26 41 98 128q38 22 139 66q91 15 139 3l55 -14l217 -73q112 -38 248 -20q139 5 240 64q4713 124 72z")
        let trans = CGAffineTransform.init(scaleX: 0.15, y: -0.15)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (300 - path.currentPoint.x), y: (100 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getZPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:132.5,y: 225.0))
        array1.append(CGPoint(x:56.5,y: 231.5))
        array1.append(CGPoint(x:104.5,y: 168.5))
        array1.append(CGPoint(x:200.5,y: 180.0))
        array1.append(CGPoint(x:299.5,y: 107.5))
        array1.append(CGPoint(x:190.0,y: 239.0))
        array1.append(CGPoint(x:113.0,y: 358.0))
        array1.append(CGPoint(x:182.0,y: 335.5))
        array1.append(CGPoint(x:249.5,y: 362.0))
        array1.append(CGPoint(x:315.5,y: 317.0))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getY()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M1055 1765q62 -17 69 -68l-15 -130l-10 -540l4 -992l127 151l85 113q20 26 24 30q14 12 36 13l24 -41l-32 -56l-56 -66l-126 -156l-74 -98q-4 -67 -8 -181l-5 -266l-35 -191q-5 -28 -30 -92q-26 -70 -43 -91q-7 -18 -31 -44q-31 -33 -39 -45q-50 -42 -110 -62q-70 -7 -110 38q-40 38 -57 129q-13 69 14 186l43 134l64 143l95 145l69 94l63 78q19 16 45 70l-3 140l3 81q12 46 0 129l-105 -148q-44 -61 -116 -118q-73 -45 -151 -54q-68 -16 -132 0q-63 16 -113 70q-53 58 -68 145l-19 277l2 276l-3 109l3 114l6 141l4 139l1 128q1 94 -26 176l-57 72q-42 22 -125 56q-22 6 -112 0q-65 -4 -111 -27q-37 -12 -80 -54q-34 -42 -56 -87q-19 -55 -24 -125q0 -29 22 -111q37 -62 78.5 -91t90.5 -41q31 2 62 3q40 3 64 18q25 12 64 50q18 27 46 88q2 25 3 50q2 30 22 40q25 -3 57 -20q-2 -50 -13 -89q-13 -44 -44 -99l-73 -77l-84 -36l-110 -8q-69 20 -114 46l-70 61q-5 7 -56 91q-12 50 -16 112q-5 74 14 129q27 77 76 132q42 47 106 83q54 23 149 36q47 0 147 -12q82 -26 141 -68l61 -86l27 -107l17 -143l-2 -90l-7 -128l-3 -150l-4 -497l10 -187l13 -118l67 -97l94 -32l79 17q22 0 71 25t68 44l70 78l76 110q29 50 78 135q5 39 0 86q3 38 -2 142l7 179q-4 90 -10 322l10 145q-1 14 -8 132l8 124l-3 118zM1036 -156l-165 -220l-52 -78l-44 -89l-43 -122q-29 -82 -24 -156q6 -91 43 -137q31 -11 51 -11q25 0 53.5 21.5t91.5 107.5q34 82 69 213q20 167 20 282v189z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (200 - path.currentPoint.x), y: (250 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getYPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:117.5,y: 96.5))
        array1.append(CGPoint(x:67.5,y: 87.0))
        array1.append(CGPoint(x:132.5,y: 78.5))
        array1.append(CGPoint(x:134.0,y: 178.5))
        array1.append(CGPoint(x:158.0,y: 230.5))
        array1.append(CGPoint(x:198.5,y: 197.5))
        array1.append(CGPoint(x:202.5,y: 154.0))
        array1.append(CGPoint(x:204.5,y: 64.0))
        array1.append(CGPoint(x:203.5,y: 259.0))
        array1.append(CGPoint(x:175.0,y: 333.0))
        array1.append(CGPoint(x:202.0,y: 237.0))
        array1.append(CGPoint(x:232.5,y: 205.0))
        pointArrays.append(array1)
        return pointArrays
    }

    class func getX()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M1223 1800q47 -4 78 -16q18 -10 46 -55l19 -61l3 -48l-3 -61l-17 -79l-69 -117l-121 -140l-78 -79q-53 -54 -102 -84l-106 -87l-114 -83l-8 -84q-3 -46 -11 -159l14 -199q12 -72 32 -113q14 -30 44 -92q22 -47 51 -91l76 -60l75 -23q56 -7 89 8q37 6 79 41l49 40q48 62 58 96l26 87l8 89l-17 73l-19 55l-36 52l-49 34q-41 15 -84 18q-43 -7 -73 -20q-18 -16 -63 -53q-24 -35 -36 -79q-14 -53 -13 -100l-18 -17q-37 -2 -55 14l7 72l14 65l29 63q19 42 71 73q39 30 90 40l58 11l68 -10l64 -31q19 -13 59 -57q35 -52 51 -103q17 -68 20 -110q4 -61 -14 -128q-10 -37 -36 -92q-22 -46 -50 -80l-60 -60l-86 -42q-74 -22 -124 -18q-33 2 -97 27q-42 22 -73 53l-60 60q-53 73 -87 171.5t-35 228.5l-42 -139q-45 -103 -89 -161l-98 -118q-41 -39 -111 -78q-38 -27 -108 -34q-32 -10 -100 -10q-57 21 -80 50q-26 28 -45 97q-6 90 -5 103q5 98 70 190q97 137 190 210l115 90l185 130q38 24 98 72q-6 75 -17 224q-2 42 -9 129l-11 93l-24 104q-11 25 -37 87q-19 19 -56 62l-74 54q-43 17 -104 20q-71 -7 -98 -20q-56 -37 -88 -73l-50 -92l-10 -73l-3 -72l23 -85q12 -46 40 -90q11 -17 52 -51q55 -38 105 -32q64 8 103 43q16 15 47 62l9 72l5 69q13 12 59 17q9 -56 5 -115q-11 -35 -32 -101l-55 -64q-23 -20 -51.5 -30.5t-55.5 -19.5q-16 -7 -84 -2q-48 9 -87 32q-35 21 -70 60l-50 80q-32 85 -32 181q0 46 8 90q15 81 61 146l59 67q74 62 193 74q73 -7 127 -32q58 -27 108 -73q40 -45 66 -93q36 -51 49 -131l27 -169l10 -206l21 152q6 44 33 124l53 129l64 104q29 32 83 87l70 52l68 39zM1235 1723q-56 3 -114 -20l-92 -66q-99 -99 -133 -174q-76 -166 -90 -260l-29 -200l72 47q52 39 134 101l101 95q30 28 84 96l55 69q19 23 52 84q26 74 19 139q-8 75 -59 89zM670 850l-188 -128q-94 -53 -174 -133l-115 -115q-51 -51 -87 -136q-26 -61 -27 -128q11 -87 55 -121q27 -7 54 -7q77 0 180 65q34 29 91 95l61 78l58 107q24 45 53 165l28 98q-1 14 6.5 61t7.5 70q0 17 -3 29z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (200 - path.currentPoint.x), y: (250 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getXPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:183.5,y: 200.0))
        array1.append(CGPoint(x:137.5,y: 189.5))
        array1.append(CGPoint(x:144.5,y: 326.0))
        array1.append(CGPoint(x:180.5,y: 257.5))
        array1.append(CGPoint(x:261.5,y: 161.5))
        array1.append(CGPoint(x:206.0,y: 240.0))
        array1.append(CGPoint(x:237.0,y: 328.5))
        array1.append(CGPoint(x:225.0,y: 292.5))
        pointArrays.append(array1)
        return pointArrays
    }

    class func getW()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M1091 1770q33 2 55 -12v-463q4 -298 0 -364v-298q0 -261 9 -301q4 -122 46 -206q46 -54 109 -59q94 4 171 70q73 54 110 103q2 2 63 95q43 65 61 133q11 39 26 115q4 55 15 148q3 12 11 180q-1 79 5 189q5 24 -1 133q-84 22 -179 51q-70 45 -115 120q-34 56 -29 163q4 73 33 113q34 45 115 71q36 11 104 0q30 -219 13 -337q-8 -1 -16 -3q9 113 84 294q41 -37 56 -131q4 -20 7 -127q-1 -65 4 -131q69 -1 157 49q36 21 70 83q28 49 29 63q68 -28 68 -34q2 -23 -29 -74q-29 -47 -58 -75t-86 -56q-40 -20 -150 -41q-1 -56 -3 -175q-3 -102 -10 -182q-2 -53 -7 -151q-7 -57 -16.5 -162t-59.5 -192q-25 -50 -91 -152q-38 -59 -139 -140q-104 -77 -242 -77q-92 29 -141 98q-27 56 -36 81q-16 51 -22 127q-6 -26 -38 -65q-42 -53 -51 -68l-113 -104q-58 -48 -169 -69q-87 8 -180 60q-81 104 -97 191q-4 31 -7 122q-1 27 -7 69q0 132 -6 234l3 177q-3 81 -3 191l-9 251l-23 139q-14 83 -69 159q-58 62 -174 90q-19 2 -35 2q-38 0 -153 -37q-88 -57 -142 -147q-14 -34 -28 -70t-18 -84q14 -117 72 -185q77 -49 142 -55q89 7 125 40q31 19 86 79q26 54 41 136q19 -2 38 -3q2 -1 34 -19q-13 -54 -57 -159q-60 -73 -123 -111q-40 -24 -150 -38q-82 11 -162 55q-28 29 -86 119q-21 43 -32 144q5 65 23 122q16 41 84 136q57 63 121 98t168 49q129 -11 193 -44.5t121 -120.5q41 -76 60 -190q18 -107 20 -230l11 -792q1 -103 12 -143t55 -106q67 -58 143 -58q19 0 45 3q93 36 147 96q51 55 130 165q6 16 47 92q7 4 4 104q-4 109 -1 122l3 304q1 121 -2 221q-4 114 -4 219v341q3 25 20 32zM1533 1501q4 -76 75 -127q66 -48 160 -55q-2 53 -8 201q-3 70 -36 115t-76 43q-124 -6 -115 -177z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (250 - path.currentPoint.x), y: (150 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getWPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:122.0,y: 169.0))
        array1.append(CGPoint(x:78.5,y: 140.5))
        array1.append(CGPoint(x:141.5,y: 199.0))
        array1.append(CGPoint(x:169.0,y: 296.0))
        array1.append(CGPoint(x:208.5,y: 199.5))
        array1.append(CGPoint(x:207.0,y: 128.0))
        array1.append(CGPoint(x:236.0,y: 295.5))
        array1.append(CGPoint(x:277.5,y: 211.0))
        array1.append(CGPoint(x:246.5,y: 150.5))
        array1.append(CGPoint(x:309.5,y: 154.5))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getV()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M841 1790q49 -5 68 -20q-12 -44 -40 -90q-40 -92 -60 -170q-46 -176 -46 -232v-258l29 -286q30 -300 23 -474q-11 -77 -52 -154l95 73l81 91q40 67 80 160l50 180q7 60 20 190q1 209 38 380l46 214q21 58 76 176q41 75 100 130q48 32 58 38q40 21 84 25q70 13 148 2q56 -8 111 -53q54 -55 45 -166q-5 -43 -30 -73q-28 -26 -56 -53q-73 -44 -170 -50q-17 19 -16 58q60 2 134 32q77 53 77 119q0 31 -13 71q-63 53 -154 53q-33 0 -79 -5q-47 -10 -119 -78l-90 -140q-35 -82 -60 -180q-56 -221 -69 -578q-2 -53 -41 -232q-23 -105 -60 -180l-90 -140l-95 -87q-97 -59 -205 -83q-13 7 -38 45l63 67q48 62 58 205q6 77 -8 284q-6 47 -21 249l-14 217v233l20 118l20 102l28 87l31 80q-37 -30 -108 -47q-112 -12 -202 34q-51 26 -136 32q-77 -8 -130 -29q-15 -8 -113 -95q-34 -47 -44 -157q7 -57 27 -89.5t75 -80.5l112 -38q97 2 139 29q27 14 99 70q7 7 46 63q26 0 55 -9q-14 -44 -48 -91q-53 -54 -111 -89q-30 -13 -116 -36q-61 -5 -107 8q-28 -4 -127 48q-55 53 -100 140q-10 77 22 214q26 41 98 128q38 22 139 66q91 15 139 3l55 -14l66 -24l81 -26q77 3 108 21q41 8 124 72z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (150 - path.currentPoint.x), y: (150 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getVPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:123.5,y: 194.5))
        array1.append(CGPoint(x:69.5,y: 177.0))
        array1.append(CGPoint(x:151.5,y: 155.0))
        array1.append(CGPoint(x:140.5,y: 245.5))
        array1.append(CGPoint(x:134.5,y: 322.0))
        array1.append(CGPoint(x:178.0,y: 238.5))
        array1.append(CGPoint(x:232.0,y: 156.0))
        array1.append(CGPoint(x:221.5,y: 188.0))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getB() -> UIBezierPath {
        let path = UIBezierPath(svgPath: "M443 0q-57 -6 -97 9.5t-91 49.5q-37 26 -58.5 68.5t-34.5 97.5q-11 48 -18 144l-8 112q-1 9 4 157q-61 -108 -81 -134l-82 -112q-39 2 -43 44l50 79l60 85l59 84l36 57q0 82 -4 254q-3 147 -2 177l6 163q2 58 26 159q13 54 52 139l55 91q33 34 63 49l69 37  q86 -14 117 -47l29 -89l-10 -130q-22 -81 -63 -223q-19 -63 -59 -164l-64 -162l-149 -297q-1 -22 0 -52l3 -99v-105l11 -117q8 -84 27 -129q7 -34 51 -80q33 -22 49 -29q25 -12 56 -17q66 0 127 51q50 40 72 87l4 7q27 55 30 95q15 79 15 151q-65 17 -103 54q-21 20 -37 65  q-19 55 13 104q19 16 68 29q67 -4 94 -52q35 -59 35 -103q47 17 121 63q14 9 32 1q6 -27 9 -53q-83 -62 -167 -91q-13 -159 -27 -216q-21 -85 -86 -164q-11 -20 -60 -59q-18 -15 -99 -39zM290 1651l-53 -119q-29 -116 -41 -258l5 -450q45 95 114 254q60 134 101 275l64 220  q12 73 -3 123q-31 46 -91 42q-27 -19 -53 -39q-33 -26 -43 -48zM583 635q-8 -12 -8 -25q0 -24 23 -43.5t44 -19.5q6 0 11 2q2 8 2 16q0 31 -21 53t-51 17z")
        let trans = CGAffineTransform.init(scaleX: 0.15, y: -0.15)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (150 - path.currentPoint.x), y: (200 - path.currentPoint.y) )
        path.apply(translation)
        return path
    }
    
    class func getBPoints() -> [[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:57.0, y: 230.5))
        array1.append(CGPoint(x:88.5, y: 188.5))
        array1.append(CGPoint(x:115.5, y: 132.5))
        array1.append(CGPoint(x:135.0, y: 73.0))
        array1.append(CGPoint(x:122.5, y: 30.0))
        array1.append(CGPoint(x:88.0, y: 88.0))
        array1.append(CGPoint(x:87.5, y: 156.5))
        array1.append(CGPoint(x:89.0, y: 241.5))
        array1.append(CGPoint(x:114.0, y: 287.0))
        array1.append(CGPoint(x:156.5, y: 264.5))
        array1.append(CGPoint(x:165.0, y: 217.0))
        array1.append(CGPoint(x:144.0, y: 198.0))
        array1.append(CGPoint(x:188.5, y: 207.5))
        pointArrays.append(array1)
        return pointArrays
    }

    class func getT()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M431 1811q112 10 181 -2l166 -30l181 -45l130 49q106 40 199 37q78 -15 120 -90q-1 -50 -50 -91q-38 -25 -128 -44q-127 12 -270 67q-45 -21 -139 -60l-115 -84l-99 -106l-79 -118l-66 -129q166 4 279 35l167 50q40 20 134 62q3 -12 11 -25t8 -18t-5 -10q-16 -15 -74 -46q-58 -24 -179 -62.5t-145 -40.5q-99 -20 -216 -19q-37 -100 -39 -185l-4 -146q16 -122 38 -186l49 -124l72 -149q47 -75 102 -112q41 -45 130 -86q52 -18 74 -23q41 -10 87 -12q111 12 190 60q58 23 105 87q44 60 70 144l14 94q1 31 -12 86q-5 36 -58 104q-38 34 -126 43q-36 0 -106 -21q-56 -35 -103 -122l-32 -113q-6 -8 -55 0q-11 19 -7 42q3 16 7 32q17 52 53 121q15 24 72 81q94 52 185 48q122 -16 171 -69q51 -64 66 -125q3 -14 11 -116l-8 -64q-5 -44 -60 -150q-19 -34 -61 -92q-85 -71 -129 -89q-88 -37 -190 -49q-119 8 -160 31q-20 4 -69 31.5t-71 47.5q-62 42 -111 101t-79 129l-64 147q-14 48 -46 153q-19 87 -20 180q-1 91 20 190l21 89l-89 25q-48 17 -138 73q-64 50 -93 105q-36 68 -52 156q10 74 43 144q35 50 96 100q43 35 125 68t170 41zM408 1745q-83 -11 -134 -34q-56 -25 -98 -61q-56 -39 -84 -88q-25 -44 -27 -88q-2 -49 18 -90q5 -25 40 -82q32 -39 87 -73q80 -49 183 -63q35 77 72 148l83 126q131 168 320 250l-158 38q-101 24 -166 22q-57 6 -136 -5zM1043 1702q110 -32 158 -34q12 -3 25 -3q37 0 66 19t26 35q-14 27 -68 29q-31 -1 -207 -46z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (200 - path.currentPoint.x), y: (150 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getTPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:199.5,y: 194.0))
        array1.append(CGPoint(x:97.0,y: 171.0))
        array1.append(CGPoint(x:231.5,y: 149.0))
        array1.append(CGPoint(x:146.5,y: 182.5))
        array1.append(CGPoint(x:163.0,y: 305.5))
        array1.append(CGPoint(x:225.0,y: 296.5))
        array1.append(CGPoint(x:182.0,y: 271.5))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getC() -> UIBezierPath {
        let path = UIBezierPath(svgPath: "M570 640q34 -36 39 -67q-8 -31 -54 -26q-16 19 -40 44q-8 10 -48 31.5t-94 16.5q-39 -3 -97 -28q-46 -20 -82 -61q-39 -46 -51 -77q-19 -68 -20 -113q-1 -30 17 -97q21 -54 49 -90q40 -51 75 -77q70 -34 120 -31q102 6 157 47q51 39 74 70q12 19 40 51q20 -6 42 -25q0 -11 -16 -41q-39 -74 -110 -115q-91 -52 -201 -52q-146 0 -250 153q-64 94 -64 228t117 243q36 34 96 59.5t101 26.5q69 1 110 -18q36 -12 90 -52z")
        let trans = CGAffineTransform.init(scaleX: 0.25, y: -0.25)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (200 - path.currentPoint.x), y: (50 - path.currentPoint.y) )
        path.apply(translation)
        return path
    }
    
    class func getCPoints() -> [[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:203.0, y: 68.5))
        array1.append(CGPoint(x:152.5, y: 41.0))
        array1.append(CGPoint(x:92.0, y: 75.0))
        array1.append(CGPoint(x:94.0, y: 165.0))
        array1.append(CGPoint(x:162.0, y: 200.5))
        array1.append(CGPoint(x:225.0, y: 158.0))
        pointArrays.append(array1)
        return pointArrays
    }

    class func getS()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M1032 1790q56 -8 71 -14q35 -11 61 -41q27 -48 29 -84q4 -76 -11 -131q-32 -120 -83 -219q-101 -150 -157 -201q-67 -85 -176 -159q6 -76 6 -101l-3 -248q0 -35 -2 -91q0 -22 -1 -44q-4 -88 -27 -173q-8 -48 -77 -164q-52 -53 -130 -90q-76 -28 -170 -30q-88 9 -170 50q-74 38 -122 100q-29 39 -68 155q-1 44 10 155q14 46 64 132q58 64 130.5 99t185.5 26q60 -8 130 -67q43 -63 60 -130q1 -41 -11 -136q-18 -8 -40 -4q-23 5 -29 20l11 79q-7 81 -61 148q-57 30 -144 32q-57 -9 -125 -49l-69 -73q-30 -52 -47 -120q-14 -57 1 -122q10 -37 52 -106q33 -44 115 -89q51 -17 63 -20q37 -9 93 -10q102 2 188 62q36 44 49 64q30 43 42 81q28 91 33 230l7 199q-6 105 -2 208l-156 -67q-59 -25 -168 -33q-85 -6 -153 15q-76 23 -122 64q-31 28 -74 118q-21 97 -23 169q9 80 40 180l71 115q18 30 67 78q43 44 62 56l111 71q70 32 183 68l126 12l32 -28l-9 -35l-28 -13q-50 8 -105 -1q-45 -8 -149 -53q-67 -29 -149 -100l-86 -91q-51 -54 -81 -158q-26 -89 -15 -181q10 -88 70 -150q64 -57 139 -66q70 -9 124 0q88 14 118 26q49 20 109 50l60 30l-4 94l-11 124l-6 122q-2 32 26 145q10 40 65 145q72 76 120 100q49 41 140 70zM1040 1718q-52 -8 -106 -40l-71 -62q-6 -6 -62 -88l-38 -95q-18 -90 -17 -138q2 -43 7 -118q2 -56 9 -157l108 88l81 94q19 19 53 76l53 89q30 50 55 137q25 128 3 188q-42 31 -75 26z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (200 - path.currentPoint.x), y: (150 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getSPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:164.0,y: 150.0))
        array1.append(CGPoint(x:106.5,y: 227.0))
        array1.append(CGPoint(x:208.0,y: 149.0))
        array1.append(CGPoint(x:168.5,y: 265.0))
        array1.append(CGPoint(x:99.0,y: 289.0))
        array1.append(CGPoint(x:151.0,y: 278.0))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getD() -> UIBezierPath {
        let path = UIBezierPath(svgPath: "M672 1387q0 -10 -2 -34.5t-2 -40.5l5 -1099q6 -129 72 -135q46 -4 106 107l51 95q10 26 28 72q4 17 20 40l50 -25q-10 -58 -90 -218q-20 -40 -80 -110q-40 -31 -83 -39q-59 10 -86 44.5t-47 114.5q-17 -30 -61 -72t-74 -55q-80 -34 -134 -32q-62 3 -117 34q-49 28 -81 69q-28 32 -50 82q-14 31 -21 65q-11 52 -6 119q5 64 30 129q27 69 70 110q28 35 82 74q51 25 119 33q160 1 231 -102q0 6 -1 202l-1 210l3 169v138q0 -15 -2 52q-2 41 1 52q25 9 49 7q20 -23 21 -56zM292 627q-24 -12 -70 -53q-35 -31 -59 -79q-24 -67 -25 -87 q-14 -47 -6 -107q3 -25 31 -100q38 -74 98 -109q45 -26 112 -26q35 2 89 32q18 11 58 49q12 13 32 35q11 12 23 34t27 85q8 51 5 98l-3 49q-3 52 -23 86q-12 21 -57 71q-65 38 -126 44q-44 -1 -106 -22z")
        let trans = CGAffineTransform.init(scaleX: 0.2, y: -0.2)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (150 - path.currentPoint.x), y: (220 - path.currentPoint.y) )
        path.apply(translation)
        return path
    }
    
    class func getDPoints() -> [[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:205.0, y: 225.5))
        array1.append(CGPoint(x:149.0, y: 215.0))
        array1.append(CGPoint(x:116.5, y: 250.0))
        array1.append(CGPoint(x:128.0, y: 321.0))
        array1.append(CGPoint(x:189.0, y: 331.5))
        array1.append(CGPoint(x:219.5, y: 277.5))
        array1.append(CGPoint(x:205.0, y: 225.5))
        pointArrays.append(array1)
        array1 = [CGPoint]()
        array1.append(CGPoint(x:219.0, y: 63.0))
        array1.append(CGPoint(x:220.0, y: 122.5))
        array1.append(CGPoint(x:219.0, y: 188.0))
        array1.append(CGPoint(x:220.0, y: 266.0))
        array1.append(CGPoint(x:242.5, y: 337.5))
        array1.append(CGPoint(x:284.5, y: 276.5))
        pointArrays.append(array1)
        return pointArrays
    }
        
    class func getR()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M712 1798q77 3 187 -9q56 -10 178 -50l18 28l55 -23q-2 -23 0 -49q67 -47 98 -81q37 -41 89 -149q37 -83 44 -211q-5 -112 -59 -226q-31 -36 -95 -99q54 -29 136 -127q26 -56 58 -149q7 -21 8 -78q2 -83 2 -85l19 -258q11 -67 61 -122q43 -39 130 -44q72 22 99 62l58 87l43 115q25 2 46 -8l14 -42l-72 -155q-40 -59 -84.5 -91t-114.5 -44q-66 8 -98 22q-11 3 -70 47q-2 2 -67 81l-24 100l-10 140l3 91l-12 133l-32 119q-4 9 -77 105q-42 31 -93 45q-54 -45 -119 -73q-51 -22 -98 -22q-2 -129 -22 -308l-30 -130l-40 -100l-70 -90l-77 -60l-101 -50l-108 -29q-78 -18 -136 -2q-32 3 -138 41q-49 24 -100 60l-70 80q-11 27 -31 99l-9 87l12 100q3 18 34 85l69 85q4 3 95 54q47 18 110 20q73 -12 126 -39q47 -34 74 -71q34 -59 40 -110l10 -87l-57 -13q-16 8 -18 25q-2 26 -9 39q1 41 -28 99l-55 57q-48 22 -134 22q-68 -9 -114 -51l-56 -85q-5 -11 -29 -116q1 -78 16 -117q18 -46 66 -93q34 -28 98 -60q26 -12 97 -31l93 -6q87 7 136 34l114 63l80 80l57 136q32 133 33 224l2 146q-37 -3 -107 20q-30 10 -54 36t-24 48q4 42 43 75l73 32l77 13v240l10 140l30 120q21 58 56 106q23 28 54 74l-81 35l-124 19l-147 -2q-201 -3 -337 -88q-30 -13 -84 -54.5t-71 -66.5q-32 -25 -86 -123q-30 -72 -33 -106q1 -47 14 -140q9 -29 69 -104q38 -38 109 -66q44 -6 78 -6q68 0 136 30l98 60q38 48 70 119q32 152 31 231q24 13 68 12l-4 -107l-16 -103l-36 -114l-72 -101q-44 -35 -130 -73q-100 -31 -153 -30q-77 2 -145 33q-62 28 -104 75q-23 25 -34 42q-20 30 -26 58q-24 65 -24 117q0 84 14 133q23 83 61 136q65 90 115 126l99 71q166 88 273 96q47 8 163 19zM1094 1636l-63 -76l-50 -80l-30 -100l-10 -112v-159l6 -109q111 -9 194 -40l80 62q19 26 50 83q22 60 27 132q4 61 -13 145l-45 111q-26 30 -73 87zM951 910q1 -7 -4 -46q43 5 56 9q21 7 48 29q-48 13-100 8zM820 902q-22 -2 -31 -9q-11 -10 -21 -20q57 -29 89 -26l6 58z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (190 - path.currentPoint.x), y: (250 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getRPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:177.5,y: 202.5))
        array1.append(CGPoint(x:114.0,y: 198.0))
        array1.append(CGPoint(x:241.0,y: 203.5))
        array1.append(CGPoint(x:179.0,y: 251.5))
        array1.append(CGPoint(x:243.0,y: 270.5))
        array1.append(CGPoint(x:293.5,y: 313.0))
        array1.append(CGPoint(x:214.5,y: 169.0))
        array1.append(CGPoint(x:180.5,y: 319.5))
        array1.append(CGPoint(x:111.5,y: 305.5))
        array1.append(CGPoint(x:162.0,y: 296.0))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getE() -> UIBezierPath {
        let path = UIBezierPath(svgPath: "M312 212l-103 -47q27 -49 63 -66q69 -43 142 -27q56 9 113 45t90 82q27 34 62 87q17 11 23 10q14 -12 33 -38q-26 -38 -63 -95q-15 -21 -67 -73q-44 -34 -65.5 -45t-68.5 -29q-53 -16 -101 -16q-81 0 -144 50q-49 38 -78 82q-65 -33 -123 -44l-22 11q-12 21 -6 50l118 47 q-27 63 -29 144q-1 62 14 99q6 41 35 85l39 58q14 17 50 54q30 27 67 47q52 29 130 29q113 0 158 -78q29 -50 22 -110q-6 -55 -19 -78l-35 -63l-41 -48q-32 -37 -94 -70zM178 469q-28 -70 -28 -105q2 -30 6 -79q6 -33 19 -61q79 28 146 65q72 39 103 65q28 22 74 74 q46 79 39 137q-6 43 -49 65q-35 18 -79 15q-92 -6 -151 -65t-80 -111z")
        let trans = CGAffineTransform.init(scaleX: 0.2, y: -0.2)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (150 - path.currentPoint.x), y: (150 - path.currentPoint.y) )
        path.apply(translation)
        return path
    }
    
    class func getEPoints() -> [[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:120.5, y: 220.5))
        array1.append(CGPoint(x:187.0, y: 190.0))
        array1.append(CGPoint(x:228.0, y: 129.0))
        array1.append(CGPoint(x:164.0, y: 124.0))
        array1.append(CGPoint(x:139.0, y: 181.0))
        array1.append(CGPoint(x:198.0, y: 236.5))
        array1.append(CGPoint(x:255.0, y: 192.0))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getQ()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M846 1769q78 -9 143 -39q74 -34 137 -85q34 -27 102 -106l77 -133q22 -51 57 -170l33 -176v-143l-11 -137q-7 -91 -35 -180l-67 -152q-31 -57 -97 -152l-96 -103l-52 -46l70 -55q49 -18 75 -17q55 2 125 71q44 43 133 174q44 0 75 -37q-57 -83 -110 -145q-27 -29 -86 -83q-70 -55 -160 -55q-69 0 -131 55l-51 45q-43 -28 -141 -70q-77 -30 -146 -30q-68 0 -156 20q-46 11 -135 54q-82 45 -158 128q-57 63 -102 158l-59 126q-26 55 -51 164q-23 127 -20 180q-9 81 10 190q10 62 43 180q19 45 60 141l67 119l69 92q44 58 121 118q47 37 117 63q46 10 104 15l113 -13q28 15 44 20q38 13 89 14zM799 1690q-49 -17 -90 -50l-60 -80q-37 -122 -37 -179q0 -47 17 -139q37 -69 79 -94q34 -20 111 -28q56 15 65 20q19 9 61 44l48 75q29 -2 56 -23q-18 -65 -60 -116q-110 -76 -192 -76q-44 0 -98 16q-77 38 -109 91q-19 32 -51 139q-7 253 100 377q-38 8 -90 3l-100 -40l-70 -50l-141 -168l-79 -142l-41 -94q-38 -128 -38 -187q-12 -58 -1 -169l10 -103l29 -116l36 -100l45 -93l63 -112l97 -106q51 -41 122 -76l99 -27q44 -12 107 -9q67 3 103 18l96 40l24 17l-92 72l-102 61q-30 13 -112 28q-62 2 -108 -37q-15 -8 -27 -8q-17 0 -51 34q57 59 107 72q76 19 171 -2q76 -24 139 -67q98 -71 139 -113l62 43l70 70q28 38 93 126l50 108q30 65 56 171l17 213l-3 126q-2 78 -34 229q-35 95 -86 181q-29 49 -103 115l-98 67l-99 38q-48 18 -100 10z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (190 - path.currentPoint.x), y: (100 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getQPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:212.0,y: 149.0))
        array1.append(CGPoint(x:167.5,y: 136.0))
        array1.append(CGPoint(x:216.0,y: 101.5))
        array1.append(CGPoint(x:245.5,y: 188.0))
        array1.append(CGPoint(x:114.5,y: 197.0))
        array1.append(CGPoint(x:175.5,y: 99.5))
        array1.append(CGPoint(x:157.0,y: 239.0))
        array1.append(CGPoint(x:208.0,y: 253.5))
        array1.append(CGPoint(x:254.5,y: 242.5))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getG() -> UIBezierPath {
        let path = UIBezierPath(svgPath: "M586 628v86q29 11 66 0l-1 -623l81 94q37 66 93 159q21 -8 58 -35q-27 -58 -104 -174q-44 -53 -127 -163v-221v-181l-3 -142q-2 -98 -20 -193q-10 -53 -52 -143q-28 -60 -85 -99q-42 -39 -119 -39q-63 0 -110 66q-37 52 -25 186q11 120 45 236q9 36 72 202 q46 111 133 256l96 139l2 78l-38 -43l-78 -46q-63 -26 -138 -24q-70 11 -123 46q-66 44 -96 103q-35 68 -40 130l-7 83q7 66 19 102q15 48 53 114q35 60 99 98q75 40 162 37q111 -4 187 -89zM268 613q-21 -14 -66 -58q-28 -44 -46 -104.5t-20 -92.5q-4 -111 56 -192 q64 -86 162 -86q44 0 90 20q116 49 142 153v117v130q-17 73 -81.5 109.5t-130.5 36.5q-57 0 -106 -33zM542 -802q36 108 36 227l4 498q-100 -150 -163 -312q-68 -174 -77 -227q-25 -74 -34 -193q-4 -64 15 -122q14 -43 64 -43q46 12 97 58q36 46 58 114z")
        let trans = CGAffineTransform.init(scaleX: 0.2, y: -0.2)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (200 - path.currentPoint.x), y: (350 - path.currentPoint.y) )
        path.apply(translation)
        return path
    }
    
    class func getGPoints() -> [[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:203.0, y:  68.5))
        array1.append(CGPoint(x:140.5, y:  63.5))
        array1.append(CGPoint(x:113.0, y:  134.0))
        array1.append(CGPoint(x:165.0, y:  180.5))
        array1.append(CGPoint(x:216.5, y:  126.0))
        array1.append(CGPoint(x:203.0, y:  68.5))
        pointArrays.append(array1)
        array1 = [CGPoint]()
        array1.append(CGPoint(x:216.0, y:  53.0))
        array1.append(CGPoint(x:217.5, y:  118.5))
        array1.append(CGPoint(x:215.5, y:  206.0))
        array1.append(CGPoint(x:215.0, y:  300.0))
        array1.append(CGPoint(x:171.0, y:  391.5))
        array1.append(CGPoint(x:153.0, y:  311.0))
        array1.append(CGPoint(x:185.5, y:  231.5))
        array1.append(CGPoint(x:258.5, y:  133.5))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getH() -> UIBezierPath {
        let path = UIBezierPath(svgPath: "M217 1413q7 78 40 156q31 74 67.5 114t110.5 77q67 12 126 -19q41 -47 49 -88q14 -68 10 -139q-73 -395 -165 -557l-99 -174l-83 -128q1 -6 2 -102v-118q13 29 84 142q31 49 83 92t128 44q61 1 129 -44q40 -33 59 -66q16 -25 36 -125q7 -49 5 -134q-3 -114 14 -195 q11 -20 23.5 -40t35.5 -29q6 -2 13 -2q59 0 107 67l60 82l55 91q20 34 34 42q17 -9 48 -40l-45 -79l-69 -102q-27 -36 -100 -106q-50 -36 -101 -36q-13 0 -22 3q-37 15 -57 38q-34 42 -44 69q-19 71 -20 119q0 11 -6 195q-3 96 -39 151t-107 65q-68 10 -127 -65 q-13 -17 -97 -149q-19 -31 -54 -118q-16 -40 -16 -67v-239l-36 -11l-42 11l1 586l-52 -87l-35 -53q-15 -22 -35 -53q-9 -19 -16 -25q-8 -15 -25 -32q-39 26 -45 42q-5 13 28 53q5 7 22 35l21 34l54 82q12 18 75 115l7 466q-1 61 10 251zM311 1515q-35 -109 -36 -228l-3 -498 q99 150 163 313q22 51 70 227l40 192q5 66 -14 122q-14 44 -64 44q-46 -12 -97 -58q-36 -46 -59 -114z")
        let trans = CGAffineTransform.init(scaleX: 0.2, y: -0.2)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (150 - path.currentPoint.x), y: (100 - path.currentPoint.y) )
        path.apply(translation)
        return path
    }
    
    class func getHPoints() -> [[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:96.5, y:  326.5))
        array1.append(CGPoint(x:153.0, y:  247.5))
        array1.append(CGPoint(x:195.0, y:  151.5))
        array1.append(CGPoint(x:187.0, y:  60.5))
        array1.append(CGPoint(x:137.5, y:  143.5))
        array1.append(CGPoint(x:136.5, y:  235.5))
        array1.append(CGPoint(x:138.0, y:  324.5))
        array1.append(CGPoint(x:136.5, y:  398.0))
        array1.append(CGPoint(x:203.5, y:  272.0))
        array1.append(CGPoint(x:266.5, y:  396.0))
        array1.append(CGPoint(x:317.0, y:  340.0))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getI() -> UIBezierPath {
        let path = UIBezierPath(svgPath: "M184 716q4 3 5 37q45 4 64 -5v-542q0 -50 8 -84q12 -50 47 -55q42 -6 99 64q36 44 74 116q22 40 64 129q9 5 40 0q20 -11 12 -39l-20 -54l-49 -81q-25 -50 -64 -100q-40 -53 -79 -82q-55 -30 -97 -20q-47 11 -74.5 68.5t-26.5 132.5l2 154l-2 168q-12 -42 -32 -72 q-11 -15 -30 -47l-58 -65q-26 0 -41 44q11 13 36 45q106 143 125 288h-3zM156 898q0 64 64 64t64 -64t-64 -64t-64 64z")
        let trans = CGAffineTransform.init(scaleX: 0.25, y: -0.25)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (150 - path.currentPoint.x), y: (100 - path.currentPoint.y) )
        path.apply(translation)
        return path
    }
    
    class func getIPoints() -> [[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:126.5, y:  231.0))
        array1.append(CGPoint(x:166.0, y:  145.5))
        array1.append(CGPoint(x:166.0, y:  227.5))
        array1.append(CGPoint(x:192.0, y:  316.5))
        array1.append(CGPoint(x:253.0, y:  239.5))
        pointArrays.append(array1)
        array1 = [CGPoint]()
        array1.append(CGPoint(x:166.5, y:  101.0))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getK() -> UIBezierPath {
        let cfURL = Bundle.main.url(forResource: "HLHOCTRO", withExtension: "TTF") as! CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        //        let font = UIFont(name: "HL hoctro", size: 64)!
        let font = UIFont(name: "HL hoctro", size: 64)!
        
        var unichars = [UniChar]("k".utf16)
        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
        CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
        let path = UIBezierPath(cgPath: cgpath)
        let trans = CGAffineTransform(scaleX: 6, y: -6)
        path.apply(trans)
        let translate = CGAffineTransform(translationX: 100, y: 350)
        path.apply(translate)
        return path
    }
    
    class func getKPoints() -> [[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:107.0, y:  278.0))
        array1.append(CGPoint(x:157.0, y:  189.0))
        array1.append(CGPoint(x:193.0, y:  93.5))
        array1.append(CGPoint(x:171.5, y:  26.5))
        array1.append(CGPoint(x:138.5, y:  103.0))
        array1.append(CGPoint(x:138.0, y:  343.0))
        array1.append(CGPoint(x:214.5, y:  225.0))
        array1.append(CGPoint(x:176.5, y:  286.0))
        array1.append(CGPoint(x:250.0, y:  346.5))
        array1.append(CGPoint(x:292.5, y:  292.0))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getL() -> UIBezierPath {
        let cfURL = Bundle.main.url(forResource: "HLHOCTRO", withExtension: "TTF") as! CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        //        let font = UIFont(name: "HL hoctro", size: 64)!
        let font = UIFont(name: "HL hoctro", size: 64)!
        
        var unichars = [UniChar]("l".utf16)
        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
        CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
        let path = UIBezierPath(cgPath: cgpath)
        let trans = CGAffineTransform(scaleX: 6, y: -6)
        path.apply(trans)
        let translate = CGAffineTransform(translationX: 100, y: 350)
        path.apply(translate)
        return path
    }
    
    class func getLPoints() -> [[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:107.5, y:  277.0))
        array1.append(CGPoint(x:163.5, y:  189.0))
        array1.append(CGPoint(x:201.0, y:  90.0))
        array1.append(CGPoint(x:178.5, y:  28.0))
        array1.append(CGPoint(x:144.5, y:  104.5))
        array1.append(CGPoint(x:142.0, y:  196.0))
        array1.append(CGPoint(x:176.0, y:  343.0))
        array1.append(CGPoint(x:239.5, y:  291.5))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getP()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M991 1734q9 -4 79 -38l42 28q14 0 29 -12t13 -27l-30 -27q69 -64 118 -132t76 -146q16 -46 23 -116q-1 -46 -13 -143q-11 -55 -23 -84q-35 -61 -63 -90q-56 -48 -123 -55q-64 2 -119 30h1q-64 51 -80 118q-3 100 60 179q47 35 80 46l36 3q40 -15 20 -56q-29 -8 -90 -39q-33 -33 -41 -77q-3 -20 3 -57t48 -61q43 -17 79 -21q39 3 75 26q28 25 54 71q27 88 30 114q6 55 -1 131l-37 127q-25 51 -78 109q-42 46 -89 78q-4 -1 -48 -40q-16 -17 -58 -61q-53 -78 -64 -139q-34 -73 -34 -181v-202l15 -244l-5 -277l-20 -110q-11 -38 -40 -100q-25 -55 -59 -89l-71 -70l-89 -60l-110 -40q-36 -6 -70 -6t-70 6q-48 5 -107 30l-92 60l-70 80q-28 31 -45.5 106.5t-14.5 121.5q4 64 30 120q10 28 43 96l63 67q64 38 123 46q40 6 109 -10q51 -25 89 -59q27 -25 60 -90q14 -52 20 -119q-5 -42 -55 -36q-6 9 -20 97q-19 58 -51 91q-40 41 -116 58q-86 -6 -137 -45q-49 -67 -69 -120q-22 -58 -19 -131q9 -100 46 -156l71 -71q31 -21 105 -53q80 -20 142 -12q78 10 147 53q75 57 121 113l51 90l30 111l20 251l-20 421q1 73 9 147q7 65 26 125q28 88 64 140q49 71 112 125q-16 12 -61 35q-33 12 -74 29q-12 3 -76 13q-18 2 -61 7q-27 4 -71 0q-60 -5 -166 -20q-35 -8 -108 -50l-103 -58l-73 -65l-84 -118q-46 -81 -52 -158q-13 -66 -10 -132q4 -62 31 -111t72.5 -82t116.5 -44q74 -10 138 19q39 18 94 55q40 23 62 73q26 31 53 120q20 68 24 163l3 80q24 14 44 5q19 -9 25 -37q-6 -76 -29 -221q-15 -60 -47 -125q-26 -53 -72 -95q-42 -39 -107 -72l-73 -28l-85 -10q-62 2 -126 22q-58 25 -88 57q-104 111 -104 269q0 30 3 63q34 192 177 368q139 101 193 128q81 39 230 63q231 12 383 -56z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (190 - path.currentPoint.x), y: (100 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
    }
    
    class func getPPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:200.5,y: 104.5))
        array1.append(CGPoint(x:174.5,y: 230.5))
        array1.append(CGPoint(x:99.0,y: 247.0))
        array1.append(CGPoint(x:144.0,y: 224.0))
        array1.append(CGPoint(x:198.5,y: 149.0))
        array1.append(CGPoint(x:211.0,y: 180.0))
        array1.append(CGPoint(x:216.5,y: 129.5))
        array1.append(CGPoint(x:101.5,y: 127.0))
        array1.append(CGPoint(x:162.0,y: 136.0))
        pointArrays.append(array1)
        return pointArrays
    }

    class func getO()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M846 1769q78 -9 143 -39q74 -34 137 -85q34 -27 102 -106l77 -133q22 -51 57 -170l33 -176v-143l-11 -137q-7 -91 -35 -180l-67 -152q-31 -57 -97 -152l-96 -103l-120 -97q-39 -26 -133 -66q-47 -18 -126 -30q-98 4 -176 20q-42 9 -135 54q-82 45 -158 128q-57 63 -102 158l-59 126q-26 55 -51 164q-23 127 -20 180q-9 81 10 190q10 62 43 180q19 45 60 141l67 119l69 92q44 58 121 118q47 37 117 63q46 10 104 15l113 -13q28 15 44 20q38 13 89 14zM799 1690q-49 -17 -90 -50l-60 -80q-37 -122 -37 -179q0 -47 17 -139q37 -69 79 -94q34 -20 111 -28q56 15 65 20q19 9 61 44l48 75q29 -2 56 -23q-18 -65 -60 -116q-110 -76 -192 -76q-44 0 -98 16q-77 38 -109 91q-19 32 -51 139q-7 253 100 377q-38 8 -90 3l-100 -40l-70 -50l-141 -168l-79 -142l-41 -94q-38 -128 -38 -187q-12 -58 -1 -169l10 -103l29 -116l36 -100l45 -93l63 -112l97 -106q51 -41 122 -76l99 -27q42 -11 115 -8q61 3 95 17l96 40l77 50l73 50l70 70q28 38 93126l50 108q30 65 56 171l17 213l-3 126q-2 78 -34 229q-35 95 -86 181q-29 49 -103 115l-98 67l-99 38q-48 18 -100 10z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (190 - path.currentPoint.x), y: (100 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getOPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:210.5,y: 147.5))
        array1.append(CGPoint(x:168.0,y: 139.0))
        array1.append(CGPoint(x:238.0,y: 192.5))
        array1.append(CGPoint(x:179.5,y: 261.5))
        array1.append(CGPoint(x:113.5,y: 172.0))
        array1.append(CGPoint(x:175.0,y: 97.5))
        pointArrays.append(array1)
        return pointArrays
    }

    class func getN()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M1556 1810q50 11 140 -10q43 -21 80 -60q40 -54 50 -100q-2 -50 -30 -120q-23 -41 -70 -70l-100 -20q-33 -7 -50 10q-12 27 6 58q42 6 121 32q32 36 41 98q-23 65 -68 92q-56 27 -120 18q-66 -24 -111 -59q-94 -73 -158 -228q-118 -490 -179 -1087l-32 -124q-22 -54 -56 -142q-29 -49 -78 -98q-18 5 -34 25l-9 120v119l-12 155l-23 335l-32 287l-34 266l-18 113l-21 223l-45 -67q-20 -39 -52 -119q-62 -214 -146 -857l-15 -115l-25 -135q-53 -106 -72 -134q-36 -53 -106 -105q-148 -111 -280 -111q-111 21 -165 54q-66 39 -102 120q-40 96 -40 189q0 78 27 171q41 119 188 194q44 18 95 18q108 0 197 -78q73 -96 69 -247q-40 -17 -64 -2q-1 20 -5 65q-2 26 -22 85q-24 42 -24 43q-12 16 -36 34q-51 34 -113 34q-34 -5 -104 -31q-52 -42 -87 -92q-25 -49 -36 -111q-15 -84 -11 -131q6 -60 44 -125q23 -39 96 -88q79 -32 125 -32q88 9 171 74l82 64l66 89l37 83q35 146 42 334l40 301l58 312q12 75 60 203q29 77 102 194q64 102 95 101q17 -5 23 -60q9 -80 10 -85l20 -234l37 -243l43 -350l24 -345q0 -13 9.5 -137.5t9.5 -165.5q28 39 65 219q73 591 142 916q17 52 30 120l30 90q93 155 172 204q65 40 138 56z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (250 - path.currentPoint.x), y: (100 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getNPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:119.5,y: 233.5))
        array1.append(CGPoint(x:68.5,y: 238.0))
        array1.append(CGPoint(x:145.5,y: 178.0))
        array1.append(CGPoint(x:172.0,y: 105.5))
        array1.append(CGPoint(x:182.0,y: 176.5))
        array1.append(CGPoint(x:186.5,y: 269.0))
        array1.append(CGPoint(x:217.0,y: 147.5))
        array1.append(CGPoint(x:258.5,y: 134.5))
        pointArrays.append(array1)
        return pointArrays
    }

    
    class func getM() -> UIBezierPath {
        let cfURL = Bundle.main.url(forResource: "HLHOCTRO", withExtension: "TTF") as! CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        //        let font = UIFont(name: "HL hoctro", size: 64)!
        let font = UIFont(name: "HL hoctro", size: 64)!
        
        var unichars = [UniChar]("m".utf16)
        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
        CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
        let path = UIBezierPath(cgPath: cgpath)
        let trans = CGAffineTransform(scaleX: 6, y: -6)
        path.apply(trans)
        let translate = CGAffineTransform(translationX: 50, y: 200)
        path.apply(translate)
        return path
    }
    
    class func getMPoints() -> [[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:49.0, y:  102.0))
        array1.append(CGPoint(x:88.0, y:  77.0))
        array1.append(CGPoint(x:111.0, y:  194.0))
        array1.append(CGPoint(x:173.0, y:  75.5))
        array1.append(CGPoint(x:200.5, y:  194.0))
        array1.append(CGPoint(x:256.5, y:  75.0))
        array1.append(CGPoint(x:305.0, y:  193.5))
        array1.append(CGPoint(x:347.0, y:  148.5))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getTest() -> UIBezierPath {
        let cfURL = Bundle.main.url(forResource: "Monaco", withExtension: "dfont") as! CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        //        let font = UIFont(name: "HL hoctro", size: 64)!
        let font = UIFont(name: "Monaco", size: 64)!
        
        var unichars = [UniChar]("ă".utf16)
        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
        CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
        let path = UIBezierPath(cgPath: cgpath)
        let trans = CGAffineTransform(scaleX: 6, y: -6)
        path.apply(trans)
        let translate = CGAffineTransform(translationX: 50, y: 350)
        path.apply(translate)
        print(path)
        return path
    }
    
    class func getJ()-> UIBezierPath{
        let path = UIBezierPath(svgPath: "M1195 1681q91 21 124 53q27 26 48 26t26 -20q6 -23 3 -30q-2 -7 -27 -31l-5 -5q-55 -42 -146 -64q-57 -14 -180 -14q-65 0 -189 21q-13 -77 -13 -95l2 -102l7 -114l11 -114l7 -114l14 -159l17 -228q9 -122 -17 -258q-9 -47 -41 -156q-43 -75 -84 -110l-81 -69l-104 -58q-74 -41 -188 -41q-11 0 -18 1q-83 13 -134 37q-59 28 -105 66q-27 23 -73 89l-37 82q-17 59 -11 155q10 68 30 121q20 39 83 117q67 52 140 69q61 9 131 -4q61 -20 127 -84q18 -29 46 -102q17 -71 23 -126q-15 -14 -37 -19q-17 0 -41 41l-10 81q-7 28 -15 55q-11 30 -44 58q-78 35 -114 35q-11 0 -22 -1q-57 4 -127 -40q-46 -38 -78 -99q-23 -85 -21 -112q-12 -62 12 -147l42 -81q56 -60 128 -94q48 -23 113 -30q28 -3 91 11q60 14 91 29q2 1 105 66l87 87q42 64 62 146l20 121q0 14 1 47.5t1 54.5l-3 117l-9 110l-17 176q-4 53 -13 157q-17 152 -14 295q1 56 6 90l8 57q-33 6 -113 21q-57 17 -137 38l-95 20q-29 6 -54 6q-51 0 -110 -35q-44 -37 -80 -101q-28 -61 -21 -127q11 -49 51 -85q47 -42 143 -60q72 -14 146 34q32 20 50 51q13 24 38 30l53 -11q-2 -38 -62 -107q-67 -47 -141 -65q-73 -8 -140 10t-120 59.5t-80 130.5q-4 98 30 180q33 57 90 110q35 23 58 32q40 17 106 26q88 -10 164 -30q73 -20 201 -51q60 -10 160 -25t130 -13q68 -7 145 12z")
        let trans = CGAffineTransform.init(scaleX: 0.1, y: -0.1)
        path.apply(trans)
        let translation = CGAffineTransform(translationX: (250 - path.currentPoint.x), y: (100 - path.currentPoint.y) )
        path.apply(translation)
        print(path)
        return path
        
    }
    
    class func getJPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:191.5,y: 128.5))
        array1.append(CGPoint(x:144.5,y: 113.0))
        array1.append(CGPoint(x:190.0,y: 96.5))
        array1.append(CGPoint(x:268.0,y: 95.5))
        array1.append(CGPoint(x:211.0,y: 102.5))
        array1.append(CGPoint(x:204.5,y: 246.0))
        array1.append(CGPoint(x:133.0,y: 229.0))
        array1.append(CGPoint(x:185.5,y: 222.0))
        pointArrays.append(array1)
        return pointArrays
    }



}



