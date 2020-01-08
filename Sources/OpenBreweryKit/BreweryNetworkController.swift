//
//  Created by August Shultz on 10/29/19.
//

import Foundation

enum BreweryNetworkControllerError: Error {
  case invalidURL, noDataReturned, dataParsingError
}

struct BreweryNetworkController {
  let session: URLSession

  init(session: URLSession = URLSession.shared) {
    self.session = session
  }

  func getBreweries(forCity city: String, _ completion: @escaping (Result<[Brewery], Error>) -> Void) {
    var components = URLComponents(string: "https://api.openbrewerydb.org/breweries")

    components?.queryItems = [URLQueryItem(name: "by_city", value: city)]
    guard let url = components?.url else {
      completion(.failure(BreweryNetworkControllerError.invalidURL))
      return
    }

    fetchBreweries(fromUrl: url, completion)
  }

  func filterBreweries(byName name: String, _ completion: @escaping (Result<[Brewery], Error>) -> Void) {
    var components = URLComponents(string: "https://api.openbrewerydb.org/breweries")

    components?.queryItems = [URLQueryItem(name: "by_name", value: name)]
    guard let url = components?.url else {
      completion(.failure(BreweryNetworkControllerError.invalidURL))
      return
    }

    fetchBreweries(fromUrl: url, completion)
  }

  func getBrewery(forId id: UInt, _ completion: @escaping (Result<Brewery, Error>) -> Void) {
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

  func getBreweries(_ completion: @escaping ((Result<[Brewery], Error>) -> Void)) {

    guard let url = URL(string: "https://api.openbrewerydb.org/breweries") else {
      completion(.failure(BreweryNetworkControllerError.invalidURL))
      return
    }
    fetchBreweries(fromUrl: url, completion)
  }

  func searchForBreweries(searchText: String, _ completion: @escaping (Result<[Brewery], Error>) -> Void) {

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
