import Foundation

class Cancion {
    
    var titulo: String!
    var portada: String!
    var artista: String!
    var file: String!
    
    init(titulo: String!, portada: String!, artista: String!, file: String!) {
        self.titulo = titulo
        self.portada = portada
        self.artista = artista
        self.file = file
    }
    
}
