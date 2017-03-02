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
    var tmpLines = [Line]()
    var lines = [Line]()
    var lastPoint: CGPoint!
    var colorFlag = false
    var originalPath: CGPath!
    var pointArray = [CGPoint]()
    var pointArrays = [[CGPoint]]()
    var arrows = [UIBezierPath]()
    var isCompleted = false
    let synthesizer = AVSpeechSynthesizer()
    var drawWidth:CGFloat = 20
    var currenColor = UIColor.red
    
    var alphabetSound: AVAudioPlayer!
    var bellSound: AVAudioPlayer!
    var bellUrl: URL!
    var yaySound: AVAudioPlayer!
    var timer: Timer!
    var insideCount = 0
    var tmpInsideCount = 0
    var outsideCount = 0
    var tmpOutsideCount = 0
    
    var wrongMoveDetected = false
    
    var conImage = UIImageView() // congratulation image
    var emotionImage = UIImageView() // emotion image for each step
    var starImage: UIImage!
    
    func setupSound() {
        let path = Bundle.main.path(forResource: "bell", ofType: "wav")!
        bellUrl = URL(fileURLWithPath: path)
        do {
            bellSound = try AVAudioPlayer(contentsOf: bellUrl)
        } catch (let err as NSError) {
            print(err.debugDescription)
        }
        starImage = UIImage(named: "star2")
    }
    
    func setOriginal(_ path: CGPath){
        originalPath = path
    }
    
    
//    var tmpPointArrays: [[CGPoint]]! // to resest points if wrong sequence
    var isNewTouch = false
    var removedPoint = CGPoint(x: 0, y: 0) // just removed point
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isNewTouch = true
        // store tmp variables to backup if needed
//        tmpPointArrays = [[CGPoint]]()
//        for pArray in pointArrays {
//            tmpPointArrays.append(pArray)
//        }
        tmpInsideCount = insideCount
        tmpOutsideCount = outsideCount
        //-------------------
        
        lastPoint = touches.first?.location(in: self)
        let line = Line(lastPoint, lastPoint!, currenColor.cgColor)
        lines.append(line)
        if pointArrays.count > 0 {
            pointArray = pointArrays[0]
            if pointArray.count > 0 {
                let point = pointArray[0]
                if compareTwoPoint(point, lastPoint!) {
                    removedPoint = point
                    self.playBellSound()
                    let starView = UIImageView()
                    starView.center = CGPoint(x: lastPoint.x - 20, y: lastPoint.y - 20)
                    starView.image = starImage
                    self.addSubview(starView)
                    UIView.animate(withDuration: 0.3, animations: {
                        starView.frame.size = CGSize(width: 25, height: 25)
                        starView.center = CGPoint(x: starView.center.x - 20, y: starView.center.y - 20)
                    }, completion: {
                        finished in
                        starView.removeFromSuperview()
                    })
                    pointArray.remove(at: 0)
                    pointArrays[0] = pointArray
                    
                }
            }
            if pointArray.count == 0 {
                pointArrays.remove(at: 0)
                if !arrows.isEmpty {
                    arrows.remove(at: 0)
                }
            }
        }
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first?.view?.isUserInteractionEnabled)! {
            let newPoint = touches.first?.location(in: self)
            if originalPath.contains(newPoint!) {
                insideCount += 1
            } else {
                outsideCount += 1

            }
            let line = Line(lastPoint, newPoint!, currenColor.cgColor)
            lines.append(line)
            lastPoint = newPoint
            controlPoint: if pointArrays.count > 0 {
                pointArray = pointArrays[0]
                if pointArray.count > 0 {
                    let point = pointArray[0]
                    if compareTwoPoint(point, newPoint!) {
                        removedPoint = CGPoint(x: point.x, y: point.y)
                        self.playBellSound()
                        let starView = UIImageView()
                        starView.center = lastPoint
                        starView.image = starImage
                        self.addSubview(starView)
                        UIView.animate(withDuration: 0.5, animations: {
                            starView.frame.size = CGSize(width: 25, height: 25)
                            starView.center = CGPoint(x: starView.center.x - 30, y: starView.center.y - 30)
                        }, completion: {
                            finished in
                            starView.removeFromSuperview()
                        })
                        pointArray.remove(at: 0)
                        pointArrays[0] = pointArray
                        if pointArray.count == 0 {
                            wrongMoveDetected = true
                            isNewTouch = false
                            tmpLines = lines
                            tmpInsideCount = insideCount
                            tmpOutsideCount = outsideCount
                            pointArrays.remove(at: 0)
                            if !arrows.isEmpty {
                                arrows.remove(at: 0)
                            }
                            emotionImage.center = CGPoint(x: 0, y: 0)
                            emotionImage.frame.size = CGSize(width: 5, height: 5)
                            emotionImage.image = UIImage(named: "continue")
                            self.addSubview(emotionImage)
                            UIView.animate(withDuration: 0.5, animations: {
                                self.emotionImage.frame.size = CGSize(width: 100, height: 100)
                                self.emotionImage.center = CGPoint(x: 50, y: 50)
                            }, completion: {
                                finished in
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                    self.emotionImage.removeFromSuperview()
                                })
                            })
                        }
                        break controlPoint
                    } else {
                        // kiểm tra nét mới trước khi kiểm tra points
                        if isNewTouch {
                            // kiểm tra points
//                            point = pointArray[0]
                            for p in pointArray {
                                if !compareTwoPoint(removedPoint, p) && compareTwoPoint(p, newPoint!) {
                                    wrongMoveDetected = true
                                    touches.first?.view?.isUserInteractionEnabled = false
                                    lines = tmpLines
                                    insideCount = tmpInsideCount
                                    outsideCount = tmpOutsideCount
//                                    pointArrays = tmpPointArrays!
                                    emotionImage.center = CGPoint(x: 0, y: 0)
                                    emotionImage.frame.size = CGSize(width: 5, height: 5)
                                    emotionImage.image = UIImage(named: "wrong")
                                    self.addSubview(emotionImage)
                                    UIView.animate(withDuration: 0.5, animations: {
                                        self.emotionImage.frame.size = CGSize(width: 100, height: 100)
                                        self.emotionImage.center = CGPoint(x: 50, y: 50)
                                    }, completion: {
                                        finished in
                                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                            self.emotionImage.removeFromSuperview()
                                        })
                                    })
                                    break controlPoint
                                }
                            }
                        }
                        
                    }
                    
                }
            }
            self.setNeedsDisplay()
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.first?.view?.isUserInteractionEnabled = true
        // if there is no pointArray removed
