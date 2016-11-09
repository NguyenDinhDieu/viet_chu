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
        var pointArray = [CGPoint]()
        pointArray.append(CGPoint(x: 170, y: 26.5 ))
        pointArray.append(CGPoint(x: 125.5, y: 18.5 ))
        pointArray.append(CGPoint(x: 91.0, y: 57.5 ))
        pointArray.append(CGPoint(x: 101.5, y: 105.5 ))
        pointArray.append(CGPoint(x: 155.5, y: 124.5 ))
        pointArray.append(CGPoint(x: 188.0, y: 98.0 ))
        //        view.backgroundColor = .black
        //        let miniView = UIView(frame: CGRect(x: 0, y:0, width: 300, height: 300))
        //        miniView.center = self.view.center
        //        self.view.addSubview(miniView)
        //
        //        let url = Bundle.main.url(forResource: "BezierCurve", withExtension: "svg")!
        //
        //        //initialise a view that parses and renders an SVG file in the bundle:
        //        let svgImageView = SVGImageView.init(contentsOf: url)
        //
        //
        //        //scale the resulting image to fit the frame of the view, but
        //        //maintain its aspect ratio:
        ////        svgImageView.contentMode = .scaleAspectFit
        //
        //
        //        //layout the view:
        //        svgImageView.translatesAutoresizingMaskIntoConstraints = false
        //        let touch = UITapGestureRecognizer(target: self, action: #selector(self.todo))
        //        svgImageView.addGestureRecognizer(touch)
        //        svgImageView.isUserInteractionEnabled = true
        //        svgImageView.center = self.view.center
        //        self.view.isUserInteractionEnabled = true
        //        svgImageView.layer.backgroundColor = UIColor.red.cgColor
        //        miniView.addSubview(svgImageView)
        //
        //        svgImageView.topAnchor.constraint(equalTo: miniView.topAnchor).isActive = true
        //        svgImageView.leftAnchor.constraint(equalTo: miniView.leftAnchor).isActive = true
        //        svgImageView.rightAnchor.constraint(equalTo: miniView.rightAnchor).isActive = true
        //        svgImageView.bottomAnchor.constraint(equalTo: miniView.bottomAnchor).isActive = true
        //        var path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 300, height: 300))
        ////        path.move(to: CGPoint(x: 100, y: 100))
        ////        path = path.reversing()
        //        path.close()
        //        let layer = CAShapeLayer()
        //        layer.path = path.cgPath
        //        layer.fillColor = UIColor.red.cgColor
        ////        miniView.layer.addSublayer(layer)
        //        miniView.layer.mask = layer
        //
        ////        let image = UIImage()
        ////        image.
//        let cfURL = Bundle.main.url(forResource: "HL-HOCTRO", withExtension: "TTF") as! CFURL
//        
//        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        //let font = UIFont(name: "ProximaNova-Semibold", size:  14.0)
        
