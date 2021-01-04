//
//  FirstViewController.swift
//  TicTocToe
//
//  Created by Admin on 04.01.2021.
//  Copyright © 2021 Alexander Germek. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func NewGameBtnAction(_ sender: UIButton) {
        if let newViewController = storyboard?.instantiateViewController(withIdentifier: "Second") as? ViewController {
         newViewController.modalTransitionStyle = .crossDissolve // это значение можно менять для разных видов анимации появления
            newViewController.modalPresentationStyle = .overCurrentContext // это та самая волшебная строка, убрав или закомментировав ее, вы получите появление смахиваемого контроллера
         present(newViewController, animated: false, completion: nil)
        }
    }
    
    @IBAction func exitTheGameButtonAction(_ sender: UIButton) {
        exit(0)
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
