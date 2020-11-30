//
//  DataMain.swift
//  COVID19-STATS
//
//  Created by PlugN on 30/11/2020.
//

import Foundation
import APIRequest

class DataMain {

    func oldermain() {
        // Configuration d'APIRequest pour préparer le téléchargement depuis covid.ourworldindata.org
        APIConfiguration.current = APIConfiguration(host: "covid.ourworldindata.org")
        // En raison de l'instabilité d'APIRequest dans un environement CLI, on interdit la completion dans le Main Thread
        APIConfiguration.current?.completionInMainThread = false

        print("Configuration terminée, téléchargement des données en cours...")

        //Téléchargement des données depuis le fichier JSON à retourner sous la forme data: [String:DataCountry]
        APIRequest("GET", path: "/data/owid-covid-data.json").execute([String:DataCountry].self) { data, status in
            // On vérifie l'intégrité du contenu décodé et le code statut HTTP 200 OK
            if var data = data, status == .ok {
                // Le test d'intégrité a réusi, data contient maintenant toutes les données du JSON
                // Notre base de données comprend un champ supplémentaire de synthèse pour le monde, on le retire pour pouvoir cumuler les statistiques des 190 pays.
                data.removeValue(forKey: "OWID_WRL")
                
                print("Données prêtes à l'exploitation.")
                
                // On calcule nos valeurs utiles, les affiche et termine l'opération
                let totalCases = data.values.map({ $0.cases }).reduce(0, +)
                let totalDeaths = data.values.map({ $0.deaths }).reduce(0, +)
                let totalPopulation = data.values.map({ $0.population ?? 0 }).reduce(0, +)
                let testByCase = data.values.map({ $0.testsByCase })
                let postiveRate = data.values.map({ $0.positiveRate })
                let totalTestsByCase =  testByCase.reduce(0, +) / Double(testByCase.count)
                let totalPositiveRate =  postiveRate.reduce(0, +) / Double(postiveRate.count)
                print("Nombre total de cas : \(totalCases)")
                print("Nombre total de décès : \(totalDeaths)")
                print("Nombre total de population : \(totalPopulation)")
                print("Test by cases: \(totalTestsByCase)")
                print("Positive Rate: \(totalPositiveRate)")
                exit(EXIT_SUCCESS)
            } else {
                // Le test d'intégrité à échoué, on affiche le code d'erreur et termine l'opération
                print("Le téléchargement ou décodage des données à échoué.")
                print("Code erreur : \(status)")
                exit(EXIT_FAILURE)
            }
        }

        // APIRequest fonctionne en asynchrone,et nécéssite l'ajout de cette ligne pour ne pas prématurément arrêter le programme
        dispatchMain()
    }

}
