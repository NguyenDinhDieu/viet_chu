//
//  MainMenuVC.swift
//  viet_chu
//
//  Created by Tri on 11/17/16.
//  Copyright © 2016 efode. All rights reserved.
//

import UIKit
import AVFoundation

class MainMenuVC: UIViewController {
    
    @IBOutlet weak var numberBtn: UIButton!
    
    @IBOutlet weak var alphebetLowBtn: UIButton!
    
    @IBOutlet weak var alphabetUpBtn: UIButton!
    
    var selectedTable = Table.alphabetLower
    
    var bgMusic: AVAudioPlayer!
    
    override func viewDidLoad() {
        let themeView = UIImageView(frame: self.view.frame)
        themeView.image = UIImage(named: "theme")
        self.view.insertSubview(themeView, at: 0)
        alphabetUpBtn.removeFromSuperview()
        super.viewDidLoad()
        playMusic()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        alphebetLowBtn.frame.size = CGSize(width: self.view.frame.width / 4 , height: self.view.frame.height / 3)
        alphebetLowBtn.center = CGPoint(x: self.view.frame.width / 3 - 20, y: self.view.frame.height / 3 - 20)
        numberBtn.frame.size = CGSize(width: self.view.frame.width / 4 , height: self.view.frame.height / 3)
        numberBtn.center = CGPoint(x: self.view.frame.width / 3 * 2 + 20, y: self.view.frame.height / 3 - 20)
//        numberBtn.frame.size = CGSize(width: self.view.frame.width / 4 , height: self.view.frame.height / 3)
//        numberBtn.center = CGPoint(x: self.view.frame.width / 3 - 20, y: self.view.frame.height / 3 * 2)
    }
    
    func playMusic() {
        let path = Bundle.main.path(forResource: "music2", ofType: "mp3")!
        let musicUrl = URL(fileURLWithPath: path)
        do {
            bgMusic = try AVAudioPlayer(contentsOf: musicUrl)
            bgMusic.volume = 0.3
            bgMusic.numberOfLoops = -1
            bgMusic.play()
            
        } catch (let err as NSError) {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberBtnPressed(_ sender: Any) {
        selectedTable = Table.number
        self.performSegue(withIdentifier: "MenuSegue", sender: self)
    }
    
    @IBAction func alphabetLowBtnPressed(_ sender: Any) {
        selectedTable = Table.alphabetLower
        self.performSegue(withIdentifier: "MenuSegue", sender: self)
    }
    
    @IBAction func alphebetUpBtnPressed(_ sender: Any) {
        selectedTable = Table.alphabetUpper
        self.performSegue(withIdentifier: "MenuSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MenuViewController {
            destination.selectedTable = self.selectedTable
        }
    }

}
