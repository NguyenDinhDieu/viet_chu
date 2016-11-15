//
//  MenuViewController.swift
//  viet_chu
//
//  Created by Admin on 11/14/16.
//  Copyright © 2016 efode. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    var alphabetArray = [Alphabet]()
    
    var characterArray = [String]()
    
    var colNo = 9 // default column number
    
    var rowNo = 2 // default row number
    
    var boardGame = UIImageView()
    
    var selectedIndex = 0
    
    let synthesizer = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        synthesizer.stopSpeaking(at: .immediate)
        // setup font
        let cfURL = Bundle.main.url(forResource: "Schoolnet5HN", withExtension: "ttf") as! CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let font = UIFont(name: "Schoolnet 5H", size: 40)!
        
        //load character
        let vietnameseTable: String = "aăâbcdđeêghiklmnoôơpqrstuưvxy"
        for i in 0...28 {
            let r = vietnameseTable.index(vietnameseTable.startIndex, offsetBy: i)
            let sub = vietnameseTable[r]
            characterArray.append("\(sub)")
//            characterArray[i] = AlphabetUtils.getAlphabet(unicode:"\(charString[r])")
        }

        // Do any additional setup after loading the view.
        boardGame.frame = CGRect(x: 50, y: 50, width: UIScreen.main.bounds.width * 0.8 , height: (UIScreen.main.bounds.height * 0.8))
        let charEachRow:CGFloat = 8
        var rowCount:CGFloat = 1
        var colCount:CGFloat = 1
//        let width = (boardGame.frame.width) / charEachRow
        let width = (boardGame.frame.width) / charEachRow
        let height:CGFloat = 80
        
        for i in 0...28 {
            
            let alphabetBtn = UIButton()
            
            alphabetBtn.frame = CGRect(x: (colCount - 1) * width, y: height * (rowCount - 1) , width: width, height: height)
//            alphabetBtn.layer.borderWidth = 3
//            alphabetBtn.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
            let alphabet = AlphabetUtils.getAlphabet(unicode: characterArray[i])
            var tmpPath = alphabet.path
//            let widthRatio = (width - 5) / tmpPath.bounds.width
//            let heightRatio = (height - 5) / tmpPath.bounds.height
//            let cellHeight:CGFloat = 25
//            var scaleRatio: CGFloat!
//            if widthRatio > heightRatio {
//                scaleRatio = heightRatio
//            } else {
//                scaleRatio = widthRatio
//            }
//            let trans2 = CGAffineTransform(scaleX: 1/8, y: widthRatio)
//            tmpPath.apply(trans2)
//            let trans1 = CGAffineTransform(translationX: width/2 - tmpPath.bounds.midX, y: 50 - tmpPath.bounds.maxY)
//            tmpPath.apply(trans1)
            
            
//            alphabetBtn.setImage(ViewController.convertPathsToImage(paths: [tmpPath]), for: .normal)
//            alphabetBtn.contentMode =
            
            if i != 20 {
                alphabetBtn.titleLabel!.font = font
            } else {
                let cfURL1 = Bundle.main.url(forResource: "HLHOCTRO", withExtension: "TTF") as! CFURL
                CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
                let font1 = UIFont(name: "HL hoctro", size: 45)!
                alphabetBtn.titleLabel!.font = font1
            }
            alphabetBtn.titleLabel?.textAlignment = .center
            alphabetBtn.titleLabel?.frame = alphabetBtn.frame
            let btnImage1 = UIImage(named: "button1")
            let btnImage2 = UIImage(named: "button2")
            alphabetBtn.setBackgroundImage(btnImage1, for: .normal)
            alphabetBtn.setBackgroundImage(btnImage2, for: .selected)
            alphabetBtn.setTitle(characterArray[i], for: .normal)
            alphabetBtn.setTitleColor(UIColor.red, for: .normal)
//            alphabetBtn.addTarget(self, action: #selector, for: .touchUpInside)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.btnPressed(_:)))
            alphabetBtn.addGestureRecognizer(tapGesture)
            alphabetBtn.isUserInteractionEnabled = true
//            alphabetBtn.isSelected = true
            alphabetBtn.tag = i
            alphabetArray.append(alphabet)
            boardGame.addSubview(alphabetBtn)
            colCount += 1
            if colCount > charEachRow {
                rowCount += 1
                colCount = 1
            }
            
        }
        boardGame.center = CGPoint(x: self.view.frame.midX, y: boardGame.center.y)
        boardGame.isUserInteractionEnabled = true
        self.view.addSubview(boardGame)
        
        
        //ten game
        let name = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        name.center = CGPoint(x: 50, y: 30)
        name.textAlignment = .center
        name.text = "Game "
        self.view.addSubview(name)
        
        //logo
        let logo = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        logo.center = CGPoint(x: 50, y: UIScreen.main.bounds.height - 30)
        logo.textAlignment = .center
        logo.text = "Logo "
        self.view.addSubview(logo)
        
        //play button
        let playBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 80, y: UIScreen.main.bounds.height * 0.05 , width: 80, height: 30))
        playBtn.setTitle("Viết chữ", for: .normal)
        playBtn.backgroundColor = UIColor.purple
        playBtn.addTarget(self, action: #selector(self.playBtnPressed), for: .touchUpInside)
        self.view.addSubview(playBtn)
        
        //back button
        let backBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 80, y: UIScreen.main.bounds.height * 0.85 , width: 80, height: 30))
        backBtn.setTitle("Quay lại", for: .normal)
        backBtn.backgroundColor = UIColor.purple
        self.view.addSubview(backBtn)
    }
    
    func btnPressed(_ sender: UITapGestureRecognizer) {
        print("pressed")
        for subView in boardGame.subviews {
            let tmpButton = subView as! UIButton
            tmpButton.isSelected = false
        }
        let button  = sender.view as! UIButton
        button.isSelected = true
        selectedIndex = button.tag
        
        // talk
        let utterance = AVSpeechUtterance(string: (button.titleLabel?.text)!)
        utterance.voice = AVSpeechSynthesisVoice(language: "vn")
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
    func playBtnPressed() {
        performSegue(withIdentifier: "DrawSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let destination = segue.destination as? ViewController {
                    destination.selectedIndex = self.selectedIndex
                    destination.alphabetArray = self.alphabetArray
                }
    }
    
}

