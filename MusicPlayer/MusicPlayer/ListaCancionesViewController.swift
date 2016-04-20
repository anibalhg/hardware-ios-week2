import UIKit

class ListaCancionesViewController: UITableViewController {

    var canciones: [Cancion] = [Cancion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canciones.append(Cancion(titulo: "Black Dog", portada: "led_zeppelin_iv.jpg", artista: "Led Zeppelin", file: "blackdog.mp3"))
        canciones.append(Cancion(titulo: "Proud Mary", portada: "creedence.jpg", artista: "Creedence Clearwater Revival", file: "proudmary.mp3"))
        canciones.append(Cancion(titulo: "Roudhouse Blues", portada: "doors.jpg", artista: "The Doors", file: "roudhouseblues.mp3"))
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.canciones.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let cancion = self.canciones[indexPath.row]
        cell.textLabel!.text = "\(cancion.titulo!) - \(cancion.artista!)"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "show") {
            let vc = segue.destinationViewController as! CancionViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            vc.cancion = self.canciones[indexPath!.row]
        }
    }

    @IBAction func suffle() {
        let maxVal = UInt32(self.canciones.count)
        let randomIndex = Int(arc4random_uniform(maxVal))
        self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: randomIndex, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
        performSegueWithIdentifier("show", sender: nil)
    }


}

