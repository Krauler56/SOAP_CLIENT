//
//  ViewController.swift
//  Students_SOAP_Client
//
//  Created by Valentin Nacharov on 02.06.2018.
//  Copyright © 2018 Valentin Nacharov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var service = GSPStudentWebServiceSoapBinding(url:"http://0.0.0.0:8080/student")
        var  error:Error?
        var smt = try? service.getAllStudent(__error: &error)
        try print(smt!![0]?.firstName)
            
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

