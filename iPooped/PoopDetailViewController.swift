//
//  PoopDetailViewController.swift
//  iPooped
//
//  Created by Gregory Rudolph-Alverson on 11/15/16.
//  Copyright © 2016 STEiN-Net. All rights reserved.
//

import UIKit

class PoopDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var poopPicView: UIImageView!
    @IBOutlet weak var poopDatetime: UILabel!
    @IBOutlet weak var poopRate: UILabel!
    @IBOutlet weak var poopNote: UITextView!
    
    var smelly: Poop?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let smelly = smelly {
            poopDatetime.text = smelly.datetime
            poopRate.text = smelly.pickerData[smelly.rate]
            if let notes = smelly.notes {
                poopNote.text = notes
            } else {
                poopNote.text = "No notes saved."
            }
            if let pic = smelly.pic {
                    poopPicView.image = pic
            }
           
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateShit(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindHomeAgain", sender: self)
    }
    @IBAction func deleteShit(_ sender: UIButton) {
        smelly = nil
        self.performSegue(withIdentifier: "unwindHomeAgain", sender: self)
    }
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        poopPicView.image = selectedImage
        smelly?.pic = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
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
