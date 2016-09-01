//
//  BookViewController.swift
//  Book Collector
//
//  Created by Thomas Piotrowski on 8/29/16.
//  Copyright © 2016 Thomas Piotrowski. All rights reserved.
//

import UIKit

class BookViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    var imagePicker = UIImagePickerController()
    // for upd/del. If nil then no book to update or delete
    var book : Book? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        if book != nil { // then add picture here and title in there ...
            print("We have a book")
            bookImageView.image = UIImage(data: book!.image as! Data)
            titleTextField.text = book!.title
            addUpdateButton.setTitle("UpD", for: .normal)
        } else {print("We have no book")
        deleteButton.isHidden = true}
    }

    @IBAction func photosTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Info about what has been selected also an info dictionary.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        bookImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
        if book != nil {
            book!.title = titleTextField.text
            book!.image = NSData(data:UIImagePNGRepresentation(bookImageView.image!)!)
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let book = Book(context: context)
            book.title = titleTextField.text
            book.image = NSData(data:UIImagePNGRepresentation(bookImageView.image!)!)
        }
        //book.image = UIImagePNGRepresentation(bookImageView.image!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(book!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)

    }
    
}
