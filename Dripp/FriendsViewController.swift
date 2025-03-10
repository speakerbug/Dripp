//
//  FriendsViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Haneke
import DZNEmptyDataSet

class FriendsViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var friends = [Dripper]()
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        self.view.backgroundColor = UIColor(hexString: "#f1f1f1")
        let params = ["fields": "name, id, friends"]
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                let friends = result.valueForKey("friends")
                let data : NSArray = friends!.objectForKey("data") as! NSArray
                
                for i in 0 ..< data.count
                {
                    let valueDict : NSDictionary = data[i] as! NSDictionary
                    let id = valueDict.objectForKey("id") as! String
                    let name = valueDict.objectForKey("name") as! String
                    self.friends.append(Dripper(uid: id, firstName: name, lastName: "", email: "", photo: "https://graph.facebook.com/\(id)/picture?width=800&height=800&return_ssl_resources=1", accountType: "", lowestShowerLength: "", savedWater: ""))
                    print("the id value is \(id)")
                }
                self.table.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
                self.table.reloadEmptyDataSet()
                
            }
        })
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "FriendCell";
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! FriendCell
        cell.name.text = ""
        cell.photo.image = UIImage(named: "placeholder")
        
        let friend = self.friends[indexPath.row]
        
        cell.photo.hnk_setImageFromURL(NSURL(string: friend.photo)!)
        cell.name.text = "\(friend.firstName) \(friend.lastName)"
        cell.backgroundColor = UIColor(hexString: "#f1f1f1")
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let VC1 = self.storyboard!.instantiateViewControllerWithIdentifier("profile") as! ProfileViewController
        VC1.id = friends[indexPath.row].uid
        self.navigationController!.pushViewController(VC1, animated: true)
    }
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let challenge = UITableViewRowAction(style: .Normal, title: "Challenge") { action, index in
            
            let friend = self.friends[indexPath.row]
            
            let alert = UIAlertController(title: "Quick Challenge", message: "Challenge \(friend.firstName) to take a shower using your recommended playlist.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Sure", style: UIAlertActionStyle.Default, handler: { alertAction in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Maybe Later", style: UIAlertActionStyle.Default, handler: { alertAction in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            self.tableView.setEditing(false, animated: true)
            
        }
        challenge.backgroundColor = UIColor.blueHeader
        
        return [challenge]
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Want a bubble buddy?"
        let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "We automatically link your Facebook friends who also use Dripp."
        let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    //    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
    //        return UIImage(named: "default")
    //    }
    
    func buttonTitleForEmptyDataSet(scrollView: UIScrollView!, forState state: UIControlState) -> NSAttributedString! {
        let str = "Share Dripp with Friends"
        let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleCallout)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func emptyDataSetDidTapButton(scrollView: UIScrollView!) {
        let ac = UIAlertController(title: "Share with a friend", message: "Implement this later", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        
    }
}