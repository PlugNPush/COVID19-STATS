//
//  main.swift
//  COVID19-STATS
//
//  Created by PlugN on 30/11/2020.
//

import Foundation
import APIRequest

// Configuration d'APIRequest pour préparer le téléchargement depuis covid.ourworldindata.org
APIConfiguration.current = APIConfiguration(host: "blackmirror.plugn.fr")
// En raison de l'instabilité d'APIRequest dans un environement CLI, on interdit la completion dans le Main Thread
APIConfiguration.current?.completionInMainThread = false

print("Configuration terminée, téléchargement des données en cours...")

//Téléchargement des données depuis le fichier JSON à retourner sous la forme data: [String:DataCountry]
APIRequest("GET", path: "/confidential_pcr_test_source_hidden.json").execute([PCRStats].self) { data, status in
    // On vérifie l'intégrité du contenu décodé et le code statut HTTP 200 OK
    if let data = data, status == .ok {
        // Le test d'intégrité a réusi, data contient maintenant toutes les données du JSON
        
        print("Données prêtes à l'exploitation.")
        
        // On calcule nos valeurs utiles, les affiche et termine l'opération
        let totalPCR = data.map({ $0.pcr_positive == true ? 1 : 0 }).reduce(0, +)
        let totalCOVID = data.map({ $0.covid_positive == true ? 1 : 0 }).reduce(0, +)
        
        let total = data.count
        
        let vp = data.filter({$0.pcr_positive == true && $0.covid_positive == true })
        let fp = data.filter({ $0.pcr_positive == true && $0.covid_positive == false })
        let fn = data.filter({ $0.pcr_positive == false && $0.covid_positive == true })
        let vn = data.filter({ $0.pcr_positive == false && $0.covid_positive == false })
        
        let p_vp = PCRStats.p(vp, total)
        let p_fn = PCRStats.p(fn, total)
        let p_vn = PCRStats.p(vn, total)
        let p_fp = PCRStats.p(fp, total)
        
        let p_se = p_vp / (p_vp + p_fn)
        let p_sp = p_vn / (p_vn + p_fp)
        
        print("TOTAL PCR = \(totalPCR)")
        print("TOTAL COVID = \(totalCOVID)")
        print("SENSIBILITÉ = \(p_se)")
        print("SPECIFICITÉ = \(p_sp)")
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
