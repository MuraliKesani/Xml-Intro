//
//  ViewController.swift
//  XML_Intro
//
//  Created by Murali on 4/2/19.
//  Copyright © 2019 Murali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableVIEW: UITableView!
    
    //  var indianActorsArray:[Actor] = []
    var bollywoodActors = [String]()
    var tollywoodActors = [String]()
    var mollywoodActors = [String]()
    var kollywoodActors = [String]()
    
    //    var totalArray = [[String]]()
    
    var headerArray:[String] = []
    
    var xmlParserObj:XMLParser!
    var woodStr:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVIEW.sectionIndexColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        headerArray = ["Bollywood","Tollywood","Mollywood","Kollywood"]
    }
    
    
    @IBAction func onLoadBtnTap(_ sender: UIBarButtonItem)
    {
        let xmlParserPath = Bundle.main.path(forResource: "IndianActrors", ofType: "xml")
        
        xmlParserObj = XMLParser(contentsOf: URL(fileURLWithPath: xmlParserPath!))
        
        xmlParserObj.delegate = self
        
        xmlParserObj.parse()
        
        tableVIEW.reloadData()
    }
}



extension ViewController: XMLParserDelegate{
    
    func parserDidStartDocument(_ parser: XMLParser)
    {
        //  print("DID Started Document")
        
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        
        
        if(elementName == "Bollywood" || elementName == "Tollywood" || elementName == "Mollywood" || elementName == "Kollywood")
        {
            woodStr = elementName
        }
        
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        //  print("DID Started Document")
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        // print("DID Started Document")
        let trimmedStr = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      
        
        if(trimmedStr.count > 0)
        {
            if(woodStr! == "Bollywood")
            {
                bollywoodActors.append(trimmedStr)
                print("Bollywood-->\(bollywoodActors)")
            }
            else if(woodStr! == "Tollywood")
            {
                tollywoodActors.append(trimmedStr)
                print("Tollywood-->\(tollywoodActors)")
            }
            else if(woodStr! == "Mollywood")
            {
                mollywoodActors.append(trimmedStr)
                print("Mollywood-->\(mollywoodActors)")
            }
            else if(woodStr! == "Kollywood")
            {
                kollywoodActors.append(trimmedStr)
                print("Kollywood-->\(kollywoodActors)")
            }

        }
   }
    
    func parserDidEndDocument(_ parser: XMLParser)
    {
        //print("DID Started Document")
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0){
            return bollywoodActors.count
        }else if(section == 1){
            return tollywoodActors.count
        }else if(section == 2){
            return mollywoodActors.count
        }else{
            return kollywoodActors.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableVIEW.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if(indexPath.section == 0)
        {
            cell.textLabel?.text = self.bollywoodActors[indexPath.row]
            
        }else if(indexPath.section == 1){
            
            cell.textLabel?.text = self.tollywoodActors[indexPath.row]
        }
        else if(indexPath.section == 2){
            
            cell.textLabel?.text = self.mollywoodActors[indexPath.row]
        }
        else if(indexPath.section == 3){
            
            cell.textLabel?.text = self.kollywoodActors[indexPath.row]
        }
        
        return cell
        
    }
    
    //Creating A function to display Header With diff Font & Size
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        
        let disp = view as! UITableViewHeaderFooterView
        disp.textLabel?.font = UIFont(name: "Futura", size: 33)
        disp.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        disp.backgroundView = UIImageView(image: UIImage(named:"bgr4"))
        disp.textLabel?.textAlignment = .center
    }
    
    //Creating Title For Header In Section Method
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return headerArray[section]
    }
    
    //Creating Section Titles
    func sectionIndexTitles(for tableView: UITableView) -> [String]?
    {
        
        return ["B","T","M","K"]
    }
    
    //Creating Section for Section Index So as to Jump from one Section to another section
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
    {
        if(title == "B")
        {
            return 0
        }
        else if(title == "T")
        {
            return 1
        }
        else if(title == "M")
        {
            return 2
        }else{
            return 3
        }
    }
    
}






