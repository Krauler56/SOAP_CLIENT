//
//  PersonsTableViewController.swift
//  Students_SOAP_Client
//
//  Created by Valentin Nacharov on 02.06.2018.
//  Copyright © 2018 Valentin Nacharov. All rights reserved.
//

import UIKit

class PersonsTableViewController: UITableViewController {

    
    var sizeOfTableViewController: Int?
    var getAllPeopleResponse: [GSPstudentXML]?
    var service = GSPStudentWebServiceSoapBinding(url:"http://0.0.0.0:8080/student")
    var  error:Error?
    var passedStudent: GSPstudentXML = GSPstudentXML()
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//(getAllPeopleResponse?.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (getAllPeopleResponse?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonsTableViewCell
        
        cell.firstNameLabel.text = getAllPeopleResponse![indexPath.row].firstName
         cell.lastNameLabel.text = getAllPeopleResponse![indexPath.row].lastName
        cell.middleNameLable.text = getAllPeopleResponse![indexPath.row].middleName
        cell.birthDateLabel.text = getAllPeopleResponse![indexPath.row].dateOfBirth
        cell.groupIdLabel.text = getAllPeopleResponse![indexPath.row].studentGroupXML?.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passedStudent = (getAllPeopleResponse?[indexPath.row])!
        super.performSegue(withIdentifier: "toPersonEditSeg", sender: self)
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
             //var service = GSPStudentWebServiceSoapBinding(url:"http://0.0.0.0:8080/student")
            try! service.deleteStudent(arg0: getAllPeopleResponse![indexPath.row].id, __error: &error)
            refreshTableView()
        
            //tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func refreshTableView() -> Void {
        var smt:GSPgetAllStudentResponse = try! service.getAllStudent(__error: &error) as! GSPgetAllStudentResponse
        getAllPeopleResponse = smt.contents as! [GSPstudentXML]
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
          
        if segue.identifier == "toPersonEditSeg" {
            if let destination = segue.destination as? PersonAddViewController{
                destination.student = passedStudent
            }
        }
    }
    
 

}
