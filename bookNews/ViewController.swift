
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
    
 
    
    
    var correo : UITextField?
    var pasword : UITextField?
    var defaults = UserDefaults.standard
    var nextButton: UIButton?
    var userLabel : UILabel?
    var botonSesion : UIButton?
    var botonRegistrate : UIButton?
    var botonLogout : UIButton?
    var nextLabel : UILabel?
   
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        initUI()
        
        
        

        
            
    }
    
    
    
    func initUI(){
        
        var topImageView : UIImageView?
        var imagenlibro : UIImageView?
        
        
        var width = UIScreen.main.bounds.width
        var height = UIScreen.main.bounds.height
        
        
        
       
        topImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height/3))
        topImageView?.image = UIImage(named: "topimage")
        view.addSubview(topImageView!)
        
        correo = UITextField(frame: CGRect(x: 20, y: 220, width: width - 40, height: 50))
        correo?.backgroundColor = .white
        correo?.placeholder = "  Ingresa tu Usuario"
        correo?.layer.borderColor = UIColor.blue.cgColor
        correo?.layer.borderWidth = 1
        correo?.layer.cornerRadius = 7
        view.addSubview(correo!)
        
        
        pasword = UITextField(frame: CGRect(x: 20, y: 290, width: width - 40, height: 50))
        pasword?.backgroundColor = .white
        pasword?.placeholder = "  Ingresa Password"
        pasword?.layer.borderColor = UIColor.blue.cgColor
        pasword?.isSecureTextEntry = true
        pasword?.layer.borderWidth = 1
        pasword?.layer.cornerRadius = 7
       
        view.addSubview(pasword!)
        
        botonSesion = UIButton (frame: CGRect(x: 20, y: 450, width: width - 200, height: 40))
        botonSesion?.backgroundColor = .blue
        botonSesion?.tintColor = .white
        botonSesion?.layer.cornerRadius = 7
        botonSesion?.setTitle("Login", for: .normal)
        botonSesion?.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        
        view.addSubview(botonSesion!)
        
        
        
        botonRegistrate = UIButton (frame: CGRect(x: 170, y: 450, width: width - 200, height: 40))
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
    
    
    @objc func loginAction(){
        
        if let email = correo?.text , let password = pasword?.text {
        
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { authResult, error in
            if let result = authResult?.user, error == nil  {
                                
                self.nextView()
                
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
