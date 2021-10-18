//
//  MH3ViewController.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 07/10/2021.
//

import UIKit

class MH3ViewController: UIViewController {

    @IBOutlet weak var Pw: UITextField!
    let button = UIButton(type: .custom)
    @IBOutlet weak var MyImage: UIImageView!
    @IBOutlet weak var MyButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        MyImage.image = UIImage(named: "people")
        
        MyButton.setTitle("Продолжить", for: .normal)
        
        commonInit()
    }
    private func commonInit(){
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Вход"
    }
    override func viewDidAppear(_ animated: Bool) {
        MyButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        Pw.rightViewMode = .unlessEditing
        button.setImage(UIImage(named: "eyeclosed.png"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(self.btnPw), for: .touchUpInside)
        Pw.rightView = button
        Pw.rightViewMode = .always
    }
    
    @IBAction func btnPw(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            self.Pw.isSecureTextEntry = false
            button.setImage(UIImage(named: "eyeopen.png"), for: .normal)
        } else {
            self.Pw.isSecureTextEntry = true
            button.setImage(UIImage(named: "eyeclosed.png"), for: .normal)
        }
    }
   
}
