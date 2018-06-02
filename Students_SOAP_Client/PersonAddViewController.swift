//
//  PersonAddViewController.swift
//  Students_SOAP_Client
//
//  Created by Valentin Nacharov on 02.06.2018.
//  Copyright © 2018 Valentin Nacharov. All rights reserved.
//

import UIKit

class PersonAddViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var student: GSPstudentXML = GSPstudentXML()
    @IBOutlet var groupIdPicker: UIPickerView!
    @IBOutlet var birthDatePicker: UIDatePicker!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var middleNameTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    var getAllStudentGroupsResponse: [GSPstudentGroupXML]?
    var service = GSPStudentWebServiceSoapBinding(url:"http://0.0.0.0:8080/student")
    var  error:Error?
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return (getAllStudentGroupsResponse?.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getAllStudentGroupsResponse![row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        student.studentGroupXML = try! service.getStudentGroup(arg0: getAllStudentGroupsResponse![row].id, __error: &error) as! GSPstudentGroupXML
        print("Picker choose: "+(student.studentGroupXML?.name)!)
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataWhenStudentIsPassedFromSeque()
        getAllGroups()
        groupIdPicker.dataSource = self
        groupIdPicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addPersonAction(_ sender: Any) {
       student.firstName = firstNameTextField.text
        student.lastName = lastNameTextField.text
        student.middleName = middleNameTextField.text
        student.homeAddress = addressTextField.text
        try! service.saveStudent(arg0: student, __error: &error)
    }
    
    
    
    func getAllGroups() -> Void {
        let smt:GSPgetAllStudentGroupResponse = try! service.getAllStudentGroup(__error: &error) as! GSPgetAllStudentGroupResponse
        getAllStudentGroupsResponse = smt.contents as? [GSPstudentGroupXML]
    }
    @IBAction func datePickerAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="yyyy-MM-dd"
        student.dateOfBirth = dateFormatter.string(from: birthDatePicker.date as Date)
        print("Date changed"+student.dateOfBirth!)
    }
    
    func setDataWhenStudentIsPassedFromSeque() -> Void {
         firstNameTextField.text = student.firstName
         lastNameTextField.text = student.lastName
         middleNameTextField.text = student.middleName
         addressTextField.text = student.homeAddress
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        birthDatePicker.date = dateFormatter.date(from: (student.dateOfBirth)!)!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
