//
//  Employee.swift
//  NeologyEmployee
//
//  Created by user233108 on 2/5/23.
//

import Foundation

struct EmployeesResponse: Decodable {
    let status: String?
    let data: [Employee]?
    let message: String?
}

struct EmployeeResponse: Decodable {
    let status: String?
    let data: Employee?
    let message: String?
}

struct Employee: Decodable {
    let id: Int?
    let employee_name: String?
    let employee_salary: Float?
    let employee_age: Int?
    let profile_image: String?
}
