//
//  OnboardingViewController.swift
//  boboChu
//
//  Created by Leyi Qiang on 12/30/18.
//  Copyright © 2018 Leyi Qiang. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {


    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var invalidUsernamePrompt: UILabel!
    @IBOutlet weak var nameConfirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invalidUsernamePrompt.text = ""

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmButtonClick(_ sender: Any) {
        if isValidInput(Input: username.text ?? "") {
            invalidUsernamePrompt.text = ""
            let defaults = UserDefaults.standard
            defaults.set(username.text, forKey: "username")
            defaults.synchronize()
            showTutorial()
        } else {
            invalidUsernamePrompt.text = "非法用户名!"
        }
    }
    
    func isValidInput(Input:String) -> Bool {
        let RegEx = "\\w{3,18}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
    
    func showTutorial() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tutorialViewController = mainStoryboard.instantiateViewController(withIdentifier: "TutorialPage") as! TutorialViewController
        present(tutorialViewController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
