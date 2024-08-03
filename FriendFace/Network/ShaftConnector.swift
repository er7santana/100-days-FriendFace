//
//  ShaftConnector.swift
//  FriendFace
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 03/08/24.
//

import Foundation

class ShaftConnector: NSObject {
    private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    private let certificates: [Data] = {
        let url = Bundle.main.url(forResource: "certadmin", withExtension: "cer")!
        let data = try! Data(contentsOf: url)
        return [data]
    }()
    
    let pinnedCertificates: [SecCertificate] = {
        let pinnedCertificateData = try! Data(contentsOf: Bundle.main.url(forResource: "certadmin", withExtension: "cer")!)
        let pinnedCertificates = [SecCertificateCreateWithData(nil, pinnedCertificateData as CFData)!]
        return pinnedCertificates
    }()
    
    func data(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await session.data(for: urlRequest)
    }
}

extension ShaftConnector: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if let trust = challenge.protectionSpace.serverTrust,
           SecTrustGetCertificateCount(trust) > 0 {
            
            if let serverCertificates = SecTrustCopyCertificateChain(trust) as? [SecCertificate] {
                let data = Set(
                    serverCertificates.map { SecCertificateCopyData($0) as Data }
                )
                
                if certificates.contains(data) {
                    completionHandler(.useCredential, URLCredential(trust: trust))
                    return
                } else {
                    //TODO: Throw SSL Certificate Mismatch
                }
            }
//            
//            
//            if let certificate = SecTrustCopyCertificateChain(trust) {
//                
//                certificate[0]
//                
//                if pinnedCertificates.contains(certificate) {
//                    
//                }
//                
//                
//                let data = SecCertificateCopyData(certificate as! SecCertificate) as Data
//                
//                if certificates.contains(data) {
//                    completionHandler(.useCredential, URLCredential(trust: trust))
//                    return
//                } else {
//                    //TODO: Throw SSL Certificate Mismatch
//                }
//            }
            
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
