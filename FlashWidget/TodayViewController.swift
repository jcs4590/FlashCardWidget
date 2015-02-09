//
//  TodayViewController.swift
//  FlashCardWidget
//
//  Created by Julio Salamanca on 10/11/14.
//  Copyright (c) 2014 Julio Salamanca. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
  @IBOutlet weak var buttonView: UIView!
        
  @IBOutlet weak var cardLabel: UILabel!
  
  @IBOutlet weak var openAppButton: UIButton!
  @IBOutlet weak var prevButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var flipButton: UIButton!
  let userData = NSUserDefaults(suiteName: "group.salamanca.FlashCardsWidgets")!
  var currentCard:NSInteger = NSInteger();
  var arrayOfSelectedTerms:NSMutableArray = NSMutableArray();
  var FrontSide = true;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
      //  self.preferredContentSize = CGSizeMake(0, 200);

      if (self.userData.objectForKey("arrayOfSelectedTerms") != nil){
     
        arrayOfSelectedTerms = self.userData.objectForKey("arrayOfSelectedTerms") as NSMutableArray
        buttonView.hidden = false
        currentCard = self.userData.valueForKey("currentCard") as NSInteger;
        self.cardLabel.text = arrayOfSelectedTerms[currentCard].valueForKey("term") as? String;

        openAppButton.hidden = true;
        openAppButton.enabled = false;

      
      }
      else
      {
      
      cardLabel.text = "Please select card set from app. \n click here to open appication"
        buttonView.hidden = true
        openAppButton.hidden = false;
        openAppButton.enabled = true;

      }

     

    }
    
  @IBAction func openApp(sender: AnyObject) {
    
    self.extensionContext?.openURL(NSURL(string: "quizletURL://")!, completionHandler: nil);
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
  
  func widgetMarginInsetsForProposedMarginInsets
    (defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
      let insets = UIEdgeInsetsMake(10, 30, 5, 10)
    
      return insets;
  }
  func updateCurrentCard(){
    self.userData.setValue(currentCard, forKey:"currentCard");
  
  }
  
  @IBAction func buttonPrev(sender: AnyObject) {
    
    
    if(currentCard == 0){
      currentCard = (self.arrayOfSelectedTerms.count-1)
     
        self.cardLabel.text =  self.arrayOfSelectedTerms[self.currentCard].valueForKey("term") as? String;
      
    }
    
    else
    {
      currentCard--;
        self.cardLabel.text =  self.arrayOfSelectedTerms[self.currentCard].valueForKey("term") as? String;
    }
  
  
  updateCurrentCard()
  
  }
  
  
  
  
  
  func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
    if(self.currentCard != self.userData.valueForKey("currentCard") as Int ){
    self.currentCard = self.userData.valueForKey("currentCard") as Int
      completionHandler(.NewData)

    }else {
        completionHandler(.NoData)
      }
    
  
    
  }
  
  
  
  
  
  @IBAction func buttonFlip(sender: AnyObject) {
    
    
      self.cardLabel.text = (self.FrontSide ? self.arrayOfSelectedTerms[self.currentCard].valueForKey("definition") as String : self.arrayOfSelectedTerms[self.self.currentCard].valueForKey("term") as String )
      //self.cardLabel.sizeToFit()

      self.FrontSide = !(self.FrontSide);

 

  }
  
  
  @IBAction func buttonNext(sender: AnyObject) {
    
    
    
    
    if(currentCard < (self.arrayOfSelectedTerms.count-1)){
      currentCard++;
      
        self.cardLabel.text =  self.arrayOfSelectedTerms[self.currentCard].valueForKey("term") as? String ;

        
      }
    else
    {
      currentCard = 0;
        self.cardLabel.text =  self.arrayOfSelectedTerms[self.currentCard].valueForKey("term") as? String;

      
      
    }
    
    updateCurrentCard()
  }
  
  
}
