//
//  ViewController.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 07/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: ActivityFEFUButton!
    
    
    @IBOutlet weak var alreadyExistButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        signUpButton.setTitle("Зарегистрироваться", for: .normal)
        alreadyExistButton.setTitle( "Уже есть аккаунт?", for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        alreadyExistButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }


    @IBAction func signUpButtonTap(_ sender: Any) {
        let signUpView = MH2ViewController(nibName: "MH2ViewController", bundle: nil)
        navigationController?.pushViewController(signUpView, animated: true)
    }
    
    @IBAction func alreadyExistButtonTap(_ sender: Any) {
        let signInView = MH3ViewController(nibName: "MH3ViewController", bundle: nil)
        navigationController?.pushViewController(signInView, animated: true)
    }
}
