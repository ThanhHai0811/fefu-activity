import UIKit

class MH3ViewController: UIViewController {

    @IBOutlet weak var LoginField: SignFEFUTextField!
    @IBOutlet weak var PasswordField: SecureFEFUTextField!
    @IBOutlet weak var continueButton: ActivityFEFUButton!
    static private let encoder = JSONEncoder()
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    @IBAction func DidTapCoutinueButton(_ sender: Any) {
        let login = LoginField.text ?? ""
        let password = PasswordField.text ?? ""
        
        let body = UserLoginBody(login: login, password: password)
        
        do {
            let reqBody = try MH3ViewController.encoder.encode(body)
            let queue = DispatchQueue.global(qos: .utility)
            AuthService.login(reqBody) { user in
                queue.async {
                    UserDefaults.standard.set(user.token, forKey: "token")
                }
                DispatchQueue.main.async {
                    let vc = TabsViewController(nibName: "TabsViewController", bundle: nil)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            } onError: { err in
                DispatchQueue.main.async {
                    self.checkApiErrors(errors: err.errors)
                }
            }
        } catch {
            print(error)
        }
    }
    private func commonInit() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.title = "Вход"
        navigationItem.prompt = ""
        
        continueButton.setTitle("Продолжить", for: .normal)
    }
    
    private func checkApiErrors(errors: Dictionary<String, [String]>) {
        var alertText = ""
        for (_, values) in errors.reversed() {
            for e in values {
                alertText += e + "\n"
            }
        }
        
        let alert = UIAlertController(title: "Проверьте поля", message: alertText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Повторить попытку", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