//        if pointArrays.count  == tmpPointArrays.count {
//            lines = tmpLines
//            insideCount = tmpInsideCount
//            outsideCount = tmpOutsideCount
//            pointArrays = tmpPointArrays!
//            if !wrongMoveDetected{
//                emotionImage.center = CGPoint(x: 0, y: 0)
//                emotionImage.frame.size = CGSize(width: 5, height: 5)
//                emotionImage.image = UIImage(named: "worry")
//                self.addSubview(emotionImage)
//                UIView.animate(withDuration: 0.5, animations: {
//                    self.emotionImage.frame.size = CGSize(width: 100, height: 100)
//                    self.emotionImage.center = CGPoint(x: 50, y: 50)
//                }, completion: {
//                    finished in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                        self.emotionImage.removeFromSuperview()
//                    })
//                })
//
//            }
//            wrongMoveDetected = false
//        }
//        else {
//            tmpLines = lines
//            tmpInsideCount = insideCount
//            tmpOutsideCount = outsideCount
//            // if completed
//            if pointArrays.count == 0{
//                isCompleted = true
//                self.isUserInteractionEnabled = false
//                // talk
//                let utterance = AVSpeechUtterance(string: character.lowercased())
//                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//                utterance.rate = 0.3
//                synthesizer.stopSpeaking(at: .immediate)
//                synthesizer.speak(utterance)
//                self.originalPath = nil
//                // congratulation image showing
//                if Float(outsideCount) / Float(insideCount) > 0.5 {
//                    conImage.image = UIImage(named: "comeOn")
//                } else if Float(outsideCount) / Float(insideCount) > 0.35 {
//                    conImage.image = UIImage(named: "fairyGood")
//                } else if Float(outsideCount) / Float(insideCount) > 0.2 {
//                    conImage.image = UIImage(named: "wow")
//                } else {
//                    conImage.image = UIImage(named: "smile2")
//                }
//                conImage.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
//                conImage.frame.size = CGSize(width: 5, height: 5)
//                self.addSubview(conImage)
//                UIView.animate(withDuration: 0.5, animations: {
//                    self.conImage.frame.size = CGSize(width: 100, height: 100)
//                }, completion: {
//                    finished in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                        self.conImage.removeFromSuperview()
//                    })
//                })
//            }
//        }
        tmpLines = lines
        tmpInsideCount = insideCount
        tmpOutsideCount = outsideCount
        // if completed
        if pointArrays.count == 0{
            isCompleted = true
            self.isUserInteractionEnabled = false
            
            self.originalPath = nil
            // congratulation image showing
            if Float(outsideCount) / Float(insideCount) > 0.5 {
                conImage.image = UIImage(named: "comeOn")
            } else if Float(outsideCount) / Float(insideCount) > 0.35 {
                conImage.image = UIImage(named: "fairyGood")
            } else if Float(outsideCount) / Float(insideCount) > 0.2 {
                conImage.image = UIImage(named: "wow")
            } else {
                conImage.image = UIImage(named: "smile2")
            }
            conImage.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
            conImage.frame.size = CGSize(width: 5, height: 5)
            playYaySound()
            self.addSubview(conImage)
            UIView.animate(withDuration: 0.5, animations: {
                self.conImage.frame.size = CGSize(width: 100, height: 100)
            }, completion: {
                finished in
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.conImage.removeFromSuperview()
                    // talk
//                    let utterance = AVSpeechUtterance(string: self.character.lowercased())
//                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//                    utterance.rate = 0.3
//                    self.synthesizer.stopSpeaking(at: .immediate)
//                    self.synthesizer.speak(utterance)
                    self.yaySound.stop()
                    self.playSound(self.character.lowercased())
                })
            })
        }

        self.setNeedsDisplay()
        
    }
    
    func compareTwoPoint(_ point1: CGPoint, _ point2: CGPoint) -> Bool {
        if abs(point1.x - point2.x) < 20 && abs(point1.y - point2.y) < 20 {
            return true
        }
        return false
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.beginPath()
        context!.setLineCap(.round)
        if originalPath != nil {
            context!.setLineWidth(3)
            context?.addPath(originalPath)
            context!.strokePath()
        }
        
        context!.setLineWidth(2)
        context!.setStrokeColor(UIColor.purple.cgColor)
        
        let arrow = arrows.first
        if arrow != nil {
            UIColor.purple.setFill()
            arrow?.fill()
            context!.addPath((arrow?.cgPath)!)
            context!.strokePath()
        }
        
        context!.setLineWidth(12)
        context!.setStrokeColor(UIColor.blue.cgColor)
        var points = pointArrays.first
        var fPoint: CGPoint!
        if points != nil && (points?.count)! > 0 {
            fPoint = points?.remove(at: 0)
            context!.setStrokeColor(UIColor.blue.cgColor)
            for point in points! {
                context!.move(to: point)
                context!.addLine(to: point)
                context!.strokePath()
            }
        }

        context!.setLineWidth(drawWidth)
        for line in lines {
            context!.setStrokeColor(line.color)
            context!.move(to: line.startPoint)
            context!.addLine(to: line.endPoint)
            context!.strokePath()
        }
        
        if fPoint != nil {
            context!.setStrokeColor(UIColor.purple.cgColor)
            context!.setLineWidth(16)
            context!.move(to: fPoint!)
            context!.addLine(to: fPoint!)
            context!.strokePath()
        }
    }
    
    func playBellSound() {
        if bellSound.isPlaying {
            bellSound.stop()
            do {
                bellSound = try AVAudioPlayer(contentsOf: bellUrl)
            } catch (let err as NSError) {
                print(err.debugDescription)
            }
        }
        bellSound.play()
    }
    
    func playYaySound() {
        let fileNames = ["win1", "win2", "win3", "win4"]
        let randomNum:Int = Int(arc4random_uniform(4))
        let fileName = fileNames[randomNum]
        let path = Bundle.main.path(forResource: fileName, ofType: "mp3")!
        let yayUrl = URL(fileURLWithPath: path)
        do {
            yaySound = try AVAudioPlayer(contentsOf: yayUrl)
        } catch (let err as NSError) {
            print(err.debugDescription)
        }
        yaySound.play()
    }
    
    func playSound(_ alphabet: String) {
        let path = Bundle.main.path(forResource: alphabet, ofType: "mp3")!
        let alphabetUrl = URL(fileURLWithPath: path)
        do {
            alphabetSound = try AVAudioPlayer(contentsOf: alphabetUrl)
            alphabetSound.play()
        } catch (let err as NSError) {
            print(err.debugDescription)
        }
    }
    
}
