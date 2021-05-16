//
//  AuthViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 15/05/21.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confirmarPassField: UITextField!
    @IBOutlet weak var errorCrearLabel: UILabel!
    
    
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPassField: UITextField!
    @IBOutlet weak var errorLoginLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func crearCuenta(_ sender: Any) {
        
        if confirmSignUp() {
            let email = emailField.text!
            let pass = passField.text!
            Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                if let err = error as NSError? {
                    switch AuthErrorCode(rawValue: err.code) {
                        case .operationNotAllowed:
                            self.errorCrearLabel.text = "Error en la operación"
                            print(err)
                        case .emailAlreadyInUse:
                            self.errorCrearLabel.text = "Este correo ya esta en uso."
                            print(err)
                        case .invalidEmail:
                            self.errorCrearLabel.text = "Correo invalido."
                            print(err)
                        case .weakPassword:
                            self.errorCrearLabel.text = "Contraseña invalida"
                            print(err)
                        default:
                            self.errorCrearLabel.text = "Error: \(err.localizedDescription)"
                            print("Error: \(err.localizedDescription)")
                    }
                    self.errorCrearLabel.isHidden = false
                } else {
                    print("User signs up successfully")
//                    let newUserInfo = Auth.auth().currentUser
//                    let email = newUserInfo?.email
                    self.performSegue(withIdentifier: "authToInicio", sender: self)
                    
                }
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if confirmLogin() {
            let email = loginEmailField.text!
            let pass = loginPassField.text!
            Auth.auth().signIn(withEmail: email, password: pass) { (authResult, error) in
                if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                  // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                    self.errorLoginLabel.text = "Operacion invalida."
                    self.errorLoginLabel.isHidden = false
                    
                print(error)
                case .userDisabled:
                    self.errorLoginLabel.text = "Usuario deshabilidatado."
                    self.errorLoginLabel.isHidden = false
                  // Error: The user account has been disabled by an administrator.
                    
                  print(error)
                case .wrongPassword:
                    self.errorLoginLabel.text = "Constraseña o correo incorrecta."
                    self.errorLoginLabel.isHidden = false
                  // Error: The password is invalid or the user does not have a password.
                    
                  print(error)
                case .invalidEmail:
                    self.errorLoginLabel.text = "Correo incorrecta."
                    self.errorLoginLabel.isHidden = false
                  // Error: Indicates the email address is malformed.
                    
                  print(error)
                default:
                    print("Error: \(error.localizedDescription)")
                }
              } else {
                print("User signs in successfully")
//                let userInfo = Auth.auth().currentUser
//                let email = userInfo?.email
                self.performSegue(withIdentifier: "authToInicio", sender: self)
              }
            }
        }
    }
    
    // MARK: Cofirmations
    
    func confirmSignUp() -> Bool {
        guard let email = emailField.text, let pass = passField.text, let confPass = confirmarPassField.text else {
            self.errorCrearLabel.text = "Completa todos los datos."
            self.errorCrearLabel.isHidden = false
            return false
        }
        if !isValidEmail(email) {
            self.errorCrearLabel.text = "Correo Invalido."
            self.errorCrearLabel.isHidden = false
        }else if !isValidPassword(pass) {
            self.errorCrearLabel.text = "Las contraseña es muy corta, 6 letras."
            self.errorCrearLabel.isHidden = false
        } else if pass != confPass {
            self.errorCrearLabel.text = "Las contraseñas no coinciden."
            self.errorCrearLabel.isHidden = false
        }

        return isValidEmail(email) && isValidPassword(pass) && isValidPassword(confPass) && pass == confPass
    }
    
    func confirmLogin() -> Bool {
        guard let email = loginEmailField.text, let pass = loginPassField.text else {
            self.errorLoginLabel.text = "Completa todos los datos."
            self.errorLoginLabel.isHidden = false
            return false
        }
        
        if !isValidEmail(email) {
            self.errorLoginLabel.text = "Correo Invalido."
            self.errorLoginLabel.isHidden = false
        }
        
        if !isValidPassword(pass) {
            self.errorLoginLabel.text = "Completa la contraseña."
            self.errorLoginLabel.isHidden = false
        }
        
        return isValidEmail(email) && isValidPassword(pass)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
      
    func isValidPassword(_ password: String) -> Bool {
        let minPasswordLength = 6
        return password.count >= minPasswordLength
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
