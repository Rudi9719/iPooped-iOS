//
//  ViewController.swift
//  iPooped
//
//  Created by Gregory Rudolph-Alverson on 10/26/16.
//  Copyright © 2016 STEiN-Net. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate,
    UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate, UITextFieldDelegate {




    @IBOutlet weak var ratingPicker: UIPickerView!
    @IBOutlet weak var pictureBool: UISwitch!
    @IBOutlet weak var friendsBool: UISwitch!
    @IBOutlet weak var tacoBellBool: UISwitch!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var noteText: UITextField!
    
    var pickerData: [String] = [String]()
    let imagePicker = UIImagePickerController()
    var pooPic: UIImage?
    let locationManager = CLLocationManager()
    var smelly: Poop?
    var picSet = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        imagePicker.delegate = self
        ratingPicker.delegate = self
        ratingPicker.dataSource = self
        noteText.delegate = self
        
        pickerData = ["Awesome", "Good", "Okay", "Average", "Eh", "Meh",
                      "Shitty", "Wtf", "Oh shit", "Call 911"]
        
        ratingPicker.selectRow(3, inComponent: 0, animated: true)
        
        nextBtn.layer.cornerRadius = 10.0;

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Actions
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        let pic = pictureBool.isOn
        let share = friendsBool.isOn
        let tacoBell = tacoBellBool.isOn
        let location = locationManager.location! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        smelly = Poop(loc: center, rating: ratingPicker.selectedRow(inComponent: 0), note: noteText.text, picture: pooPic)

        if (tacoBell) {
            
        }
        
        if (pic) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            sharePoo(doIt: share, pic: pic)
        }
        

        
       
    }
    
    @IBAction func cancelShit(_ sender: UIButton) {
        
       self.dismiss(animated: true, completion: nil)
    }

    func sharePoo(doIt: Bool, pic: Bool) {
        if (doIt) {
            
            var objectsToShare: [Any]
            var textToShare = "I just took a \(pickerData[ratingPicker.selectedRow(inComponent: 0)]) poop!"
            if (noteText.text != "") {
                textToShare = "I just took a \(pickerData[ratingPicker.selectedRow(inComponent: 0)]) poop! \(noteText.text!)"
            }
            if (pic) {
                objectsToShare = [textToShare, pooPic!] as [Any]
            }
            else {
                objectsToShare = [textToShare]
            }
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = self.view
            present(activityVC, animated: true, completion: nil)
        }
        savePoo()
    }


    
    func savePoo() {
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            pooPic = pickedImage
            smelly?.pic = pickedImage
        }
        
        self.dismiss(animated: true, completion: {
            self.sharePoo(doIt: self.friendsBool.isOn, pic: self.pictureBool.isOn)
            
        })
    }
    
    
    
    // MARK: UIPickerViewDelegate
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    


}

