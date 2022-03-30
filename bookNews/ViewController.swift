
//
//
//  ViewController.swift
//  bookNews
//
//  Created by user209759 on 3/24/22.
//

import FirebaseAuth
import Firebase
import UIKit


class ViewController: UIViewController{
    
 
    
    
    var email : UITextField?
    var pasword : UITextField?
    var nextButton: UIButton?
    var botonSesion : UIButton?
    var botonRegistrate : UIButton?
    var viewBack: UIView?
    var welcomeLabel: UILabel?
    var userLogin : UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        initUI()
        
       
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let name : String? = UserDefaults.standard.object(forKey: "name") as? String
        
        if let nameToDisplay = name {
            userLogin?.text = nameToDisplay
           userLogin?.font = .boldSystemFont(ofSize: 12)
            
            
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func saveUser () {
        
        UserDefaults.standard.set(email?.text, forKey: "name")
        
        
    }
    
    
    
    
    func configureTextFields(){
        email?.delegate = self
        pasword?.delegate = self
        
    }
    
    func initUI(){
        
               
        var width = UIScreen.main.bounds.width
        var height = UIScreen.main.bounds.height
        view.backgroundColor = .white
     
        
        
        viewBack = UIView(frame: CGRect(x: 0, y: 0, width: width , height: height - 200 ))
        viewBack?.backgroundColor = Constants.Storyboard.backgroundColor
        view.addSubview(viewBack!)
        
        //userLogin = UILabel(frame: CGRect(x: width / 2, y: 20, width: width , height: 20 ))
        //userLogin?.textColor = .red
        //viewBack?.addSubview(userLogin!)
        
        
        
        welcomeLabel = UILabel(frame: CGRect(x: 20, y: 20, width: width / 2 , height: 50))
        welcomeLabel?.text = "Bienvenido"
        welcomeLabel?.backgroundColor = .clear
        welcomeLabel?.textAlignment = .center
        welcomeLabel?.font = .boldSystemFont(ofSize: 30)
        viewBack?.addSubview(welcomeLabel!)
        welcomeLabel?.center = CGPoint (x: width / 2, y : 100)
        
        email = UITextField()
        email?.backgroundColor = .white
        email?.placeholder = "  Ingresa tu Usuario"
        email?.layer.borderColor = UIColor.blue.cgColor
        email?.layer.borderWidth = 1
        email?.layer.cornerRadius = 7
        email?.translatesAutoresizingMaskIntoConstraints = false
        viewBack?.addSubview(email!)
        email?.addAnchorsAndSize(width: width / 2, height: 50, left: 20, top: 40, right: 20, bottom: nil, withAnchor: .top, relativeToView: welcomeLabel)

        
        
        pasword = UITextField()
        pasword?.center = CGPoint(x: width / 2, y: 290)
        pasword?.backgroundColor = .white
        pasword?.placeholder = "  Ingresa Password"
        pasword?.layer.borderColor = UIColor.blue.cgColor
        pasword?.isSecureTextEntry = true
        pasword?.layer.borderWidth = 1
        pasword?.layer.cornerRadius = 7
        viewBack?.addSubview(pasword!)
        pasword?.addAnchorsAndSize(width: width / 2, height: 50, left: 20, top: 10, right: 20, bottom: nil, withAnchor: .top, relativeToView: email)
       
      
        
        botonSesion = UIButton()
        botonSesion?.backgroundColor = .blue
        botonSesion?.center = CGPoint(x: width / 2, y: 360)
        botonSesion?.tintColor = .white
        botonSesion?.layer.cornerRadius = 7
        botonSesion?.setTitle("Login", for: .normal)
        botonSesion?.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        view.addSubview(botonSesion!)
        botonSesion?.addAnchorsAndSize(width: width / 2, height: 40, left: 20, top: 20, right: width / 2 , bottom: nil, withAnchor: .top, relativeToView: pasword)

   
        botonRegistrate = UIButton()
        botonRegistrate?.backgroundColor = .purple
        botonRegistrate?.center = CGPoint(x: width / 2, y: 420)
        botonRegistrate?.layer.cornerRadius = 7
        botonRegistrate?.tintColor = .white
        botonRegistrate?.setTitle("Sign in", for: .normal)
        botonRegistrate?.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        view.addSubview(botonRegistrate!)
        botonRegistrate?.addAnchorsAndSize(width: width / 2, height: 40, left: width / 2 , top: 20, right: 20  , bottom: nil, withAnchor: .top, relativeToView: pasword)
            
    }
   
   
    @objc func registerAction(){
        
    
        
        
        let register = RegisterViewController()
        register.modalPresentationStyle = .fullScreen
        present(register, animated: false, completion: nil )
        
        
    }
    
    @objc func nextDashBoard(){
        let register =  DashBoardViewController()
        register.modalPresentationStyle = .fullScreen
        present(register, animated: true, completion: nil)
      }
    
    
    
    
    
    @objc func loginAction(){
        
        if let email = email?.text , let password = pasword?.text {
        
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { authResult, error in
            if let result = authResult?.user, error == nil  {
                self.saveUser()
                self.nextDashBoard()
                
            }else {
                print ("Error\(error?.localizedDescription)")

                let alertController = UIAlertController(title: "Error", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                
            self.present(alertController, animated: true, completion: nil )
                
                }
            
            
            }
            
          
            
        }
   
        
    }

}

extension ViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
