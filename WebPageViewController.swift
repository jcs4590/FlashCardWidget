//
//  WebPageViewController.swift
//  FlashCardWidgets
//
//  Created by Julio Salamanca on 1/22/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

import UIKit
import Dispatch

class WebPageViewController: UIViewController, UIWebViewDelegate{

  @IBOutlet var logInWebView: UIWebView!
  var methods = FlashCardMethods()
  let userData = NSUserDefaults(suiteName: "group.salamanca.FlashCardsWidgets")!;
  var whichLogin = String();
  var firstLogin = true;
  var logInDeclined = false;
  var logInUrl = String();


    override func viewDidLoad() {
        logInWebView.delegate = self;

        whichLogin = methods.userData.objectForKey("whichLogin") as String;
        
        super.viewDidLoad()
      methods.urlTempAuth =   NSString(format: "https://quizlet.com/authorize?response_type=code&client_id=%@&scope=read+write_set&state=QUIZLETCowboys",methods.QUIZLETCLIENTID);
      methods.urlTempCramAuth =  "http://Cram.com/oauth2/authorize/?state=CRAMCowboys&scope=read_write_delete&response_type=code&client_id=\(methods.CRAMCLIENTID)"
        // Do any additional setup after loading the view.
        
        if (whichLogin == "CRAM"){
            logInUrl = methods.urlTempCramAuth;
        
        }
        else{
            logInUrl = methods.urlTempAuth;

        
        }
      logInWebView.loadRequest(NSURLRequest(URL: NSURL(string:logInUrl)!))
       
        
        

    }

  
     func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let controller =   ViewController()
        var url = request.URL;
        let urlString: String = url.description;
        
        println("  ")
        println(navigationType.rawValue)
        println("  ")
        println("  ")

        println("  ")

        println(url.description)

        if(navigationType.rawValue == 1){
        
        
        
        if((url.description.componentsSeparatedByString("&").count >= 2)   && url.description.rangeOfString("redirect") == nil   ){
            
        
            
            
                println("inside stuff")
            var dataDict = parseQueryString(url.description);
            if dataDict["state"]! == "QUIZLETCowboys" && dataDict["code"] != nil {
                userData.setObject(dataDict["code"]!, forKey: "tempCodeQuizlet");
                userData.setValue(0, forKey: "currentCard");
                
                userData.synchronize();
                controller.methods.processQuizletLogIn();
                self.logInDeclined = false;
                self.dismissViewControllerAnimated(true, completion: nil)

                
            }
            else if  dataDict["state"]! == "CRAMCowboys" && dataDict["code"] != nil
            {
                
                userData.setObject(dataDict["code"]!, forKey: "tempCodeCram");
                userData.setValue(0, forKey: "currentCard");
                userData.synchronize();
                controller.methods.processQuizletLogIn();
                self.logInDeclined = false;
                self.dismissViewControllerAnimated(true, completion: nil)
                
                
            }

         
            else if dataDict["error"] != nil {
                println("fuck tthis bitch")
                self.logInDeclined = true
                
                userData.setObject(self.logInDeclined, forKey: "logInDeclined")
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
        
        
        }
        else if urlString.rangeOfString("quizleturl:///") != nil {
            println("fuck tthis bitch")
            self.logInDeclined = true
            
            userData.setObject(self.logInDeclined, forKey: "logInDeclined")
            self.dismissViewControllerAnimated(true, completion: nil)
            
            }
      
            
        }

        return true;
            
    }
    
    
    
    func parseQueryString(queryString:String)-> Dictionary<String,String>{
        
        var dict = Dictionary<String,String>();
        var pairs:[String] = queryString.componentsSeparatedByString("&");
        
        for pair in pairs{
            
            var key = pair.componentsSeparatedByString("=")[0];
            if((key.rangeOfString("?", options: nil, range: nil, locale: nil)) != nil){
                
                key = key.componentsSeparatedByString("?")[1]
                
            }
            var value = pair.componentsSeparatedByString("=")[1];
            dict[key] = value;
        }
        
        
        return dict;
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
