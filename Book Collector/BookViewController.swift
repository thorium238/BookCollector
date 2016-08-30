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
 
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
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
        
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let book = Book(context: context)
       
        book.title = titleTextField.text
        book.image = UIImagePNGRepresentation(bookImageView.image!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()   
        
    }

}
