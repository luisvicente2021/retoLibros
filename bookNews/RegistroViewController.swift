///
//  RegistroViewController.swift
//  retoLibros
//
//  Created by user209759 on 1/22/22.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
   
    
    //MARK: - Definicion del primer elemento

    
    var info : UILabel?
    var productPrice : UILabel?
    var textDescripcion : UILabel?
    var descripcion : UILabel?
    var userTextField : UITextField?
    var emailTextField : UITextField?
    var passwordTextField : UITextField?
    var crearCuenta : UIButton?
    var viewBack: UIView?
    var userLogin: UILabel?
   
    
    var backButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        configureTextFields()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func configureTextFields(){
        userTextField?.delegate = self
        emailTextField?.delegate = self
        passwordTextField?.delegate = self
        
    }
    
   
    
    
    
    // iam layout of labels, button, textfields,views
    
    
    
    func initUI(){
        view.backgroundColor = .white
        viewBack = UIView(frame: CGRect(x: 0, y: 0, width: width , height: height - 200 ))
        viewBack?.backgroundColor = Constants.Storyboard.backgroundColor
        view.addSubview(viewBack!)
        
        userLogin = UILabel(frame: CGRect(x: width / 2, y: 20, width: width , height: 20 ))
        userLogin?.text = ViewController().userLogin?.text
        viewBack?.addSubview(userLogin!)
        
        backButton = UIButton(frame: CGRect(x: 4, y: 30, width: 40, height: 40))
        backButton?.setImage(UIImage(named: "back"), for: .normal)
        backButton?.addTarget(self, action:#selector(backAction) , for: .touchUpInside)
        viewBack?.addSubview(backButton!)
        
        
        info = UILabel()
        info?.text = "Resgistra tu informacion"
        info?.backgroundColor = .clear
        info?.textAlignment = .center
        info?.font = .boldSystemFont(ofSize: 20)
        viewBack?.addSubview(info!)
        info?.addAnchorsAndSize(width: width / 2, height: 50, left: 20, top: 50, right: 20, bottom: nil, withAnchor: nil, relativeToView: nil)
        
  
        
        userTextField = UITextField(frame: CGRect(x: 20, y: 110, width: width - 40, height: 40))
        userTextField?.backgroundColor = .white
        userTextField?.placeholder = "  Ingresa tu Usuario"
        userTextField?.layer.borderColor = UIColor.blue.cgColor
        userTextField?.layer.borderWidth = 1
        userTextField?.layer.cornerRadius = 7
        viewBack?.addSubview(userTextField!)
        
        emailTextField = UITextField(frame: CGRect(x: 20, y: 160, width: width - 40, height: 40))
        emailTextField?.backgroundColor = .white
        emailTextField?.placeholder = "  Ingresa tu Correo"
        emailTextField?.layer.borderColor = UIColor.blue.cgColor
        emailTextField?.layer.borderWidth = 1
        emailTextField?.layer.cornerRadius = 7
        viewBack?.addSubview(emailTextField!)
        
        passwordTextField = UITextField(frame: CGRect(x: 20, y: 210, width: width - 40, height: 40))
        passwordTextField?.backgroundColor = .white
        passwordTextField?.placeholder = "  Ingresa tu Password"
        passwordTextField?.layer.borderColor = UIColor.blue.cgColor
        passwordTextField?.layer.borderWidth = 1
        passwordTextField?.isSecureTextEntry = true
        passwordTextField?.layer.cornerRadius = 7
        view.addSubview(passwordTextField!)
        
  
        
     
        crearCuenta = UIButton()
        crearCuenta?.backgroundColor = .purple
        crearCuenta?.tintColor = .white
        crearCuenta?.layer.cornerRadius = 7
        
        crearCuenta?.setTitle("Crear Cuenta", for: .normal)
        
        crearCuenta?.addTarget(self, action: #selector(registrarAction), for: .touchUpInside)
        
        view.addSubview(crearCuenta!)
        crearCuenta?.addAnchorsAndSize(width: width - 40, height: 40, left: 20, top: 10, right: 20, bottom: nil, withAnchor: .top, relativeToView: passwordTextField)
        
        
    }
    
    
    
    
    @objc func registrarAction(){
        if emailTextField?.text?.isEmpty == true {
            print ("No hay texto")
            return
        }
        if passwordTextField?.text?.isEmpty == true {
            
            print ("No hay pasword")
            
        }
        
        signUp()
    }
    
    
    func signUp() {
        
        if let email = emailTextField?.text , let password = passwordTextField?.text {
        
        Auth.auth().createUser(withEmail: emailTextField?.text ?? "", password: passwordTextField?.text ?? "") { authResult, error in
            if let result = authResult?.user, error == nil  {
                                
            print("Back")
            self.dismiss(animated: true)
                
                
            }else {
                print ("Error\(error?.localizedDescription)")

                let alertController = UIAlertController(title: "Error", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                
            self.present(alertController, animated: true, completion: nil )
                
            }
            
            
        }
            
        
            
            
            
            
            
        }
        
    }
    
    
    @objc func backAction(){
        print("Back")
        dismiss(animated: false)
    }
    
 

}


extension RegisterViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
