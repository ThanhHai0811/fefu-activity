//
//  MH2ViewController.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 07/10/2021.
//

import UIKit

class MH2ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var Pw1: UITextField!
    let button1 = UIButton(type: .custom)
    @IBOutlet weak var Pw2: UITextField!
    let button2 = UIButton(type: .custom)
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var GenderPicker: UITextField!
    @IBOutlet weak var MyButton: UIButton!
    let genders = ["", "Мужской", "Женский"]
    let genderPickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        GenderPicker.inputView = genderPickerView
        commonInit()
    }
    private func commonInit(){
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        GenderPicker.tintColor = .clear
        MyButton.setTitle("Продолжить", for: .normal)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Регистрация"
        navigationItem.prompt = ""
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        GenderPicker.text = genders[row]
        GenderPicker.resignFirstResponder()
    }
    override func viewDidAppear(_ animated: Bool) {
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
