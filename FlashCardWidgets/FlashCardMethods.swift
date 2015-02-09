//
//  flashCardAPIMethots.swift
//  FlashCardApp
//
//  Created by Julio Salamanca on 11/2/14.
//  Copyright (c) 2014 Julio Salamanca. All rights reserved.
//

import Foundation
import UIKit

class FlashCardMethods{

var userNameCram = String();
let CRAMCLIENTID = "7c7cc72c03d11159883bd4502df23ecb"
let CRAMTOKENURL = "https://api.Cram.com/oauth2/token/"
let QUIZLETCLIENTID = "K9uru65mUs";
let QUIZLETSECRETKEY =  "A3bBeMt3xd93fcPryntFKx";
let QUIZLETTOKENURL = "https://api.quizlet.com/oauth/token";
let QUIZLETRETURNURI = "quizletURL:/"
let BASICAUTHORIZATION = "Basic Szl1cnU2NW1VczpBM2JCZU10M3hkOTNmY1ByeW50Rkt4";
let BASICAUTHORIZATIONCRAM = "Basic N2M3Y2M3MmMwM2QxMTE1OTg4M2JkNDUwMmRmMjNlY2I6ZDhiNDZkZGYzMjMxMjU1ZjU2MDUzOTFiZDk5YmM1MDU=";
var userNameQuizlet = String();
var GRABUSERSETSURL = String();
var TOKENCRAM:String = String();
var TOKENQUIZLET:String = String();

var tempAuthCode :String? = String();
var tempCodeCram :String? = String();

var urlTempAuth = String();
var urlTempCramAuth = String();
  let userData = NSUserDefaults(suiteName: "group.salamanca.FlashCardsWidgets")!;







func getQuizletFlashCards(){
  println("quizletflash")
  TOKENQUIZLET = userData.valueForKey("QuizletToken")!.description;
  userNameQuizlet = (userData.valueForKey("QuizletUserName"))!.description;
  GRABUSERSETSURL = "https://api.quizlet.com/2.0/users/" + userNameQuizlet + "/sets";
  let grabCardsRequest = NSMutableURLRequest(URL: NSURL(string: GRABUSERSETSURL)!);
  grabCardsRequest.HTTPMethod = "GET";
  let tokenAuth = "Bearer afd58c755535c2492a501a5d4c8fd8a7486e3f83";
  grabCardsRequest.setValue(tokenAuth, forHTTPHeaderField: "Authorization");
  
  let data = NSURLConnection.sendSynchronousRequest(grabCardsRequest, returningResponse: nil, error:nil);
  
  
  let tempArray:NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSArray;
  
  
  var terms =  NSArray();
  terms = tempArray[0].valueForKey("terms")! as NSArray;
  
  var userCardsQuizlet:NSMutableArray = NSMutableArray();
  
  for set in tempArray{
    let quizletData:NSMutableDictionary = ["created_by":set.valueForKey("created_by")! ,
      "created_date":set.valueForKey("created_date")!,
      "term_count":set.valueForKey("term_count")!,
      "terms":set.valueForKey("terms")!.mutableCopy(),
      "title":set.valueForKey("title")!
      
      
    ]
    let termsArray = quizletData.valueForKey("terms")?.mutableCopy() as NSMutableArray
    for (index,term) in enumerate(termsArray){
      let editedTerm:NSMutableDictionary = term.mutableCopy() as NSMutableDictionary;
      editedTerm.removeObjectForKey("image")
      termsArray.replaceObjectAtIndex(index, withObject: editedTerm);
      
      
    }
    quizletData["terms"] =  termsArray;
    userCardsQuizlet.addObject( quizletData );
    
  }
  
  
  
  
  userData.setObject(userCardsQuizlet, forKey: "QuizletData");

  
  userData.synchronize();

  
  }
  
  
  
