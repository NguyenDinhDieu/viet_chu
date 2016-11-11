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

        path = Alphabet.getS()
        originalPath = path
        let drawView = DrawView()
        drawView.pointArrays = Alphabet.getSPoints()

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
    var label = UILabel()
    
//    init() {
////        super.init()
////        super.init(coder: NSCoder)
//        label.text = "0,0"
//        label.adjustsFontSizeToFitWidth = true
//        //        label.font.pointSize = 40
//        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
//        self.addSubview(label)
//    }
    
    func addLabel() {
        label.text = "0,0"
        label.adjustsFontSizeToFitWidth = true
        //        label.font.pointSize = 40
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.addSubview(label)
    }
    
    
    
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
        label.text = lastPoint.debugDescription
        //        print(originalPath.getPathElementsPointsAndTypes())
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
        // display only 1 point each time
//        let point = points?.first
//        if point != nil {
//                            context!.move(to: point!)
//                            context!.addLine(to: point!)
//                            context!.strokePath()
//        }
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
//        let path = UIBezierPath(svgPath: "M168 85q-35 41 -56 86q-23 50 -30 83q-6 24 -14 77q-2 66 11 124q18 76 74 147q50 63 127 93q44 17 95 18q8 0 54 -2q118 -18 174 -115q-2 39 -4 92q-1 24 19 29q48 6 53 -16v-357v-126q0 -73 3 -83q21 -71 65 -69q44 5 95 91q14 23 55 106q7 18 23 52q17 5 27 3 q18 -5 27 -25l-33 -76q-36 -84 -79 -133q-61 -84 -123 -84q-50 0 -84 45q-18 24 -35 77q-14 -19 -24 -33q-16 -22 -45 -40q-17 -15 -64 -33q-22 -12 -75 -17q-50 -4 -75 1q-58 4 -107 41q-12 7 -54 44zM231 588q-60 -67 -87 -156q-11 -46 -9 -106q1 -35 22 -94 q28 -79 65 -104q12 -20 78 -52q60 -24 125 -5q49 14 99 53q39 37 57 82q8 14 22 93l2 135q0 -9 -2 -11q-21 0 -21 42q-2 53 -7 63q-36 65 -90 96q-32 19 -108 26q-90 -13 -146 -62z")
//        let trans = CGAffineTransform(scaleX: 0.25, y: -0.25)
//        path.apply(trans)
////        var translate = CGAffineTransform(translationX:(50 - path.currentPoint.x), y: (100 - path.currentPoint.y))
//        var translate = CGAffineTransform(translationX:(200 - path.currentPoint.x), y: (200 - path.currentPoint.y))
//        path.apply(translate)
//        print(path)
//        return path
        let cfURL = Bundle.main.url(forResource: "HLHOCTRO", withExtension: "TTF") as! CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        //        let font = UIFont(name: "HL hoctro", size: 64)!
        let font = UIFont(name: "HL hoctro", size: 64)!
        
        var unichars = [UniChar]("a".utf16)
        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
        CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
        let path = UIBezierPath(cgPath: cgpath)
        let trans = CGAffineTransform(scaleX: 8, y: -8)
        path.apply(trans)
        let translate = CGAffineTransform(translationX: 80, y: 300)
        path.apply(translate)
        return path
    }
    
    class func getAPoints() ->[[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:218.5, y: 147.5))
        array1.append(CGPoint(x:144.0, y: 140.0))
        array1.append(CGPoint(x:109.0, y: 234.0))
        array1.append(CGPoint(x:188.0, y: 292.0))
        array1.append(CGPoint(x:240.5, y: 218.5))
        array1.append(CGPoint(x:218.5, y: 147.5))
        pointArrays.append(array1)
        
        array1 = [CGPoint]()
        array1.append(CGPoint(x:240.0, y: 129.0))
        array1.append(CGPoint(x:264.0, y: 292.0))
        array1.append(CGPoint(x:313.5, y: 230.5))
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
        return getCharacter(character: "s", translation: CGPoint(x: 70, y: 250))
        
    }
    
    class func getSPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:74.5,y: 242.5))
        array1.append(CGPoint(x:123.5,y: 172.0))
        array1.append(CGPoint(x:150.5,y: 119.5))
        array1.append(CGPoint(x:131.5,y: 90.5))
        array1.append(CGPoint(x:185.0,y: 168.0))
        array1.append(CGPoint(x:156.0,y: 243.5))
        array1.append(CGPoint(x:117.0,y: 226.0))
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
    
    class func getDD() -> UIBezierPath {
        let path = self.getD()
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 169, y: 113))
        path1.addLine(to: CGPoint(x: 270, y: 113))
        path1.addQuadCurve(to: CGPoint(x: 270, y: 127), controlPoint: CGPoint(x: 273, y: 120))
        path1.addLine(to: CGPoint(x: 169, y: 127))
        path1.addQuadCurve(to: CGPoint(x: 169, y: 113), controlPoint: CGPoint(x: 166, y: 120))
        path.append(path1)
        return path
    }
    
    class func getDDPoints() -> [[CGPoint]] {
        var pointArrays = self.getDPoints()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x: 170, y: 120))
        array1.append(CGPoint(x: 269, y: 120))
        pointArrays.append(array1)
        return pointArrays
    }
        
    class func getR()-> UIBezierPath{
        return getCharacter(character: "r", translation: CGPoint(x: 70, y: 250))
        
    }
    
    class func getRPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:78.5,y: 244.5))
        array1.append(CGPoint(x:124.5,y: 124.0))
        array1.append(CGPoint(x:95.0,y: 97.5))
        array1.append(CGPoint(x:179.5,y: 138.5))
        array1.append(CGPoint(x:202.5,y: 242.5))
        array1.append(CGPoint(x:250.0,y: 193.0))
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
        return getCharacter(character: "q", translation: CGPoint(x: 70, y: 250))
        
    }
    
    class func getQPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:165.5,y: 128.0))
        array1.append(CGPoint(x:87.5,y: 183.0))
        array1.append(CGPoint(x:161.0,y: 239.5))
        array1.append(CGPoint(x:186.5,y: 179.0))
        array1.append(CGPoint(x:175.0,y: 136.5))
        array1.append(CGPoint(x:189.0,y: 121.0))
        array1.append(CGPoint(x:189.0,y: 254.5))
        array1.append(CGPoint(x:188.5,y: 375.5))
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
        return getCharacter(character: "p", translation: CGPoint(x: 70, y: 250))
    }
    
    class func getPPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:77.0,y: 177.0))
        array1.append(CGPoint(x:107.5,y: 126.5))
        array1.append(CGPoint(x:108.5,y: 243.0))
        array1.append(CGPoint(x:108.0,y: 375.0))
        array1.append(CGPoint(x:118.5,y: 168.0))
        array1.append(CGPoint(x:167.5,y: 121.5))
        array1.append(CGPoint(x:213.5,y: 241.5))
        array1.append(CGPoint(x:267.0,y: 193.0))
        pointArrays.append(array1)
        return pointArrays
    }

    class func getO()-> UIBezierPath{
        
        
        let cfURL = Bundle.main.url(forResource: "HLHOCTRO", withExtension: "TTF") as! CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        let font = UIFont(name: "HL hoctro", size: 64)!
        
        var unichars = [UniChar]("o".utf16)
        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
        CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
        let path = UIBezierPath(cgPath: cgpath)
        let trans = CGAffineTransform(scaleX: 8, y: -8)
        path.apply(trans)
        let translate = CGAffineTransform(translationX: 100, y: 300)
        path.apply(translate)
        return path
        
    }
    
    class func getOPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:225.5,y: 153.5))
        array1.append(CGPoint(x:165.5,y: 128.0))
        array1.append(CGPoint(x:108.5,y: 207.0))
        array1.append(CGPoint(x:169.5,y: 292.0))
        array1.append(CGPoint(x:233.5,y: 165.5))
        pointArrays.append(array1)
        return pointArrays
    }

    class func getN()-> UIBezierPath{
        return getCharacter(character: "n", translation: CGPoint(x: 70, y: 300))
    }
    
    class func getNPoints()->[[CGPoint]]{
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:68.5,y: 196.0))
        array1.append(CGPoint(x:112.5,y: 170.5))
        array1.append(CGPoint(x:126.0,y: 244.5))
        array1.append(CGPoint(x:124.5,y: 292.5))
        array1.append(CGPoint(x:182.0,y: 172.5))
        array1.append(CGPoint(x:224.5,y: 287.0))
        array1.append(CGPoint(x:281.0,y: 239.0))
        pointArrays.append(array1)
        return pointArrays
    }
    
    class func getCharacter(character: String, translation: CGPoint) -> UIBezierPath {
        let cfURL = Bundle.main.url(forResource: "HLHOCTRO", withExtension: "TTF") as! CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        let font = UIFont(name: "HL hoctro", size: 64)!
        
        var unichars = [UniChar](character.utf16)
        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
        CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
        let path = UIBezierPath(cgPath: cgpath)
        let trans = CGAffineTransform(scaleX: 6, y: -6)
        path.apply(trans)
        let translate = CGAffineTransform(translationX: translation.x, y: translation.y)
        path.apply(translate)
        return path
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
        let cfURL = Bundle.main.url(forResource: "HLHOCTRO", withExtension: "TTF") as! CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        //        let font = UIFont(name: "HL hoctro", size: 64)!
        let font = UIFont(name: "HL hoctro", size: 64)!
        
        var unichars = [UniChar]("d".utf16)
        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
        CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
        let path = UIBezierPath(cgPath: cgpath)
        let trans = CGAffineTransform(scaleX: 6, y: -6)
        path.apply(trans)
        let translate = CGAffineTransform(translationX: 50, y: 350)
        path.apply(translate)
        print(path)
//        let path1 = UIBezierPath()
//        path1.move(to: CGPoint(x: 134, y:55.8125))
//        path1.addQuadCurve(to: CGPoint(x: 144.875, y:81.21875), controlPoint: CGPoint(x: 135.6875, y:70.25))
//        path1.addQuadCurve(to:  CGPoint(x: 165.5, y:92.1875), controlPoint: CGPoint(x: 154.0625, y:92.1875))
//        path1.addQuadCurve(to:  CGPoint(x: 185.9375, y:81.03125), controlPoint: CGPoint(x: 176.9375, y:92.1875))
//        path1.addQuadCurve(to:  CGPoint(x: 196.625, y:55.8125), controlPoint: CGPoint(x: 194.9375, y:69.875))
//        path1.addLine(to: CGPoint(x: 220.625, y:55.8125))
//        path1.addQuadCurve(to:  CGPoint(x: 210.03125, y:89.46875), controlPoint: CGPoint(x: 218.375, y:76.625))
//        path1.addQuadCurve(to:  CGPoint(x: 189.875, y:109.625), controlPoint: CGPoint(x: 201.6875, y:102.3125))
//        path1.addQuadCurve(to:  CGPoint(x: 165.5, y:116.9375), controlPoint: CGPoint(x: 178.0625, y:116.9375))
//        path1.addQuadCurve(to:  CGPoint(x: 141.03125, y:109.625), controlPoint: CGPoint(x: 152.9375, y:116.9375))
//        path1.addQuadCurve(to:  CGPoint(x: 120.78125, y:89.46875), controlPoint: CGPoint(x: 129.125, y:102.3125))
//        path1.addQuadCurve(to:  CGPoint(x: 110, y:55.8125), controlPoint: CGPoint(x: 112.4375, y:76.625))
//        path1.close()
        return path
    }
    
    class func getDauAw() -> UIBezierPath {
        let path1 = UIBezierPath()
        let startPoint = CGPoint(x: 134, y:55.8125)
        path1.move(to: startPoint)
        path1.addQuadCurve(to: CGPoint(x: 144.875, y:81.21875), controlPoint: CGPoint(x: 135.6875, y:70.25))
        path1.addQuadCurve(to:  CGPoint(x: 165.5, y:92.1875), controlPoint: CGPoint(x: 154.0625, y:92.1875))
        path1.addQuadCurve(to:  CGPoint(x: 185.9375, y:81.03125), controlPoint: CGPoint(x: 176.9375, y:92.1875))
        path1.addQuadCurve(to:  CGPoint(x: 196.625, y:55.8125), controlPoint: CGPoint(x: 194.9375, y:69.875))
        path1.addLine(to: CGPoint(x: 220.625, y:55.8125))
        path1.addQuadCurve(to:  CGPoint(x: 210.03125, y:89.46875), controlPoint: CGPoint(x: 218.375, y:76.625))
        path1.addQuadCurve(to:  CGPoint(x: 189.875, y:109.625), controlPoint: CGPoint(x: 201.6875, y:102.3125))
        path1.addQuadCurve(to:  CGPoint(x: 165.5, y:116.9375), controlPoint: CGPoint(x: 178.0625, y:116.9375))
        path1.addQuadCurve(to:  CGPoint(x: 141.03125, y:109.625), controlPoint: CGPoint(x: 152.9375, y:116.9375))
        path1.addQuadCurve(to:  CGPoint(x: 120.78125, y:89.46875), controlPoint: CGPoint(x: 129.125, y:102.3125))
        path1.addQuadCurve(to:  CGPoint(x: 110, y:55.8125), controlPoint: CGPoint(x: 112.4375, y:76.625))
        path1.close()
        let trans = CGAffineTransform(scaleX: 0.8, y: 0.8)
        path1.apply(trans)
        let translate = CGAffineTransform(translationX: 50, y: 10)
        path1.apply(translate)
        return path1
    }
    
    class func getDauAwPoints() -> [CGPoint] {
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:149.5, y: 63.0))
        array1.append(CGPoint(x:183.0, y: 94.0))
        array1.append(CGPoint(x:216.0, y: 63.5))
        return array1
    }
    
    class func getAw() -> UIBezierPath {
        let path = self.getA()
        let path1 = self.getDauAw()
        path.append(path1)
        return path
    }
    
    class func getAwPoints() -> [[CGPoint]] {
        var pointArrays = self.getAPoints()
        pointArrays.append(self.getDauAwPoints())
        return pointArrays
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
    
    class func getOO() -> UIBezierPath{
        let path = self.getO()
        let path1 = self.getDauMu()
        path.append(path1)
        return path
    }
    
    class func getOOPoints() -> [[CGPoint]]{
        var array1 = self.getOPoints()
        array1.append(self.getDauMuPoints())
        return array1
    }
    
    class func getDauMu() -> UIBezierPath{
        let path = UIBezierPath()
        let startPoint = CGPoint(x: 111.0, y: 110.0)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x:155.5,y: 50.0))
        path.addLine(to: CGPoint(x:178.5,y: 50.5))
        path.addLine(to: CGPoint(x:220.5,y: 110.0))
        path.addLine(to: CGPoint(x:191.0,y: 111.0))
        path.addLine(to: CGPoint(x:167.5,y: 80.5))
        path.addLine(to: CGPoint(x:141.0,y: 110.5))
        path.close()
        let trans = CGAffineTransform(scaleX: 0.8, y: 0.8)
        path.apply(trans)
        let translate = CGAffineTransform(translationX: 50, y: 10)
        path.apply(translate)

        return path
    }
    
    class func getDauMuPoints() -> [CGPoint]{
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:152.0,y: 94.5))
        array1.append(CGPoint(x:183.0,y: 58.5))
        array1.append(CGPoint(x:212.5,y: 92.0))
        return array1
    }

}



