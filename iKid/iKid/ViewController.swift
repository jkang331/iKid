//
//  ViewController.swift
//  iKid
//
//  Created by iGuest on 5/1/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var firstViewController : GJVC_1!
    private var secondViewController : GJVC_2!
    private var firstPJVC : PJVC_1!
    private var secondPJVC : PJVC_2!
    private var currentJoke : String = ""
    private var currentViewController : UIViewController!
    private var recentlySwitched = false;
    
    private func firstBuilder() {
        if firstViewController == nil {
            firstViewController =
                storyboard?
                    .instantiateViewControllerWithIdentifier("First")
                as! GJVC_1
        }
    }
    private func secondBuilder() {
        if secondViewController == nil {
            secondViewController =
                storyboard?
                    .instantiateViewControllerWithIdentifier("Second")
                as! GJVC_2
        }
    }
    
    
    private func firstPJVCBuilder() {
        if firstPJVC == nil {
            firstPJVC =
                storyboard?
                    .instantiateViewControllerWithIdentifier("PJ_First")
                as! PJVC_1
        }
    }
    private func secondPJVCBuilder() {
        if secondPJVC == nil {
            secondPJVC =
                storyboard?
                    .instantiateViewControllerWithIdentifier("PJ_Second")
                as! PJVC_2
        }
    }
    
    @IBAction func switchToJoke(sender: UIBarButtonItem) {
        if(currentJoke != sender.title!) {
            if currentJoke != "" {
                recentlySwitched = true
            }
            currentJoke = sender.title!;
            switchViews(sender)
            
        }
        
        
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem) {
        if (currentJoke == "Good Joke") {
            NSLog("GOOD JOKE")
            if (recentlySwitched) {
                recentlySwitched = false;
                switchViewController(firstPJVC, to: firstViewController)
            }
            
            secondBuilder()
            firstBuilder()
        
            UIView.beginAnimations("View Flip", context: nil)
            UIView.setAnimationDuration(0.4)
            UIView.setAnimationCurve(.EaseInOut)
        
            if firstViewController != nil &&
                firstViewController?.view.superview != nil {
                UIView.setAnimationTransition(.FlipFromRight, forView: view, cache: true)
                secondViewController.view.frame = view.frame
                switchViewController(firstViewController, to: secondViewController)
                NSLog("first != nil")
            }
            else {
                UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
                firstViewController.view.frame = view.frame
                switchViewController(secondViewController, to: firstViewController)
                NSLog("first != nil")
            }
            UIView.commitAnimations()
        } else if (currentJoke == "Pun Joke") {
            if (recentlySwitched) {
                recentlySwitched = false;
                switchViewController(firstViewController, to: firstPJVC)
            }
            
            NSLog("PUN JOKE")
            secondPJVCBuilder()
            firstPJVCBuilder()
            
            UIView.beginAnimations("View Flip", context: nil)
            UIView.setAnimationDuration(0.4)
            UIView.setAnimationCurve(.EaseInOut)
            
            if firstPJVC != nil && firstPJVC?.view.superview != nil {
                UIView.setAnimationTransition(.FlipFromRight, forView: view, cache: true)
                secondPJVC.view.frame = view.frame
                switchViewController(firstPJVC, to: secondPJVC)
                NSLog("firstPJ != nil")
            }
            else {
                UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
                firstPJVC.view.frame = view.frame
                switchViewController(secondPJVC, to: firstPJVC)
                NSLog("firstPJ == nil")
            }
            UIView.commitAnimations()

        }
    }
    
    private func switchViewController(from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMoveToParentViewController(nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, atIndex: 0)
            to!.didMoveToParentViewController(self)
        }
    }
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