  func processQuizletLogIn(){
    println("suns")
    
    if self.userData.objectForKey("whichLogin")! as NSString == "QUIZLET"{
      println("songs ")  
      
      if((self.userData.valueForKey("tempCodeQuizlet")) == nil){
        println("maybe")
        //ViewController().delayProcess();
        println("what")
        

        
      }
      else if((self.userData.valueForKey("tempCodeQuizlet")) != nil && (userData.valueForKey("access_token_Quizlet") == nil))
      {
        tempAuthCode = self.userData.valueForKey("tempCodeQuizlet")!.description!;
        let request = NSMutableURLRequest(URL: NSURL(string: QUIZLETTOKENURL)!);
        let dataString = "grant_type=authorization_code&code=\(tempAuthCode!)&redirect_uri=quizletURL:/";
        
        request.HTTPMethod = "POST";
        request.setValue("Basic Szl1cnU2NW1VczpBM2JCZU10M3hkOTNmY1ByeW50Rkt4", forHTTPHeaderField: "Authorization");
        request.HTTPBody = dataString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true);
        
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil);
        let dataDict:NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary;
        self.userData.setObject(dataDict["access_token"], forKey: "QuizletToken");
        self.userData.setObject(dataDict["user_id"], forKey: "QuizletUserName");
        self.userData.removeObjectForKey("tempCodeQuizlet")
        self.userData.synchronize();
        self.getQuizletFlashCards();
        
      }
      
      
    }
    else if (self.userData.objectForKey("whichLogin")! as String == "CRAM")
    {
      if(self.userData.valueForKey("tempCodeCram") == nil){
        
        ViewController().logInFailed();
        
      }
      else if ((self.userData.valueForKey("tempCodeCram")) != nil && (userData.valueForKey("access_token_Cram") == nil)){
        
        tempAuthCode = self.userData.valueForKey("tempCodeCram")!.description!;
        let request = NSMutableURLRequest(URL: NSURL(string: CRAMTOKENURL)!);
        let dataString = "grant_type=authorization_code&code=\(tempAuthCode!)";
        
        request.HTTPMethod = "POST";
        request.setValue(BASICAUTHORIZATIONCRAM, forHTTPHeaderField: "Authorization");
        request.HTTPBody = dataString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true);
        
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil);
        let dataDict:NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary;
        self.userData.setObject(dataDict["access_token"], forKey: "CramToken");
        self.userData.setObject(dataDict["user_name"], forKey: "CramUserName");
        
        self.userData.removeObjectForKey("tempCodeCram")
        self.userData.synchronize();
        
        getCramFlashCards();
      }
      
    }

}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  func getCramFlashCards()
  {
    TOKENCRAM = self.userData.valueForKey("CramToken")!.description;
    println("flash \(TOKENCRAM)")

    userNameCram = (userData.valueForKey("CramUserName"))!.description;
    GRABUSERSETSURL = "https://api.Cram.com/v2/users/" + userNameCram + "/sets";
    var grabCardsRequest = NSMutableURLRequest(URL: NSURL(string: GRABUSERSETSURL)!);
    grabCardsRequest.HTTPMethod = "GET";
    let tokenAuth = "Bearer \(TOKENCRAM)";
    grabCardsRequest.setValue(tokenAuth, forHTTPHeaderField: "Authorization");
    
    var data = NSURLConnection.sendSynchronousRequest(grabCardsRequest, returningResponse: nil, error:nil);
    
    var tempDict:NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary;
    var sets: NSMutableArray = NSMutableArray();
    if((tempDict.objectForKey("sets")) != nil){
    sets.addObjectsFromArray(tempDict.objectForKey("sets") as NSMutableArray);
    }
    
    
    
    GRABUSERSETSURL = "https://api.Cram.com/v2/users/" + userNameCram + "/favorites";
    grabCardsRequest.URL =  NSURL(string: GRABUSERSETSURL);
    data = NSURLConnection.sendSynchronousRequest(grabCardsRequest, returningResponse: nil, error:nil);
    tempDict = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary;
    if(tempDict.objectForKey("favorites") != nil){
      sets.addObjectsFromArray(tempDict.objectForKey("favorites")?.objectForKey("sets") as NSMutableArray);
      
      
    }
    var userCardsQuizlet:NSMutableArray = NSMutableArray();
    
    
    
    for set in sets{
      let cramData:NSMutableDictionary = [
        "created_date":set.valueForKey("created")!,
        "term_count":set.valueForKey("card_count")!,
        "terms":set.valueForKey("cards")!.mutableCopy(),
        "title":set.valueForKey("title")!
        
        
      ]
      
      let termsArray = cramData.valueForKey("terms") as NSMutableArray
      for (index,term) in enumerate(termsArray){
        
        
        let editedTerm:NSMutableDictionary = term.mutableCopy() as NSMutableDictionary;
        editedTerm.removeObjectForKey("image_front");
        editedTerm.removeObjectForKey("image_hint");
        editedTerm.removeObjectForKey("image_url");
        editedTerm.setObject(editedTerm.objectForKey("back")!.description, forKey: "definition");
        editedTerm.setObject(editedTerm.objectForKey("front")!.description, forKey: "term")
        editedTerm.removeObjectForKey("back");
        editedTerm.removeObjectForKey("front")
        editedTerm.removeObjectForKey("hint")

        
        
        termsArray.replaceObjectAtIndex(index, withObject: editedTerm)
      }
      cramData["terms"] = termsArray;
      userCardsQuizlet.addObject( cramData );
      
      
      
      
      
      self.userData.setObject(userCardsQuizlet, forKey: "CramData");
      
      // ViewController().otherLogIn();
      
      
    }
    println("ready")
    //ViewController().skipLogin();
    
  }
}