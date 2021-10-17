//
//  MH2ViewController.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 07/10/2021.
//

import UIKit

class MH2ViewController: UIViewController {

    @IBOutlet weak var Pw1: UITextField!
    let button1 = UIButton(type: .custom)
    @IBOutlet weak var Pw2: UITextField!
    @IBOutlet weak var MyButton: UIButton!
    let button2 = UIButton(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        MyButton.setTitle("Продолжить", for: .normal)
    }
    override func viewDidAppear(_ animated: Bool) {
        MyButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        Pw1.rightViewMode = .unlessEditing
        button1.setImage(UIImage(named: "eyeclosed.png"), for: .normal)
        button1.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button1.addTarget(self, action: #selector(self.btnPw1), for: .touchUpInside)
        Pw1.rightView = button1
        Pw1.rightViewMode = .always
        
        Pw2.rightViewMode = .unlessEditing
        button2.setImage(UIImage(named: "eyeclosed.png"), for: .normal)
        button2.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button2.addTarget(self, action: #selector(self.btnPw2), for: .touchUpInside)
        Pw2.rightView = button2
        Pw2.rightViewMode = .always
    }
    @IBAction func btnPw1(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            self.Pw1.isSecureTextEntry = false
            button1.setImage(UIImage(named: "eyeopen.png"), for: .normal)
        } else {
            self.Pw1.isSecureTextEntry = true
            button1.setImage(UIImage(named: "eyeclosed.png"), for: .normal)
        }
    }
    
    
    @IBAction func btnPw2(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            self.Pw2.isSecureTextEntry = false
            button2.setImage(UIImage(named: "eyeopen.png"), for: .normal)
        } else {
            self.Pw2.isSecureTextEntry = true
            button2.setImage(UIImage(named: "eyeclosed.png"), for: .normal)
        }
    }
}
