import UIKit
import AVFoundation

class CancionViewController: UIViewController, AVAudioPlayerDelegate {

    var cancion: Cancion!
    private var reproductor: AVAudioPlayer!
    
    @IBOutlet weak var imgAlbum: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var sldVolumen: UISlider!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.imgAlbum.image = UIImage(named: cancion.portada)
        self.lblTitulo.text = "\(cancion.titulo!) - \(cancion.artista!)"
        
        let file = cancion.file.characters.split(isSeparator: {$0 == "."}).map(String.init)
        let fileName = file[0]
        let fileExtension = file[1]
        let sonidoURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: fileExtension)
        do{
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoURL!)
            reproductor.delegate = self
            
            let preferences = NSUserDefaults.standardUserDefaults()
            
            if let volumen = preferences.objectForKey("volumen") {
                let value = Float(volumen as! NSNumber)
                reproductor.volume = value
                self.sldVolumen.value = value
            }
            else {
                reproductor.volume = 5
            }
            
            reproductor.play()
        }
        catch {
            NSLog("Error al cargar archivo " + cancion.file);
        }
        
    }

    @IBAction func play() {
        if !reproductor.playing {
            reproductor.play()
            self.btnPlay.enabled = false
            self.btnPause.enabled = true
            self.btnStop.enabled = true
        }
    }
    
    
    @IBAction func pause() {
        if reproductor.playing {
            reproductor.pause()
            self.btnPlay.enabled = true
            self.btnPause.enabled = false
            self.btnStop.enabled = true
        }
    }
    
    
    @IBAction func stop() {
        reproductor.stop()
        reproductor.currentTime = 0.0
        self.btnPlay.enabled = true
        self.btnPause.enabled = false
        self.btnStop.enabled = false
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        let volumen = Float(sender.value)
        reproductor.volume = volumen
        let preferences = NSUserDefaults.standardUserDefaults()
        preferences.setObject(volumen, forKey: "volumen")
        preferences.synchronize()
        
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        self.btnPlay.enabled = true
        self.btnPause.enabled = false
        self.btnStop.enabled = false
    }
}
