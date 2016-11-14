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
    
    var path = UIBezierPath() // character's path
    var leftMenu: UIView! // left menu
    var rightMenu: UIView! // right menu
    let drawView = DrawView() // draw view
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawView.frame = CGRect(x: self.view.frame.width * 2 / 10, y: 0, width: self.view.frame.width * 6 / 10, height: self.view.frame.height)
        self.createDrawView()
        self.view.addSubview(drawView)
        
        // create left menu layout
        leftMenu = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 2 / 10, height: self.view.frame.height))
        leftMenu.backgroundColor = UIColor.yellow
        // label : Tập viết chữ
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: leftMenu.frame.width, height: 20))
        label.textAlignment = .center
        label.textColor = UIColor.purple
        label.text = "Tập viết chữ"
        leftMenu.addSubview(label)
        // Image chữ cái mẫu
        let originalView = UIImageView(frame: CGRect(x: 5, y: 40, width: leftMenu.frame.width - 10, height: leftMenu.frame.width - 10))
//        originalView.center.applying(CGAffineTransform(translationX: leftMenu.center.x - originalView.center.x, y: 0))
        originalView.backgroundColor = UIColor.white
        let tmpPath = path
        let widthRatio = (originalView.frame.width - 10) / tmpPath.bounds.width
        let heightRatio = (originalView.frame.height - 10) / tmpPath.bounds.height
        var scaleRatio: CGFloat!
        if widthRatio > heightRatio {
            scaleRatio = heightRatio
        } else {
            scaleRatio = widthRatio
        }
        let trans2 = CGAffineTransform(scaleX: scaleRatio, y: scaleRatio)
        tmpPath.apply(trans2)
        let trans1 = CGAffineTransform(translationX: originalView.frame.width / 2 - tmpPath.bounds.midX, y: originalView.frame.height / 2 - tmpPath.bounds.midY)
        tmpPath.apply(trans1)
        originalView.image = convertPathsToImage(paths: [tmpPath])
        originalView.contentMode = .topLeft
        leftMenu.addSubview(originalView)
        // Logo game
        let logoGame = UILabel(frame: CGRect(x: 0, y: leftMenu.frame.height - 50, width: leftMenu.frame.width, height: 40 ))
        logoGame.textAlignment = .center
        logoGame.textColor = UIColor.purple
        logoGame.text = "Logo game"
        leftMenu.addSubview(logoGame)
        
        self.view.addSubview(leftMenu)
        
        // create right menu layout
        rightMenu = UIView(frame: CGRect(x: self.view.frame.width * 8 / 10, y: 0, width: self.view.frame.width * 2 / 10, height: self.view.frame.height))
        rightMenu.backgroundColor = UIColor.white
        // button Viết lại
        let resetBtn = UIButton(frame: CGRect(x: 0, y: 10, width: rightMenu.frame.width, height: 40 ))
        resetBtn.setTitle("Viết lại", for: .normal)
        resetBtn.backgroundColor = UIColor.red
        resetBtn.addTarget(self, action: #selector(self.createDrawView) , for: .touchUpInside)
        rightMenu.addSubview(resetBtn)
        
        // button Chữ kế tiếp
        let nextBtn = UIButton(frame: CGRect(x: 0, y: 10 + resetBtn.frame.maxY, width: rightMenu.frame.width, height: 40 ))
        nextBtn.setTitle("Chữ kế tiếp", for: .normal)
        nextBtn.backgroundColor = UIColor.red
        rightMenu.addSubview(nextBtn)
        
        // button Chữ liền trước
        let prevBtn = UIButton(frame: CGRect(x: 0, y: 10 + nextBtn.frame.maxY, width: rightMenu.frame.width, height: 40 ))
        prevBtn.setTitle("Chữ liền trước", for: .normal)
        prevBtn.backgroundColor = UIColor.red
        rightMenu.addSubview(prevBtn)
        
        // button Phát âm
        let talkBtn = UIButton(frame: CGRect(x: 0, y: 40 + prevBtn.frame.maxY, width: rightMenu.frame.width, height: 40 ))
        talkBtn.setTitle("Phát âm", for: .normal)
        talkBtn.backgroundColor = UIColor.red
        rightMenu.addSubview(talkBtn)
        
        // button Quay lại
        let backBtn = UIButton(frame: CGRect(x: 0, y: rightMenu.frame.height - 50 , width: rightMenu.frame.width, height: 40 ))
        backBtn.setTitle("Quay lại", for: .normal)
        backBtn.backgroundColor = UIColor.red
        rightMenu.addSubview(backBtn)
        self.view.addSubview(rightMenu)
    }
    
    // create draw view
    func createDrawView() {
        print("create new draw view")
        drawView.lines = [Line]()
        path = AlphabetUtils.getM() // TODO get from an array
        drawView.pointArrays = AlphabetUtils.getMPoints() // TODO get from an array
        let transX = drawView.frame.width / 2 - path.bounds.midX
        let transY = drawView.frame.height / 2 - path.bounds.midY
        let trans = CGAffineTransform(translationX: transX, y: transY)
        path.apply(trans)
        var newPointArrays = [[CGPoint]]()
        for points in drawView.pointArrays {
            var newPoints = [CGPoint]()
            for point in points {
                let point2 = point.applying(trans)
                //                point = CGPoint(x: 0, y: 0)
                newPoints.append(point2)
            }
            newPointArrays.append(newPoints)
        }
        drawView.pointArrays = newPointArrays
        //        drawView.addLabel()
        drawView.backgroundColor = UIColor.green
        drawView.setOriginal(path.cgPath)
        drawView.setNeedsDisplay()
    }
    
    // convert path to image
    func convertPathsToImage(paths: [UIBezierPath]) -> UIImage
    {
        let imageWidth: CGFloat = 200
        let imageHeight: CGFloat  = 200
        let strokeColor:UIColor = UIColor.red
        
        // Make a graphics context
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setStrokeColor(strokeColor.cgColor)
        context!.setFillColor(UIColor.red.cgColor)
        
        for path in paths {
            path.stroke()
            path.fill()
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}




