//
//  AppDelegate.swift
//  FlashCardApp
//
//  Created by Julio Salamanca on 10/9/14.
//  Copyright (c) 2014 Julio Salamanca. All rights reserved.
//

import UIKit
import MediaPlayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  let userData = NSUserDefaults(suiteName: "group.salamanca.FlashCardsWidgets")!;
  var whichLogin = String();
  var firstLogin = true;
  var logInDeclined = false;
  var moviePlayer:MPMoviePlayerController!
  var movieUrl:NSURL = NSURL(string: "https://dl.dropboxusercontent.com/s/adtslynsm7mr787/WidgetInstallHelp.m4v?dl=0")!

  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    self.moviePlayer = MPMoviePlayerController(contentURL: self.movieUrl)
    self.moviePlayer.view.frame = CGRect(x: 0, y: 0, width: 200, height: 350)
    
    self.moviePlayer.movieSourceType = MPMovieSourceType.File
    self.moviePlayer.controlStyle =  MPMovieControlStyle.None;
    self.moviePlayer.backgroundView.backgroundColor = UIColor.clearColor()
    self.moviePlayer.scalingMode = MPMovieScalingMode.Fill
    
    
    self.moviePlayer.prepareToPlay()



    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  

  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
//  func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
//    let controller =   ViewController()
//    if(url.description.componentsSeparatedByString("&").count >= 2){
//
//    var dataDict = parseQueryString(url.description);
//      if dataDict["state"]! == "QUIZLETCowboys"{
//    	userData.setObject(dataDict["code"]!, forKey: "tempCodeQuizlet");
//      userData.setValue(0, forKey: "currentCard");
//
//    	userData.synchronize();
//       controller.methods.processQuizletLogIn();
//        self.logInDeclined = false;
//
//      }
//      else if dataDict["state"]! == "CRAMCowboys" && dataDict["code"] != nil
//      {
//
//        userData.setObject(dataDict["code"]!, forKey: "tempCodeCram");
//        userData.setValue(0, forKey: "currentCard");
//        userData.synchronize();
//        controller.methods.processQuizletLogIn();
//        self.logInDeclined = false;
//
//
//      
//      }
//      else{
//        self.logInDeclined = true
//      
//      }
//      
//      
//    }
//    else
//    {
//      self.logInDeclined = true;
//
//      
//
//
//    }
//    
//    
//    println("BACK IN ACTION" )
//
//    
//      //self.popOver dismissPopoverAnimated:YES];
//      //self.popOver = nil;
//
//    return true;
//  }

 
//  func parseQueryString(queryString:String)-> Dictionary<String,String>{
//  	
//    var dict = Dictionary<String,String>();
//    var pairs:[String] = queryString.componentsSeparatedByString("&");
//    
//    for pair in pairs{
//    
//      var key = pair.componentsSeparatedByString("=")[0];
//      if((key.rangeOfString("?", options: nil, range: nil, locale: nil)) != nil){
//  
//      key = key.componentsSeparatedByString("?")[1]
//      
//      }
//      var value = pair.componentsSeparatedByString("=")[1];
//      dict[key] = value;
//    }
//    
//    
//    return dict;
//  
//  }

}

