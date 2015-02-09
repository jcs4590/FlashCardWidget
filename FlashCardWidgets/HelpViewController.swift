//
//  HelpViewController.swift
//  FlashCardApp
//
//  Created by Julio Salamanca on 10/28/14.
//  Copyright (c) 2014 Julio Salamanca. All rights reserved.
//

import UIKit
import MediaPlayer

class HelpViewController: UIViewController {


  @IBOutlet weak var movieView: UIView!
  @IBOutlet weak var helpImage: UIImageView!
  let delegate = UIApplication.sharedApplication().delegate as AppDelegate

   @IBAction func backToTable(sender: AnyObject) {
    self.delegate.moviePlayer.stop()

   dismissViewControllerAnimated(true, completion: nil)

  }

    override func viewDidLoad() {
        super.viewDidLoad()

           

      
      
    movieView.addSubview(self.delegate.moviePlayer.view)
    self.view.backgroundColor = UIColor.blackColor()
    movieView.backgroundColor = UIColor.blackColor()
      self.delegate.moviePlayer.repeatMode = MPMovieRepeatMode.One
     self.delegate.moviePlayer.play()
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  	override func viewWillAppear(animated: Bool) {
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
