//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Victoria on 06/06/2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {


    @IBOutlet weak var labelText: UILabel!

    @IBOutlet weak var progressBar: UIProgressView!

    @IBOutlet weak var button: UIButton!

    let textOfLabel = ["Decide on the task to be completed and set a timer",
                       "Work on the task until the timer rings",
                       "Take a short break for 5 minutes to stretch and relax"]

    let buttonText = ["Start", "Work", "Relax"]

    var timer = Timer()
    var player: AVAudioPlayer?
    var totalTime = 0
    var secondsPassed = 0
    var relaxTime = 0
    var relaxPassed = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor(red: 54/255.0, green: 75/255.0, blue: 32/255.0, alpha: 1.0).cgColor
        button.layer.cornerRadius = 18.0
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        timer.invalidate()
        totalTime = 25 * 60
        relaxTime = 5 * 60
        progressBar.progress = 0.0
        secondsPassed = 0
        relaxPassed = 0
        button.setTitle(buttonText[1], for: .normal)
        labelText.text = textOfLabel[1]

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.alpha = 1.0
        }
    }

    func playSound() {
        if let path = Bundle.main.path(forResource: "Timer", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            button.setTitle(buttonText[2], for: .normal)
        }
    }

    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            playSound()
            timer.invalidate()
            labelText.text = textOfLabel[2]
            button.setTitle(buttonText[2], for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerForRelax), userInfo: nil, repeats: true)
        }
    }

    @objc func updateTimerForRelax() {
        if relaxPassed == 0 {
            progressBar.progress = 0
        }
    if relaxPassed < relaxTime {
        relaxPassed += 1
        progressBar.progress = Float(relaxPassed) / Float(relaxTime)
    } else {
        playSound()
        timer.invalidate()
        labelText.text = textOfLabel[0]
        button.setTitle(buttonText[0], for: .normal)
        progressBar.progress = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.labelText.text = self.textOfLabel[0]
            self.button.setTitle(self.buttonText[0], for: .normal)
            self.progressBar.progress = 0
           }
       }
   }
}

