//
//  ViewController.swift
//  ContainerDemo
//
//  Created by Prashant Ugale on 23/05/16.
//  Copyright © 2016 Leftshift Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    var storyBoard:UIStoryboard?
    var firstController:FirstViewController?
    var secondController:SecondViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        firstButton.addTarget(self, action: "firstButtonClicked:", forControlEvents: .TouchUpInside)
        secondButton.addTarget(self, action: "secondButtonClicked:", forControlEvents: .TouchUpInside)
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        firstController = storyBoard!.instantiateViewControllerWithIdentifier("firstController") as? FirstViewController
        secondController = storyBoard?.instantiateViewControllerWithIdentifier("secondController") as? SecondViewController
        addSecondController()
        addFirstController()
    }
    
    private func addFirstController() {
        if let loadedController:FirstViewController = firstController {
            self.addChildViewController(loadedController)
            loadedController.view.frame = CGRectMake(0, 80, self.view.frame.width, self.view.frame.height - 80)
            self.view.addSubview(loadedController.view)
            loadedController.didMoveToParentViewController(self)
        }
    }
    
    private func addSecondController() {
        if let loadedController:SecondViewController = secondController {
            self.addChildViewController(loadedController)
            loadedController.view.frame = CGRectMake(0, 80, self.view.frame.width, self.view.frame.height - 80)
            self.view.addSubview(loadedController.view)
            loadedController.didMoveToParentViewController(self)
        }
    }
    
    private func removeChildController(ChildController controller:UIViewController) {
        controller.willMoveToParentViewController(nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
    
    private func transitionInControllers(FirstController newController:UIViewController, SecondController oldController:UIViewController, isPushAnimation animation:Bool) {
        oldController.willMoveToParentViewController(nil)
        self.addChildViewController(newController)
        let endFrame:CGRect?
        if animation == true {
            newController.view.frame = CGRectMake(self.view.frame.width, 80, self.view.frame.width, self.view.frame.height - 80)
            endFrame = CGRectMake(0 - self.view.frame.width, 80, self.view.frame.width, self.view.frame.height - 80)
        } else {
            newController.view.frame = CGRectMake(0 - self.view.frame.width, 80, self.view.frame.width, self.view.frame.height - 80)
            endFrame = CGRectMake(self.view.frame.width, 80, self.view.frame.width, self.view.frame.height - 80)
        }
        
        self.transitionFromViewController(oldController, toViewController: newController, duration: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                newController.view.frame = oldController.view.frame
                oldController.view.frame = endFrame!
            
            }) { (success) -> Void in
                oldController.removeFromParentViewController()
                newController.didMoveToParentViewController(self)
        }
    }
    
    func firstButtonClicked(sender:AnyObject) {
//        if let loadedController:SecondViewController = secondController {
//            if !loadedController.view.isDescendantOfView(self.view) {
//                removeChildController(ChildController: loadedController)
//            }
//        }
//        addFirstController()
        
        if let first:FirstViewController = firstController,
            let second:SecondViewController = secondController {
                if second.view.isDescendantOfView(self.view) {
                    transitionInControllers(FirstController: first, SecondController: second, isPushAnimation: false)
                }
        }
    }
    
    func secondButtonClicked(sender:AnyObject) {
//        if let loadedController:FirstViewController = firstController {
//            if !loadedController.view.isDescendantOfView(self.view) {
//                removeChildController(ChildController: loadedController)
//            }
//        }
//        addSecondController()
        if let first:FirstViewController = firstController,
            let second:SecondViewController = secondController {
                if first.view.isDescendantOfView(self.view) {
                    transitionInControllers(FirstController: second, SecondController: first, isPushAnimation: true)
                }
        }
        
    }

}

