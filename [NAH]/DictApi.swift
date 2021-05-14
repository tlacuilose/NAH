//
//  DictApi.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 13/05/21.
//

import SwiftSoup

class DictApi {

    /// Gets the raw html from a GDN entry as a bs4 soup.
    /// https://gdn.iib.unam.mx/contexto/109087
    /// :return: Soup containing raw html
    /// :param id: The number of the GDN entry
    static func getSoupEntry(pk: String, completitionHandler: @escaping (Document?) -> ()) {
        let urlString = "https://gdn.iib.unam.mx/contexto/" + pk
        
        // Create URL
        let url = URL(string: urlString)
        guard let requestUrl = url else {
            print("Error en la url de UNAM buscando html.")
            return
        }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                do {
                    let doc: Document = try SwiftSoup.parse(dataString)
                    completitionHandler(doc)
                }  catch Exception.Error(_, let message) {
                    print(message)
                } catch {
                    print("error en swift soup")
                }
            }
            
        }
        task.resume()
    }
    
    /// Gets a list of PKS from the GDN.
    /// :param query: Word to look for
    /// :param spanish: Whether to look in es or nah
    /// :return: A list of PKS
    static func getResults(query: String, get2es: Bool = false, completitionHandler: @escaping ([String]) -> ()){
    
        let urlString = "https://gdn.iib.unam.mx/termino/search?queryCreiterio=\(query)&queryPartePalabra=cualquiera&queryBuscarEn=\(get2es ? "espanol" : "nahuatl")&queryLimiteRegistros=50"
        
        // Create URL
        let url = URL(string: urlString)
        guard let requestUrl = url else {
            print("Error en la url de UNAM buscando pks.")
            return
        }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                var pks: [String] = []
                let lines = dataString.split(whereSeparator: \.isNewline)
                for line in lines {
                    if line.contains("pk:") {
                        let newPk = line.components(separatedBy: "'")[1]
                        pks.append(newPk)
                    }
                }
                completitionHandler(pks)
            }
            
        }
        task.resume()
    }

    
    /// Returns an array of dictionaries containing definitions of the shape
    /// paleography : paleography
    /// normalizedgrapheme : grapheme
    /// wordtype : wordtype
    /// translation : translation
    /// translation1 : translation1
    /// sourceDict : sourceDict
    /// fullSource : fullsource
    /// notes : notes
    /// Will look for a nah>es by default.
    /// :param query A string containing a NAH word.
    /// :param get2es Whether to look for a es>nah definition.
    /// :return A list of dicts containing the possible translations of query:
    static func getTranslations(query: String, get2es: Bool = false, completionHandler: @escaping ([[String : String]]) -> ()) {
        let group = DispatchGroup() // Compiles all async calls to getSoupEntry
        var entries: [[String : String]] = []
        group.enter()
        Self.getResults(query: query, get2es: get2es) { pks in
            for pk in pks {
                group.enter()
                Self.getSoupEntry(pk: pk) { soup in
                    
                    // Get all fields with thier corresponding value
                    do {
                        if let paragraphNodes = try soup?.getElementsByTag("p").first()?.getChildNodes() {
                            var entry: [String : String] = [:]
                            var newKeyFlag: Bool = false
                            var newKey: String = ""
                            for node in paragraphNodes {
                                if let nodeText = node as? TextNode {
                                    let valueText =  nodeText.text().trimmingCharacters(in: .whitespacesAndNewlines)
                                    if newKeyFlag && valueText != "" {
                                        entry[newKey] = valueText
                                        print("entered: \(newKey) : \(valueText)")
                                        newKeyFlag = false
                                    }
                                } else if let element = node as? Element {
                                    if element.tagName() == "b" {
                                        newKeyFlag = true
                                        newKey = try element.text().replacingOccurrences(of: ":", with: "")
                                    }
                                }
                            }
                            entries.append(entry)
                        } else {
                            print("error encontrando elementos en p")
                        }
                    } catch {
                        print("Error buscando en getTranslations")
                    }
                    group.leave()
                }
            }
            group.leave()
        }
        group.wait()
        print(entries)
        completionHandler(entries)
    }
    

}


