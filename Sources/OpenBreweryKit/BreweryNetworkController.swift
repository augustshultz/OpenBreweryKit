//
//  Created by August Shultz on 10/29/19.
//

import Foundation

public enum BreweryNetworkControllerError: Error {
  case invalidURL, noDataReturned, dataParsingError, invalidZip
}

public struct BreweryNetworkController {
  let session: URLSession

  init(session: URLSession = URLSession.shared) {
    self.session = session
  }

  public func filterBreweries(
    byCity city: String? = nil,
    byName name: String? = nil, byZip zip: String? = nil,
    byState state: String? = nil,
    byType type: BreweryType? = nil,
    byTags tags: [String] = [],
    _ completion: @escaping (Result<[Brewery], Error>) -> Void
  ) {
    var components = URLComponents(string: "https://api.openbrewerydb.org/breweries")
    var queryItems: [URLQueryItem] = []
    if let city = city {
      queryItems.append(URLQueryItem(name: "by_city", value: city))
    }
    if let name = name {
      queryItems.append(URLQueryItem(name: "by_name", value: name))
    }
    if let state = state {
      queryItems.append(URLQueryItem(name: "by_state", value: state))
    }
    if let type = type {
      queryItems.append(URLQueryItem(name: "by_type", value: type.rawValue))
    }
    if tags.count > 0 {
      queryItems.append(URLQueryItem(name: "by_tags", value: tags.joined(separator: ",")))
    }
    if let zip = zip {
      if !zip.isZipCode() {
        completion(.failure(BreweryNetworkControllerError.invalidZip))
        return
      }
      queryItems.append(URLQueryItem(name: "by_postal", value: zip))
    }
    components?.queryItems = queryItems
    guard let url = components?.url else {
      completion(.failure(BreweryNetworkControllerError.invalidURL))
      return
    }
    fetchBreweries(fromUrl: url, completion)
  }

  public func getBrewery(forId id: UInt, _ completion: @escaping (Result<Brewery, Error>) -> Void) {
    guard let url = URL(string: "https://api.openbrewerydb.org/breweries/\(id)") else {
      completion(.failure(BreweryNetworkControllerError.invalidURL))
      return
    }
    let task = session.dataTask(with: url) { (data, _, error) in
      if let error = error {
        completion(.failure(error))
        return
      }
      guard let data = data else {
        completion(.failure(BreweryNetworkControllerError.noDataReturned))
        return
      }
      do {
        let decoder = JSONDecoder()
        completion(.success(try decoder.decode(Brewery.self, from: data)))
      } catch _ {
        completion(.failure(BreweryNetworkControllerError.dataParsingError))
        return
      }
    }
    task.resume()
  }

  public func getBreweries(_ completion: @escaping ((Result<[Brewery], Error>) -> Void)) {
    guard let url = URL(string: "https://api.openbrewerydb.org/breweries") else {
      completion(.failure(BreweryNetworkControllerError.invalidURL))
      return
    }
    fetchBreweries(fromUrl: url, completion)
  }

  public func searchForBreweries(searchText: String, _ completion: @escaping (Result<[Brewery], Error>) -> Void) {
    guard let url = URL(string: "https://api.openbrewerydb.org/breweries/search"),
      var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
        completion(.failure(BreweryNetworkControllerError.invalidURL))
        return
    }
    urlComponents.queryItems = [URLQueryItem(name: "query", value: searchText)]
    guard let searchUrl = urlComponents.url else {
      completion(.failure(BreweryNetworkControllerError.invalidURL))
      return
    }
    fetchBreweries(fromUrl: searchUrl, completion)
  }

  func fetchBreweries(fromUrl url: URL, _ completion: @escaping (Result<[Brewery], Error>) -> Void) {
    let task = session.dataTask(with: url) { (data, _, error) in
      if let error = error {
        completion(.failure(error))
        return
      }
      guard let data = data else {
        completion(.failure(BreweryNetworkControllerError.noDataReturned))
        return
      }
      do {
        let decoder = JSONDecoder()
        completion(.success(try decoder.decode([Brewery].self, from: data)))
      } catch let error {
        completion(.failure(error))
        return
      }
    }
    task.resume()
  }
}
