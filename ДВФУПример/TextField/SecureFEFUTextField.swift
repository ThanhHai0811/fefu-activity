import UIKit

class SecureFEFUTextField: SignFEFUTextField {
    
    let toggleButton = UIButton(type: .custom)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        showPasswordToggle()
    }
    
    private func showPasswordToggle() {
        
        //initially this is secure
        self.isSecureTextEntry = true
        
        //set eyes
        toggleButton.setImage(UIImage(named: "eyeclosed"), for: .normal)
        toggleButton.setImage(UIImage(named:"eyeopen"), for: .selected)
        
        //add padding
        toggleButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        
        //add handler
        toggleButton.addTarget(self, action: #selector(toggleHandler), for: .touchUpInside)
        
        //move to right
        rightView = toggleButton
        rightViewMode = .always
    }
    
    @objc func toggleHandler(_ sender: Any) {
        self.isSecureTextEntry.toggle()
        toggleButton.isSelected.toggle()
    }
}
