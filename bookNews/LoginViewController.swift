//
//  LoginViewController.swift
//  bookNews
//
//  Created by user209759 on 3/25/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth



class LoginViewController: UIViewController {
   
    var correo : UITextField?
    var pasword : UITextField?
    var defaults = UserDefaults.standard
    var nextButton: UIButton?
    var userLabel : UILabel?
    var botonSesion : UIButton?
    var botonRegistrate : UIButton?
    var botonLogout : UIButton?
    var nextLabel : UILabel?
    var identifier = "LoginViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
        initUI()
        configureTextFields()
        configureTapGesture()
        
        
    }
    
   
    private func configureTextFields() {
        
        correo?.delegate = self
        pasword?.delegate = self
        
    }
    
    private func configureTapGesture()
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (LoginViewController.handleTap))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        print("Handle Tap ws called")
        view.endEditing(true)
        
        
        
    }
    
    
    
    
    func initUI(){
       
        
        
        var width = UIScreen.main.bounds.width
        var height = UIScreen.main.bounds.height
        
        
        
       
        
        
       correo = UITextField(frame: CGRect(x: 20, y: 220, width: width - 40, height: 50))
        correo?.backgroundColor = .white
        correo?.placeholder = "  Ingresa tu Usuario"
        correo?.autocapitalizationType = .none
        correo?.layer.borderColor = UIColor.blue.cgColor
        correo?.layer.borderWidth = 1
        correo?.layer.cornerRadius = 7
        view.addSubview(correo!)
        
        
        pasword = UITextField(frame: CGRect(x: 20, y: 290, width: width - 40, height: 50))
        pasword?.backgroundColor = .white
        pasword?.placeholder = "  Ingresa Password"
        pasword?.layer.borderColor = UIColor.blue.cgColor
        //pasword?.isSecureTextEntry = true
        pasword?.layer.borderWidth = 1
        pasword?.layer.cornerRadius = 7
       
        view.addSubview(pasword!)
        
        
        botonSesion = UIButton (frame: CGRect(x: 100, y: width / 4, width: width - 200, height: 40))
        botonSesion = UIButton()
        botonSesion?.backgroundColor = .blue
        botonSesion?.tintColor = .white
        botonSesion?.layer.cornerRadius = 7
        botonSesion?.setTitle("Login", for: .normal)
        botonSesion?.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        view.addSubview(botonSesion!)
        
        
        
        
        
        
        
        botonRegistrate = UIButton (frame: CGRect(x: 170, y: 50, width: width - 200, height: 40))
        botonRegistrate?.backgroundColor = .purple
        botonRegistrate?.layer.cornerRadius = 7
        botonRegistrate?.tintColor = .white
        botonRegistrate?.setTitle("Sign in", for: .normal)
        botonRegistrate?.addTarget(self, action: #selector(registrarAction), for: .touchUpInside)
        
       view.addSubview(botonRegistrate!)
            
    }
   
   
    @objc func registrarAction(){
        
    
        
        print("Button Press")
        let registro = RegistroViewController()
        registro.modalPresentationStyle = .fullScreen
        present(registro, animated: true, completion: {
            print("Ya se termino de presentar :)")
        }) // Aqui presentamos el viewController, animado y sin usar completion
        
        
    }
    
    
    
    
    
    
    @objc func nextView(){
        let register =  DashBoardViewController()
        register.modalPresentationStyle = .fullScreen
        present(register, animated: true, completion: nil)
      }
    
    
    
   
    
    func  validateFields () {
        if correo?.text?.isEmpty == true {
            
            print ("No hay correo")
            return
        }
        
        if pasword?.text?.isEmpty == true {
            print("No hay password")
            return
        }
        
        
        
        
    }
    
    func login () {
        
        let email = correo?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = pasword?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            
            
           
            
            if   error != nil {
                print(error?.localizedDescription)
                
                
            }
            else {
                
                print("Aui esta la falla")
                
                let dash = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.dash) as? DashBoardViewController
                self.view.window?.rootViewController = dash
                self.view.window?.makeKeyAndVisible()
                
                
            }
           
        }
        
    }
    
   
        
  
   
    @objc func loginAction(_ sender : Any){
       
        view.endEditing(true)
       login()
          
            
        }
        

      
            
        }
 
            
extension LoginViewController : UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
}
            
                    
            
        


