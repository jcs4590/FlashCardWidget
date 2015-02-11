//
//  ViewController.swift
//  FlashCardApp
//
//  Created by Julio Salamanca on 10/9/14.
//  Copyright (c) 2014 Julio Salamanca. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
  

  
  let delegate = UIApplication.sharedApplication().delegate as AppDelegate
  var methods = FlashCardMethods()
  var urlTempAuth = String();
  var logInDeclined = false;

  override func viewDidLoad() {
    
println("inside viewdidLoad")
    super.viewDidLoad()
    self.methods.userData.setObject(false, forKey: "logInDeclined")
    if(methods.userData.valueForKey("access_token_Quizlet") != nil )
    {
    
      methods.getQuizletFlashCards();

    }else if (methods.userData.valueForKey("access_token_Cram") != nil){
      methods.getCramFlashCards()
    
    
    }
    
    // Do any additional setup after loading the view, typically from a nib.
   urlTempAuth =   NSString(format: "https://quizlet.com/authorize?response_type=code&client_id=%@&scope=read+write_set&state=QUIZLETCowboys",methods.QUIZLETCLIENTID);
    methods.urlTempCramAuth =  "http://Cram.com/oauth2/authorize/?state=CRAMCowboys&scope=read_write_delete&response_type=code&client_id=\(methods.CRAMCLIENTID)"
    
  
    
    println("hello 1")
    
    
  
  



  }
    
    
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
   override func viewDidAppear(animated: Bool) {
    
    
    println("hello viewDidAppear")
    self.logInDeclined = self.methods.userData.objectForKey("logInDeclined") as Bool;
    if(self.logInDeclined){
    if((self.methods.userData.objectForKey("QuizletToken") != nil && self.methods.userData.objectForKey("CramToken") == nil) ||
    (self.methods.userData.objectForKey("QuizletToken") == nil && self.methods.userData.objectForKey("CramToken") != nil )){
    
    self.otherLogIn()
    
    }
    else if(self.methods.userData.objectForKey("QuizletToken") != nil || self.methods.userData.objectForKey("CramToken") != nil )
    {
      
      self.performSegueWithIdentifier("MainCardSetsTableView", sender: self)
      
      
    }
    super.viewDidAppear(animated)
  

 


    }

    

  }

  @IBAction func buttonQuizlet(sender: AnyObject) {
    methods.userData.setObject("QUIZLET", forKey: "whichLogin");
    
    self.performSegueWithIdentifier("logInSegue", sender: self)
    
	}
  
  
  

     override func prefersStatusBarHidden() -> Bool {
        return true;
    
    }
    
  func skipLogin(){
    println("inside skip")
    self.performSegueWithIdentifier("MainCardSetsTableView", sender: self)

  }
  
  
  @IBAction func processCramLogIN() {
  methods.userData.setObject("CRAM", forKey: "whichLogin");
    self.performSegueWithIdentifier("logInSegue", sender: self)


    //      UIApplication.sharedApplication().openURL(NSURL(string: methods.urlTempCramAuth)!);
    
  }
  
  func otherLogIn(){
    println("inside other login")
   


    if( self.methods.userData.valueForKey("CramToken")  == nil){
      

      let alert = UIAlertController(title: "Sign In with Cram?", message: "Log in with Cram?", preferredStyle: UIAlertControllerStyle.Alert)
      let okButton =  UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){_ in
        self.methods.userData.setObject("CRAM", forKey: "whichLogin")
        self.performSegueWithIdentifier("logInSegue", sender: self)
      }
      alert.addAction(okButton);
      
      let cancelButton = UIAlertAction(title: "No, Thanks!", style: UIAlertActionStyle.Cancel) { _ in
        
        self.skipLogin()
        
      };
      alert.addAction(cancelButton);
      
      self.presentViewController(alert, animated: true, completion: nil)
    }

  
  if(self.methods.userData.valueForKey("QuizletToken") == nil){

  let alert = UIAlertController(title: "Sign In with Quizlet?", message: "Log in with Quizlet?", preferredStyle: UIAlertControllerStyle.Alert)
  let okButton =  UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){_ in
    self.methods.userData.setObject("QUIZLET", forKey: "whichLogin")
    self.performSegueWithIdentifier("logInSegue", sender: self)
  }
  alert.addAction(okButton);
  
  let cancelButton = UIAlertAction(title: "No, Thanks!", style: UIAlertActionStyle.Cancel) { _ in
    self.skipLogin()

  
  };
  alert.addAction(cancelButton);
  
  self.presentViewController(alert, animated: true, completion: nil)
  }
  }
  
  
  
  
  
  func logInFailed(){
    let alert = UIAlertController(title: "Authorization Unsuccesfull", message: "Log In Failed", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
    

  
  
  }
  
}
