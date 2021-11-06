//
//  ViewController.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 07/10/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SignUp: UIButton!
    @IBOutlet weak var SignIn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SignUp.setTitle("Зарегистрироваться", for: .normal)
        SignIn.setTitle("Уже есть аккаунт?", for: .normal)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        SignUp.titleLabel?.font = .boldSystemFont(ofSize: 16)
        SignIn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        createTabBarController()
    }

    @IBAction func SignUpTap(_ sender: Any) {
        let SignUpView = storyboard?.instantiateViewController(withIdentifier: "Screen2") as! MH2ViewController
        navigationController?.pushViewController(SignUpView, animated: true)
    }
    @IBAction func SignInTap(_ sender: Any) {
        let SignInView = storyboard?.instantiateViewController(withIdentifier: "Screen3") as! MH3ViewController
        navigationController?.pushViewController(SignInView, animated: true)
    }
    private func createTabBarController(){
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        let activityNavitgation = UINavigationController(rootViewController: ActivityDetailsViewController())
        activityNavitgation.title = "Активности"
        let profileNavigation = UINavigationController(rootViewController: ProfileViewController())
        profileNavigation.title = "Профиль"
        tabBarController.setViewControllers([activityNavitgation, profileNavigation], animated: true)
        tabBarController.modalPresentationStyle = .fullScreen
        guard let iteams = tabBarController.tabBar.items else {
            return
        }
        for iteam in iteams {
            iteam.image = UIImage(systemName: "circlebadge")
        }
        present(tabBarController, animated: true, completion: nil)
    }
}
