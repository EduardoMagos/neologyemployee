//
//  EmployeesVC.swift
//  NeologyEmployee
//
//  Created by user233108 on 2/5/23.
//

import UIKit
import Alamofire

class EmployeesVC: UIViewController {
    
    @IBOutlet weak var tableEmployees: UITableView!
    var arrayEmployees: [Employee] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableEmployees.delegate = self
        self.tableEmployees.dataSource = self
        self.getEmployees()
        
    }
    
    private func getEmployees(){
        
        let url = "https://dummy.restapiexample.com/public/api/v1/employees"
        
        AF.request(url, method: .get).validate(statusCode: Constans.okStatus).responseDecodable (of: EmployeesResponse.self) {
            response in
        
            if let employees = response.value?.data {
                
                print(employees)
                
            } else {
                
                let alert = UIAlertController(title: "Error", message: "Error al obtener empleados", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
    }
    

    @IBAction func tryRequest(_ sender: UIButton) {
        
        getEmployees()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EmployeesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayEmployees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_employee", for: indexPath) as! employeeCell
        
        cell.lblName.text = arrayEmployees[indexPath.row].employee_name
        cell.lblAge.text = " \(String(describing: arrayEmployees[indexPath.row].employee_age)))"
        cell.lblSalary.text = "$ \(String(describing: arrayEmployees[indexPath.row].employee_salary))"
        
        let age = arrayEmployees[indexPath.row].employee_age
        
        if (age! >= 25 && age! <= 35) {
            cell.lblAge.textColor = .green
        } else {
            cell.lblAge.textColor = .red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Aquí ya no me dio tiempo la renta de la Mac en MacinCloud, pero aquí va lo de mostar detalle del empleado
        let empleado = arrayEmployees[indexPath.row]
        
        let storyB: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newSB = storyB.instantiateViewController(withIdentifier: "EmployeDetail") as! EmployeeVC
        
        newSB.lblNombre.text = empleado.employee_name
        newSB.lblEdad.text = "\(String(describing: empleado.employee_age))"
        newSB.lblSalario.text = "\(String(describing: empleado.employee_salary))"
        
        self.present(newSB, animated: true, completion: nil)
    }
    
    
}
