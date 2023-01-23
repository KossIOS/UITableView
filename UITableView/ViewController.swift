//
//  ViewController.swift
//  UITableView
//
//  Created by Konstantyn Koroban on 6/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var contacts = [ContactProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }
    
    @IBAction func showNewContactAlert() {
        let alertController = UIAlertController(
            title: "Create new contact",
            message: "Enter the name and phone number",
            preferredStyle: .alert
        )
        alertController.addTextField { textField in textField.placeholder = "Name" }
        alertController.addTextField { textField in textField.placeholder = "Phone number" }
        let createButton = UIAlertAction(title: "Create", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text,
                  let contactPhone = alertController.textFields?[1].text
            else {
                return
            }
            
            let contact = Contact(title: contactName, phone: contactPhone)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelButton)
        alertController.addAction(createButton)
        self.present(alertController, animated: true, completion: nil)
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete" ) { _, _, _ in
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell" )
        }
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        configuration.image = UIImage(systemName: "person")
        cell.contentConfiguration = configuration
    }
    
    private func loadContacts() {
        contacts.append(
            Contact(title: "Max Work" , phone: "+48234235423452"))
        contacts.append(
            Contact(title: "Anna Wife", phone: "+48213123134432"))
        contacts.append(
            Contact(title: "Kamilla daughter", phone: "+484534534515009"))
        contacts.append(
            Contact(title: "Alex Friend" , phone: "+48234235423452"))
        contacts.append(
            Contact(title: "Mateusz Shef" , phone: "+48455555555555"))
    }
}