//        let font = UIFont(name: "HL-hoctro", size: 64)!
//        
//        var unichars = [UniChar]("c".utf16)
//        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
//        let gotGlyphs = CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
//        if gotGlyphs {
//            let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
//            path = UIBezierPath(cgPath: cgpath) //            path = UIBezierPath(svgPath: "M168 85q-35 41 -56 86q-23 50 -30 83q-6 24 -14 77q-2 66 11 124q18 76 74 147q50 63 127 93q44 17 95 18q8 0 54 -2q118 -18 174 -115q-2 39 -4 92q-1 24 19 29q48 6 53 -16v-357v-126q0 -73 3 -83q21 -71 65 -69q44 5 95 91q14 23 55 106q7 18 23 52q17 5 27 3 q18 -5 27 -25l-33 -76q-36 -84 -79 -133q-61 -84 -123 -84q-50 0 -84 45q-18 24 -35 77q-14 -19 -24 -33q-16 -22 -45 -40q-17 -15 -64 -33q-22 -12 -75 -17q-50 -4 -75 1q-58 4 -107 41q-12 7 -54 44")   //            path = UIBezierPath(svgPath: "M48 6v-357v-126q0 -73 3 -83q21 -71 65 -69q44 5 95 91q14 23 55 106q7 18 23 52q17 5 27 3 q18 -5 27 -25l-33 -76q-36 -84 -79 -133q-61 -84 -123 -84q-50 0 -84 45q-18 24 -35 77q-14 -19 -24 -33q-16 -22 -45 -40") //            path = UIBezierPath(svgPath: "M48 6 l0 -483") // //            var path2 = UIBezierPath(svgPath: "M18 -5l-33 -76q-36 -84 -79 -133q-61 -84 -123 -84q-50 0 -84 45") // // //            let trans1 = CGAffineTransform(translationX: path.currentPoint.x - path2.currentPoint.x , y: path.currentPoint.y - path2.currentPoint.y) //            path2 = path2.reversing() //                        path2.apply(trans1) //            //            path.append(path2) // //            path.append(path2)  // -----chu a--------------------- //            path = UIBezierPath() //            path.move(to: CGPoint(x: 186.60000000000002, y:52.600000000000023)) //            path.addQuadCurve(to: CGPoint(x: 169.20000000000002, y:41.100000000000009), controlPoint: CGPoint(x: 181, y:42.90000000000002)) //            path.addQuadCurve(to: CGPoint(x: 163.80000000000001, y:40.90000000000002), controlPoint: CGPoint(x: 164.60000000000002, y:40.90000000000002)) //            path.addQuadCurve(to: CGPoint(x: 154.30000000000001, y:42.700000000000017), controlPoint: CGPoint(x: 158.70000000000002, y:41.000000000000014)) //            path.addQuadCurve(to: CGPoint(x: 141.60000000000002, y:52.000000000000014), controlPoint: CGPoint(x: 146.60000000000002, y:45.700000000000017)) //            path.addQuadCurve(to: CGPoint(x: 134.20000000000002, y:66.700000000000017), controlPoint: CGPoint(x: 136, y:59.100000000000023)) //            path.addQuadCurve(to: CGPoint(x: 133.10000000000002, y:79.100000000000023), controlPoint: CGPoint(x: 132.90000000000001, y:72.500000000000014)) //            path.addQuadCurve(to: CGPoint(x: 134.5, y:86.800000000000011), controlPoint: CGPoint(x: 133.90000000000001, y:84.400000000000006)) //            path.addQuadCurve(to: CGPoint(x: 137.5, y:95.100000000000023), controlPoint: CGPoint(x: 135.20000000000002, y:90.100000000000023)) //            path.addQuadCurve(to: CGPoint(x: 143.10000000000002, y:103.70000000000002), controlPoint: CGPoint(x: 139.60000000000002, y:99.600000000000023)) //            path.move(to: CGPoint(x: 143.10000000000002, y:103.70000000000002)) //            path.addQuadCurve(to: CGPoint(x: 148.5, y:108.10000000000002), controlPoint: CGPoint(x: 147.30000000000001, y:107.40000000000003)) //            path.addQuadCurve(to: CGPoint(x: 159.20000000000002, y:112.20000000000002), controlPoint: CGPoint(x: 153.40000000000001, y:111.80000000000001)) //            path.addQuadCurve(to: CGPoint(x: 166.70000000000002, y:112.30000000000001), controlPoint: CGPoint(x: 161.70000000000002, y:112.70000000000002)) //            path.addQuadCurve(to: CGPoint(x: 174.20000000000002, y:110.60000000000002), controlPoint: CGPoint(x: 172, y:111.80000000000001)) //            path.addQuadCurve(to: CGPoint(x: 180.60000000000002, y:107.30000000000001), controlPoint: CGPoint(x: 178.90000000000001, y:108.80000000000001)) //            path.addQuadCurve(to: CGPoint(x: 185.10000000000002, y:103.30000000000001), controlPoint: CGPoint(x: 183.5, y:105.5)) //            path.addQuadCurve(to: CGPoint(x: 187.5, y:100), controlPoint: CGPoint(x: 186.10000000000002, y:101.90000000000003)) //            path.move(to: CGPoint(x: 186, y: 112.2)) // //            var path2 = UIBezierPath() //            path2.move(to: CGPoint(x: 155.60000000000002, y:76.5)) // //            path2.addLine(to: CGPoint(x: 155.60000000000002, y: 124.8)) //            path2.addQuadCurve(to: CGPoint(x: 164, y:129.30000000000001), controlPoint: CGPoint(x: 159, y:129.30000000000001)) //            path2.addQuadCurve(to: CGPoint(x: 176.30000000000001, y:120.90000000000001), controlPoint: CGPoint(x: 170.20000000000002, y:129.30000000000001)) //            path2.addQuadCurve(to: CGPoint(x: 184.20000000000002, y:107.59999999999999), controlPoint: CGPoint(x: 180.60000000000002, y:116)) //            path2.addLine(to: CGPoint(x: 187.5, y:100)) // //            let trans1 = CGAffineTransform(translationX: path.currentPoint.x - 155.6 , y: path.currentPoint.y - 112.2) ////                        path2 = path2.reversing() //                                    path2.apply(trans1) //                        //            path.append(path2) // //                        path.append(path2) // --------end chu a------------------------- //            path = path2  //            var path = UIBezierPath() //            path.move(to: CGPoint(x: 187.5, y: 100)) //            path.addQuadCurve(to: CGPoint(x: 170.09999999999999, y: 88.499999999999986), controlPoint: CGPoint(x: 181.89999999999998, y: 90.299999999999997)) //            path.addQuadCurve(to: CGPoint(x: 164.69999999999999, y: 88.299999999999997), controlPoint: CGPoint(x: 165.5, y: 88.299999999999997)) //            path.addQuadCurve(to: CGPoint(x: 155.19999999999999, y: 90.099999999999994), controlPoint: CGPoint(x: 159.59999999999999, y: 88.399999999999991)) //            path.addQuadCurve(to: CGPoint(x: 142.5, y: 99.399999999999991), controlPoint: CGPoint(x: 147.5, y: 93.099999999999994)) //            path.addQuadCurve(to: CGPoint(x: 135.09999999999999, y: 114.09999999999999), controlPoint: CGPoint(x: 136.89999999999998, y: 106.5)) //            path.addQuadCurve(to: CGPoint(x: 134, y: 126.5), controlPoint: CGPoint(x: 133.79999999999998, y: 119.89999999999999)) //            path.addQuadCurve(to: CGPoint(x: 135.39999999999998, y: 134.19999999999999), controlPoint: CGPoint(x: 134.79999999999998, y: 131.79999999999998)) //            path.addQuadCurve(to: CGPoint(x: 138.39999999999998, y: 142.5), controlPoint: CGPoint(x: 136.09999999999999, y: 137.5)) //            path.addQuadCurve(to: CGPoint(x: 144, y: 151.09999999999999), controlPoint: CGPoint(x: 140.5, y: 147))  //            var path2 = UIBezierPath() //                path2.move(to: CGPoint(x: 143.10000000000002, y: 103.7)) //                path2.addQuadCurve(to: CGPoint(x: 148.5, y: 108.10000000000001), controlPoint: CGPoint(x: 147.30000000000001, y: 107.40000000000001)) //                path2.addQuadCurve(to: CGPoint(x: 159.20000000000002, y: 112.2), controlPoint: CGPoint(x: 153.40000000000001, y: 111.80000000000001)) //                path2.addQuadCurve(to: CGPoint(x: 166.70000000000002, y: 112.30000000000001), controlPoint: CGPoint(x: 161.70000000000002, y: 112.7)) //                path2.addQuadCurve(to: CGPoint(x: 174.20000000000002, y: 110.60000000000001), controlPoint: CGPoint(x: 172, y: 111.80000000000001)) //                path2.addQuadCurve(to: CGPoint(x: 180.60000000000002, y: 107.30000000000001), controlPoint: CGPoint(x: 178.90000000000001, y: 108.80000000000001)) //                path2.addQuadCurve(to: CGPoint(x: 185.10000000000002, y: 103.30000000000001), controlPoint: CGPoint(x: 183.5, y: 105.5)) //                path2.addQuadCurve(to: CGPoint(x: 187.5, y: 100), controlPoint: CGPoint(x: 186.10000000000002, y: 101.90000000000001)) //            let trans1 = CGAffineTransform(translationX: path.currentPoint.x - 143.10000000000002 , y: path.currentPoint.y - 103.7) //            path2.apply(trans1) //            path.append(path2)
         //            path.addQuadCurve(to: CGPoint(x:119.03125, y:482.09375), controlPoint: CGPoint(x:118.875, y:481.125)) //             path.addQuadCurve(to:  CGPoint(x:119.03125, y:482.09375), controlPoint: CGPoint(x:118.875, y:481.125)) //            path.addQuadCurve(to:  CGPoint(x:117.34375, y:482.90625), controlPoint: CGPoint(x:118.78125, y:483.0625)) //            path.addQuadCurve(to:  CGPoint(x:116.09375, y:481.53125), controlPoint: CGPoint(x:116.84375, y:482.3125)) //            path.addQuadCurve(to:  CGPoint(x:114.59375, y:480.546875), controlPoint: CGPoint(x:115.84375, y:481.21875)) //            path.addQuadCurve(to:  CGPoint(x:111.65625, y:480.03125), controlPoint: CGPoint(x:113.34375, y:479.875)) //            path.addQuadCurve(to:  CGPoint(x:108.625, y:480.90625), controlPoint: CGPoint(x:110.4375, y:480.125)) //            path.addQuadCurve(to:  CGPoint(x:106.0625, y:482.8125), controlPoint: CGPoint(x:107.1875, y:481.53125)) //            path.addQuadCurve(to:  CGPoint(x:104.46875, y:485.21875), controlPoint: CGPoint(x:104.84375, y:484.25)) //            path.addQuadCurve(to:  CGPoint(x:103.84375, y:488.75), controlPoint: CGPoint(x:103.875, y:487.34375)) //            path.addQuadCurve(to:  CGPoint(x:104.375, y:491.78125), controlPoint: CGPoint(x:103.8125, y:489.6875)) //            path.addQuadCurve(to:  CGPoint(x:105.90625, y:494.59375), controlPoint: CGPoint(x:105.03125, y:493.46875)) //            path.addQuadCurve(to:  CGPoint(x:108.25, y:497), controlPoint: CGPoint(x:107.15625, y:496.1875)) //            path.addQuadCurve(to:  CGPoint(x:112, y:497.96875), controlPoint: CGPoint(x:110.4375, y:498.0625)) //            path.addQuadCurve(to:  CGPoint(x:116.90625, y:496.5), controlPoint: CGPoint(x:115.1875, y:497.78125)) //            path.addQuadCurve(to:  CGPoint(x:119.21875, y:494.3125), controlPoint: CGPoint(x:118.5, y:495.28125)) //            path.addQuadCurve(to:  CGPoint(x:120.46875, y:492.71875), controlPoint: CGPoint(x:119.59375, y:493.71875)) //            path.addQuadCurve(to:  CGPoint(x:121.78125, y:493.5), controlPoint: CGPoint(x:121.09375, y:492.90625)) //            path.addQuadCurve(to:  CGPoint(x:121.28125, y:494.78125), controlPoint: CGPoint(x:121.78125, y:493.84375)) //            path.addQuadCurve(to:  CGPoint(x:117.84375, y:498.375), controlPoint: CGPoint(x:120.0625, y:497.09375)) //            path.addQuadCurve(to:  CGPoint(x:111.5625, y:500), controlPoint: CGPoint(x:115, y:500)) //            path.addQuadCurve(to:  CGPoint(x:103.75, y:495.21875), controlPoint: CGPoint(x:107, y:500)) //            path.addQuadCurve(to:  CGPoint(x:101.75, y:488.09375), controlPoint: /) //            path.addQuadCurve(to:  CGPoint(x:105.40625, y:480.5), controlPoint: CGPoint(x:101.75, y:483.90625)) //            path.addQuadCurve(to:  CGPoint(x:108.40625, y:478.640625), controlPoint: CGPoint(x:106.53125, y:479.4375)) //            path.addQuadCurve(to:  CGPoint(x:111.5625, y:477.8125), controlPoint: CGPoint(x:110.28125, y:477.84375)) //            path.addQuadCurve(to:  CGPoint(x:115, y:478.375), controlPoint: CGPoint(x:113.71875, y:477.78125)) //            path.addQuadCurve(to:  CGPoint(x:117.8125, y:480), controlPoint: CGPoint(x:116.125, y:478.75))
         //            let oo = CGRect(x: 10, y: 10, width: 100, height: 100)   //            path.close()    //            let path = UIBezierPath(svgPath: "M1645 3700 c-281 -44 -557 -218 -766 -485 -280 -357 -424 -872 -380 -1360 30 -329 142 -673 294 -900 84 -126 104 -151 185 -234 128 -129 266 -226 404 -284 174 -73 293 -97 483 -97 410 0 723 160 1022 522 161 195 333 503 333 595 0 48 -37 83 -88 83 -54 0 -75 -21 -112 -111 -66 -163 -216 -388 -358 -539 -155 -165 -318 -271 -499 -327 -83 -25 -100 -27 -288 -27 -179 -1 -208 1 -278 22 -110 31 -191 67 -272 119 -207 134 -347 298 -465 547 -122 257 -179 509 -180 796 0 235 24 384 96 600 88 260 185 421 359 596 218 219 413 306 685 307 254 0 452 -82 654 -273 86 -81 89 -82 129 -77 72 10 106 74 76 140 -6 14 -22 31 -36 38 -14 7 -35 25 -47 39 -88 103 -275 217 -441 271 -138 45 -362 62 -510 39z") //            path.move(to: path.currentPoint) //            let path = UIBezierPath() //            C92.91,49.489999999999995,95.08,49.75,96.88,50 //            path.move(to: CGPoint(x: 11, y: 54.75)) //            path.addCurve(to: CGPoint(x: 20.73, y: 54.75), controlPoint1: CGPoint(x: 14.19, y: 54.87), controlPoint2: CGPoint(x: 17.25, y: 56)) //            path.addCurve(to: CGPoint(x: 89.31, y: 49.51), controlPoint1: CGPoint(x: 41.37, y: 53.25), controlPoint2: CGPoint(x: 71.12, y: 49.63)) //            path.addCurve(to: CGPoint(x: 96.88, y: 50) , controlPoint1: CGPoint(x: 92.91, y: 49.49), controlPoint2: CGPoint(x: 95.08, y: 49.75) ) //            path.move(to: CGPoint(x: 96.88, y: 50)) ////            path.addLine(to: CGPoint(x: 14.19, y: 54.87)) ////            path.addLine(to: CGPoint(x: 17.25, y: 55)) ////            path.addLine(to: CGPoint(x: 20.73, y: 54.75)) ////            path.addLine(to: CGPoint(x: 41.37, y: 53.25)) ////            path.addLine(to: CGPoint(x: 71.12, y: 49.63)) ////            path.addLine(to: CGPoint(x: 89.31, y: 49.51)) ////            path.addLine(to: CGPoint(x: 92.91, y: 49.49)) ////            path.addLine(to: CGPoint(x: 95.08, y: 49.75)) ////            path.addLine(to: CGPoint(x: 96.88, y: 50)) ////            path.addLine(to: <#T##CGPoint#>) ////            path.addLine(to: <#T##CGPoint#>) ////            path.addLine(to: <#T##CGPoint#>) ////            path.addLine(to: <#T##CGPoint#>) ////            path.addLine(to: <#T##CGPoint#>) ////            path.addLine(to: <#T##CGPoint#>) ////            path.addLine(to: <#T##CGPoint#>) //            path.close() //            path.lineWidth = 5 //            let trans = CGAffineTransform(scaleX: 0.1, y: -0.1)
         
