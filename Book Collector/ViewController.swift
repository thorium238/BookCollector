//
//  ViewController.swift
//  Book Collector
//
//  Created by Thomas Piotrowski on 8/29/16.
//  Copyright © 2016 Thomas Piotrowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var books : [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {books = try context.fetch(Book.fetchRequest())
            print("######## \(books)########")
            tableView.reloadData()
            } catch {}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.imageView?.image = UIImage(data: book.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        print("do segue back")
        performSegue(withIdentifier: "bookSegue", sender: book)
        print("did segue back")
    }
    
    /** Pass whatever is inside of send on to next view controller **/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(" before let")
        // Do I understand these next two lines?
        let nextVC = segue.destination as! BookViewController
        nextVC.book = sender as? Book // ****
        print(" after nextVC")
    }
}

