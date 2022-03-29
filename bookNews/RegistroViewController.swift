///
//  RegistroViewController.swift
//  retoLibros
//
//  Created by user209759 on 1/22/22.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistroViewController: UIViewController {

    var topImageView : UIImageView?
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    var backgroundColor = UIColor(displayP3Red: 63/255, green: 193/255, blue: 219/255, alpha: 1)
    var identifier = "RegistroViewController"
    
    //MARK: - Definicion del primer elemento
    var productContentView : UIView?
    var descriptionView : UIView?
    var productImage : UIImageView?
    var productCard : UIView?
    var productCard2 : UIView?
    var registraTuInfo : UILabel?
    var info : UILabel?
    var productPrice : UILabel?
    var textDescripcion : UILabel?
    var descripcion : UILabel?
    var defaults = UserDefaults.standard
    var usuarioTextField : UITextField?
    var correoTextField : UITextField?
    var passwordTextField : UITextField?
    var confirmarTextField : UITextField?
    var crearCuenta : UIButton?
   
    
    var backButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColor
        
        initUI()
        configureTextFields()
    }
    func configureTextFields(){
        usuarioTextField?.delegate = self
        correoTextField?.delegate = self
        passwordTextField?.delegate = self
        //confirmarTextField?.delegate = self
            
        
        
    }
    
    func userLogged(name : String, pass : String){
        
         let inicio = ViewController ()
            print("Back")
            dismiss(animated: true)
         //inicio.modalPresentationStyle = .fullScreen
         //present(inicio, animated: true, completion: {
        //print("Volvenos a Login :)")})
        
    }
    
    
    func initUI(){
        topImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width , height: height/4))
        topImageView?.image = UIImage(named: "userNew")
        view.addSubview(topImageView!)
        
        backButton = UIButton(frame: CGRect(x: 4, y: 100, width: 40, height: 40))
        //backButton?.setTitle("Regresar", for: .normal)
        backButton?.setImage(UIImage(named: "back"), for: .normal)
        backButton?.addTarget(self, action:#selector(backAction) , for: .touchUpInside)
        view.addSubview(backButton!)
        
        createProductView()
        
    }
    
    
    
    
    func createProductView(){
        
        
       // info = UILabel(frame: CGRect(x: 0, y:80 , width: (width - 40) , height: 30))
        //info?.text = "Estas a unos pasos de vivir la mejor experiencia"
        //info?.backgroundColor = .clear
        //info?.textAlignment = .center
        //info?.font = .boldSystemFont(ofSize: 10)
        //view?.addSubview(info!)
        
         
        
        
        
        
       // registraTuInfo = UILabel(frame: CGRect(x: 0 + 30, y:10 , width: (width - 40) , height: 30))
        //registraTuInfo?.text = "Registra tu informacion"
        //registraTuInfo?.backgroundColor = .clear
        //registraTuInfo?.textAlignment = .center
        //registraTuInfo?.font = .boldSystemFont(ofSize: 16)
        //view?.addSubview(registraTuInfo!)
        
        
        //var usuarioTextField : UITextField?
        //var correoTextField : UITextField?
        //var passwordTextField : UITextField?
        //var confirmarTextField : UITextField?
        
        usuarioTextField = UITextField(frame: CGRect(x: 20, y: 150, width: width - 40, height: 40))
       usuarioTextField?.backgroundColor = .white
        usuarioTextField?.placeholder = "  Ingresa tu Usuario"
        usuarioTextField?.layer.borderColor = UIColor.blue.cgColor
        usuarioTextField?.layer.borderWidth = 1
        usuarioTextField?.layer.cornerRadius = 7
        view.addSubview(usuarioTextField!)
        
        correoTextField = UITextField(frame: CGRect(x: 20, y: 210, width: width - 40, height: 40))
        correoTextField?.backgroundColor = .white
        correoTextField?.placeholder = "  Ingresa tu Correo"
        correoTextField?.layer.borderColor = UIColor.blue.cgColor
        correoTextField?.layer.borderWidth = 1
        correoTextField?.layer.cornerRadius = 7
        view.addSubview(correoTextField!)
        
        passwordTextField = UITextField(frame: CGRect(x: 20, y: 270, width: width - 40, height: 40))
        passwordTextField?.backgroundColor = .white
        passwordTextField?.placeholder = "  Ingresa tu Password"
        passwordTextField?.layer.borderColor = UIColor.blue.cgColor
        passwordTextField?.layer.borderWidth = 1
        //passwordTextField?.isSecureTextEntry = true
        passwordTextField?.layer.cornerRadius = 7
        view.addSubview(passwordTextField!)
        
        
        
        
        
        
        
       
        
        
        
       
        
        crearCuenta = UIButton(frame: CGRect(x: 60, y: 450, width: width - 120, height: 40))
        crearCuenta?.backgroundColor = .blue
        
        crearCuenta?.tintColor = .white
        crearCuenta?.layer.cornerRadius = 7
        
        crearCuenta?.setTitle("CREAR CUENTA", for: .normal)
        
        crearCuenta?.addTarget(self, action: #selector(registrarAction), for: .touchUpInside)
        
        view.addSubview(crearCuenta!)
        
        
    }
    
    
    
    
    @objc func registrarAction(){
        if correoTextField?.text?.isEmpty == true {
            print ("No hay texto")
            return
        }
        if passwordTextField?.text?.isEmpty == true {
            
            print ("No hay pasword")
            
        }
        
        signUp()
    }
    
    
    func signUp() {
        
        if let email = correoTextField?.text , let password = passwordTextField?.text {
        
        Auth.auth().createUser(withEmail: correoTextField?.text ?? "", password: passwordTextField?.text ?? "") { authResult, error in
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
        dismiss(animated: true)
    }
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///
    
    

}

extension RegistroViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