//        path = Alphabet.getC()
        //        print(path.cgPath.getPathElementsPoints())
        path = Alphabet.getA()

//        let trans = CGAffineTransform(scaleX: 5, y: 5)
//        path.apply(trans)
//        //            path.flatness = 0.6
//        var transform = CGAffineTransform(translationX:(50 - path.currentPoint.x), y: (100 - path.currentPoint.y))
//        //            transform = transform.scaledBy(x: 5, y: 5)
//        path.apply(transform)
        // Create a CAShapeLayer
        
        
        
        // The Bezier path that we made needs to be converted to
        // a CGPath before it can be used on a layer.
        shapeLayer.path = path.cgPath
        shapeLayer.backgroundColor = UIColor.white.cgColor
        
        // apply other properties related to the path
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
//        shapeLayer.lineDashPattern = [7, 7]
        shapeLayer.lineWidth = 20.0
        shapeLayer.lineCap = "round"
        //            shapeLayer.position = CGPoint(x: 0, y: 0)
        
        // add the new layer to our custom view
        //            self.view.layer.addSublayer(shapeLayer)
        //            path = path.reversing()
        print(path)
        
        // create a new CAKeyframeAnimation that animates the objects position
        let anim = CAKeyframeAnimation(keyPath: "position")
        
        // set the animations path to our bezier curve
        anim.path = path.cgPath
        
        // set some more parameters for the animation
        // this rotation mode means that our object will rotate so that it's parallel to whatever point it is currently on the curve
        anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = 1
        anim.duration = 5.0
        
        
        square.frame = CGRect(x: 300, y: 500, width: 5, height: 5)
        square.backgroundColor = UIColor.red
        square.center = self.view.center
        view1.addSubview(square)
        
        
        
        //            view1.layer.mask = CALayer(layer: shapeLayer)
        view1.frame = self.view.frame
        //            view1.frame
        view1.backgroundColor = UIColor.white
        view1.layer.addSublayer(shapeLayer)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drawW))
        view1.isUserInteractionEnabled = true
        view1.addGestureRecognizer(panGesture)
        self.view.addSubview(view1)
        self.view.backgroundColor = UIColor.white
        
        // we add the animation to the squares 'layer' property
        square.layer.add(anim, forKey: "animate position along path")
        //            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        
        
        originalPath = path
        let drawView = DrawView()
        drawView.pointArrays = Alphabet.getAPoints()
        drawView.backgroundColor = UIColor.white
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
        tmpPath = UIBezierPath() //            tmpShape = CAShapeLayer() //            tmpShape.backgroundColor = UIColor.green.cgColor // //            // apply other properties related to the path //            tmpShape.strokeColor = UIColor.black.cgColor //            tmpShape.fillColor = UIColor.white.cgColor //            tmpShape.lineDashPattern = [7, 7] ////            tmpShape.opacity = 1 // //            tmpShape.lineWidth = 2.0 //            tmpShape.lineCap = "round" //            view1.layer.addSublayer(tmpShape) drawPath.move(to: point) path.move(to: point)
        }
        
        if sender.state == .changed {
            let point = sender.location(in: self.view1)
            drawPath.addLine(to: point)
            path.addLine(to: point)
            shapeLayer.path = path.cgPath
            //            tmpShape.path = tmpPath.cgPath
        }
        
        if sender.state == .ended { //            pathArray.append(tmpPath) //            drawPath.stroke() //            print(tmpPath.cgPath)
        }
        
        
        //        print(point)
        //        draw(<#T##sender: UITapGestureRecognizer##UITapGestureRecognizer#>)
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
        print(lastPoint)
        //        print(originalPath.getPathElementsPointsAndTypes())
        
        
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
        context!.setLineDash(phase: 1, lengths: [])
        context!.setStrokeColor(UIColor.yellow.cgColor)
        for points in pointArrays {
            for point in points {
                context!.move(to: point)
                context!.addLine(to: point)
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
    
    class func getC() -> UIBezierPath {
        
//        pointArray.append(CGPoint(x: 170, y: 26.5 ))
//        pointArray.append(CGPoint(x: 125.5, y: 18.5 ))
//        pointArray.append(CGPoint(x: 91.0, y: 57.5 ))
//        pointArray.append(CGPoint(x: 101.5, y: 105.5 ))
//        pointArray.append(CGPoint(x: 155.5, y: 124.5 ))
//        pointArray.append(CGPoint(x: 188.0, y: 98.0 ))
        let path = UIBezierPath()
        path.move(to:  CGPoint(x:117.8125, y:480))
        path.addQuadCurve(to:  CGPoint(x:115, y:478.375), controlPoint: CGPoint(x:116.125, y:478.75))
        path.addQuadCurve(to:  CGPoint(x:111.5625, y:477.8125), controlPoint: CGPoint(x:113.71875, y:477.78125))
        path.addQuadCurve(to:  CGPoint(x:108.40625, y:478.640625), controlPoint: CGPoint(x:110.28125, y:477.84375))
        path.addQuadCurve(to:  CGPoint(x:105.40625, y:480.5), controlPoint: CGPoint(x:106.53125, y:479.4375))
        path.addQuadCurve(to:  CGPoint(x:101.75, y:488.09375), controlPoint: CGPoint(x:101.75, y:483.90625))
        path.addQuadCurve(to:  CGPoint(x:103.75, y:495.21875), controlPoint: CGPoint(x:101.75, y:492.28125))
        path.addQuadCurve(to:  CGPoint(x:111.5625, y:500), controlPoint: CGPoint(x:107, y:500))
        path.addQuadCurve(to:  CGPoint(x:117.84375, y:498.375), controlPoint: CGPoint(x:115, y:500))
        path.addQuadCurve(to:  CGPoint(x:121.28125, y:494.78125), controlPoint: CGPoint(x:120.0625, y:497.09375))
        return path
    }
    
    class func getA() -> UIBezierPath {
        let path = UIBezierPath(svgPath: "M168 85q-35 41 -56 86q-23 50 -30 83q-6 24 -14 77q-2 66 11 124q18 76 74 147q50 63 127 93q44 17 95 18q8 0 54 -2q118 -18 174 -115q-2 39 -4 92q-1 24 19 29q48 6 53 -16v-357v-126q0 -73 3 -83q21 -71 65 -69q44 5 95 91q14 23 55 106q7 18 23 52q17 5 27 3 q18 -5 27 -25l-33 -76q-36 -84 -79 -133q-61 -84 -123 -84q-50 0 -84 45q-18 24 -35 77q-14 -19 -24 -33q-16 -22 -45 -40q-17 -15 -64 -33q-22 -12 -75 -17q-50 -4 -75 1q-58 4 -107 41q-12 7 -54 44zM231 588q-60 -67 -87 -156q-11 -46 -9 -106q1 -35 22 -94 q28 -79 65 -104q12 -20 78 -52q60 -24 125 -5q49 14 99 53q39 37 57 82q8 14 22 93l2 135q0 -9 -2 -11q-21 0 -21 42q-2 53 -7 63q-36 65 -90 96q-32 19 -108 26q-90 -13 -146 -62z")
        let trans = CGAffineTransform(scaleX: 0.25, y: -0.25)
        path.apply(trans)
        var translate = CGAffineTransform(translationX:(50 - path.currentPoint.x), y: (100 - path.currentPoint.y))
        path.apply(translate)
        return path
    }
    
    class func getAPoints() ->[[CGPoint]] {
        var pointArrays = [[CGPoint]]()
        var array1 = [CGPoint]()
        array1.append(CGPoint(x:139.0,y:  107.5))
        array1.append(CGPoint(x:82.0,y:  76.0))
        array1.append(CGPoint(x:27.0,y:  116.0))
        array1.append(CGPoint(x:18.5,y:  187.0))
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
}



