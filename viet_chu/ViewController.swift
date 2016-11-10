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
        path = Alphabet.getV()

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
        drawView.pointArrays = Alphabet.getVPoints()
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



}



