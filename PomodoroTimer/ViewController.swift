//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Victoria on 06/06/2024.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var labelText: UILabel!

    let textOfLabel = ["Decide on the task to be completed.",
    "Set a timer for 25 minutes, the length of one pomodoro.",
    "Work on the task until the timer rings, then put a checkmark on a piece of paper.",
    "Take a short break (usually 5 minutes) to stretch and relax.",
    "After four pomodoros, take a longer break (usually 15-30 minutes)."]



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonPressed(_ sender: UIButton) {
    }
    

}

