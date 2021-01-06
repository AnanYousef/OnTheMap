//
//  StudentsLocationTableVC.swift
//  On The Map
//
//  Created by Anan Yousef on 05/01/2021.
//

import UIKit

class StudentsLocationTableVC: Base, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var studentLocation: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStudentsList()
    }
    
    private func getStudentsList(_ reset: Bool = false) {
        getStudentsList(successHandler: {_ in self.studentLocation.reloadData()}, reset: reset)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return studentLocationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationCell")
        
        let studentLocation = studentLocationList[indexPath.row]
        
        cell?.textLabel?.text = parseStundentName(studentLocation)
        
        cell?.detailTextLabel?.text = studentLocationList[indexPath.row].mediaURL
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let subtitle: String = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text else { return }
        
        openBroweserIfValidMediaURL(subtitle)
    }
    
    @IBAction func logout(_ sender: Any) {
        performLogout()
    }
    
    @IBAction func addLocation(_ sender: Any) {
        AddLocation()
    }
    
    @IBAction func reload(_ sender: Any) {
        getStudentsList(true)
        
    }
    
}
