//
//  ViewController.swift
//  swiftNewFeature
//
//  Created by Ashish Kumar Maurya on 28/09/20.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    
    @IBOutlet weak var datePickView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerView.date = Date()
        datePickerView.locale = .current
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .inline
        
        let add = UIAction(title: "Add new...", image: UIImage(systemName: "plus.circle")) { (action) in
               print("Add new action was selected")
           }
           let edit = UIAction(title: "Edit", image: UIImage(systemName: "pencil.circle")) { (action) in
               print("Edit action was selected")
           }
           let delete = UIAction(title: "Delete", image: UIImage(systemName: "minus.circle"), attributes: .destructive) { (action) in
               print("Delete action was selected")
           }
        
        
        let menuItem = UIMenu(title: "Actions", children: [add, edit, delete])
        
        datePickView.showsMenuAsPrimaryAction = true
        datePickView.menu = menuItem
        
    }
    
    
    @IBAction func buttonPickerAction(_ sender: Any) {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.selectedColor = self.view.backgroundColor ?? UIColor.black
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func buttonImagePicker(_ sender: Any) {
        
    
        
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else {
            return
        }
       
        
        let navViewController = UINavigationController(rootViewController: viewController)
        navViewController.modalPresentationStyle = .custom
        navViewController.transitioningDelegate = self
        self.present(navViewController, animated: true, completion: nil)
       
    
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    
    
    @IBAction func buttonDatePicker(_ sender: Any) {
    }
    
    
    
}

class HalfSizePresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }

            return CGRect(x: 0, y: theView.bounds.height/2, width: theView.bounds.width, height: theView.bounds.height/2)
        }
    }
}
extension ViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.view.backgroundColor = viewController.selectedColor
        
    }
}

