//
//  TableViewController.swift
//  FlashCardApp
//
//  Created by Julio Salamanca on 10/14/14.
//  Copyright (c) 2014 Julio Salamanca. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController {
  
  @IBOutlet var tableViewSets: UITableView!
  let userData = NSUserDefaults(suiteName: "group.salamanca.FlashCardsWidgets")!
  let CRAMCLIENTID = "7c7cc72c03d11159883bd4502df23ecb"
  let QUIZLETCLIENTID = "K9uru65mUs";
  
  var urlTempAuth = String();
  var urlTempCramAuth = String();
  var quizletData : NSMutableArray = NSMutableArray();
  var cramData : NSMutableArray = NSMutableArray();
  var localData : NSMutableArray = NSMutableArray();
  var setTOEdit : NSMutableDictionary = NSMutableDictionary();
  var bothLoggedIn = false;
  var terms : NSMutableDictionary = NSMutableDictionary();
 
  var currentCardNumber = 0;

  
   override func viewDidAppear(animated: Bool) {
    
  
    
    tableView.reloadData()

  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      urlTempAuth =   NSString(format: "https://quizlet.com/authorize?response_type=code&client_id=%@&scope=read+write_set&state=QUIZLETCowboys",QUIZLETCLIENTID);
      urlTempCramAuth =  "http://Cram.com/oauth2/authorize/?state=CRAMCowboys&scope=read_write_delete&response_type=code&client_id=\(CRAMCLIENTID)"
      tableView.reloadData()
      
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTable:", name: UIApplicationWillEnterForegroundNotification, object: nil)



        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

 
      
  

      
      self.userData.setValue(localData, forKey: "localData")
    }
  
 
  func updateTable(NSNotificationCenter){
  updateDataSets()
    tableView.reloadData()

  }
  override func viewWillAppear(animated: Bool) {
    tableView.reloadData()


    

  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
     

      return 2;
    }

  @IBAction func refreshData(sender: AnyObject) {
    
    tableView.reloadData()
  }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
    
      
    
      if section == 0{
			updateDataSets()
      return self.cramData.count

      }
      else if section ==  1{
      
        return self.quizletData.count
      }
      return 0;
    }

  func updateDataSets(){
    
    
    if(self.userData.objectForKey("CramData") != nil)
    {
      
      let tempArray = userData.objectForKey("CramData") as NSArray
      self.cramData.removeAllObjects()
      self.cramData.addObjectsFromArray( tempArray );
      
      
    }
    
    if (self.userData.objectForKey("QuizletData") != nil){
      
      
      let tempArray = userData.objectForKey("QuizletData") as NSArray
      self.quizletData.removeAllObjects()
      self.quizletData.addObjectsFromArray( tempArray  );
      
      
      
    }
  
  }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("quizletCell", forIndexPath: indexPath) as TableViewCell
      
      
      if(indexPath.section == 1){
       
      

      cell.termCountLabel.text = self.quizletData[indexPath.row].valueForKey("term_count")!.description;
      cell.labelSetTitle.text = self.quizletData[indexPath.row].valueForKey("title") as? String;
        // Configure the cell...
      
      
     cell.labelSetTitle.adjustsFontSizeToFitWidth = true;
      }
        
        
      else  if(indexPath.section == 0){
        
        

        cell.termCountLabel.text = self.cramData[indexPath.row].valueForKey("term_count")!.description;
        cell.labelSetTitle.text = self.cramData[indexPath.row].valueForKey("title") as? String;
      
      
      }

      
        
        return cell
    }
  
  
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  
    if(indexPath.section == 1){
    self.userData.setValue(self.quizletData[indexPath.row].objectForKey("terms") , forKey: "arrayOfSelectedTerms") ;
    }
    else if(indexPath.section == 0){
    
      self.userData.setValue(self.cramData[indexPath.row].objectForKey("terms") , forKey: "arrayOfSelectedTerms") ;


    
    }
        self.userData.setValue(0, forKey:"currentCard");

  }
  
  

  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 10));
    let button = UIButton.buttonWithType(UIButtonType.System) as UIButton;
    let buttonAdd = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton;

    let buttonQuiz = UIButton.buttonWithType(UIButtonType.System) as UIButton;

    button.frame = CGRectMake((headerView.frame.width/2)+40, 0, (tableView.frame.size.width/2),40);
    buttonAdd.frame = CGRectMake((headerView.frame.width/2)+40, 0, (tableView.frame.size.width/2),40);

    headerView.layer.borderWidth = 0.5;
    headerView.layer.borderColor = UIColor.blueColor().CGColor;
    headerView.addSubview(button);
    headerView.addSubview(buttonAdd)

    let headerTitle = UILabel(frame: CGRectMake(10, 0, 125, 40))
    button.titleLabel?.font = UIFont(name: "GillSans-Light", size: 12)
    headerView.addSubview(headerTitle)
    button.setTitle("LogOut", forState: UIControlState.Normal)
    
    if section == 1{
      buttonAdd.hidden = true
      button.hidden = false
      
      headerTitle.text = "Quizlet"
      
      if(self.userData.objectForKey("QuizletToken") == nil)
      {
      
      button.setTitle("LogIn", forState: UIControlState.Normal)
      }
      
     

    button.addTarget(self, action: "signInOutQuizlet", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    
    
    if section == 0{
      buttonAdd.hidden = true
      button.hidden = false
      
      if(self.userData.objectForKey("CramToken") == nil)
      {
        button.setTitle("LogIn", forState: UIControlState.Normal)
      }
      
      headerTitle.text = "Cram"

    button.addTarget(self, action: "signInOutCram", forControlEvents: UIControlEvents.TouchUpInside)
    
    }
    
 
    
    
    return headerView;
  }
  
  
  
  
  
  

  
  
  func signInOutQuizlet(){
    
    
    if(self.userData.objectForKey("QuizletToken") != nil){
    	self.userData.removeObjectForKey("QuizletData")
    	self.userData.removeObjectForKey("QuizletToken")
    	quizletData.removeAllObjects();
      self.userData.removeObjectForKey("arrayOfSelectedTerms")

    }
    else{
      self.userData.setObject("QUIZLET", forKey: "whichLogin")
        self.performSegueWithIdentifier("logInSegueTwo", sender: self)
      
      self.performSegueWithIdentifier("backtologin", sender: self)
      if(self.userData.objectForKey("QuizletData") != nil)
      {
        
        let tempArray = userData.objectForKey("QuizletData") as NSArray
        self.quizletData.addObjectsFromArray( tempArray );
        
        
        
      }
      

    
    
    }
    tableView.reloadData()

  }
  
  
  func signInOutCram(){
    if(self.userData.objectForKey("CramToken") != nil){

    self.userData.removeObjectForKey("CramData")
    self.userData.removeObjectForKey("CramToken")
    cramData.removeAllObjects()
    self.userData.removeObjectForKey("arrayOfSelectedTerms")

    }
    else{
      self.userData.setObject("CRAM", forKey: "whichLogin")
        self.performSegueWithIdentifier("logInSegueTwo", sender: self)


      //self.performSegueWithIdentifier("backtologin", sender: self)
      if(self.userData.objectForKey("CramData") != nil)
      {
        
        let tempArray = userData.objectForKey("CramData") as NSArray
        self.cramData.addObjectsFromArray( tempArray );
        
        
        
      }

      

    }
    tableView.reloadData()

  }
  
   override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40;
  }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
  
  


}
