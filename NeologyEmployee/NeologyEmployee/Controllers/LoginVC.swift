//
//  LoginVC.swift
//  NeologyEmployee
//
//  Created by user233108 on 2/5/23.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtIDEmployee: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    
    @IBAction func makeLogin(_ sender: UIButton) {
        
        let idEmployee = Int(txtIDEmployee.text ?? "")!

        let urlEmployee = "https://dummy.restapiexample.com/api/v1/employee/\(idEmployee)"
        
        AF.request(urlEmployee, method: .get).validate(statusCode: Constans.okStatus).responseDecodable (of: EmployeeResponse.self) {
            response in
            
            if let idEmployee = response.value?.data?.id {
                print(idEmployee)
                
                let storyB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newSB = storyB.instantiateViewController(withIdentifier: "EmployeeList") as! EmployeesVC
                self.present(newSB, animated: true, completion: nil)
                
                
            } else {
                
                let alert = UIAlertController(title: "Error", message: "Error al iniciar sesión", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    
}
