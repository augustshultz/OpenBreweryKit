//
//  Created by August Shultz on 10/29/19.
//

import Foundation

class URLProtocolMock: URLProtocol {

  static var urls: [URL: Data] = [:]

  override func startLoading() {
    if let url = request.url, let data = URLProtocolMock.urls[url] {
      self.client?.urlProtocol(self, didLoad: data)
    }
    self.client?.urlProtocolDidFinishLoading(self)
  }

  override class func canInit(with request: URLRequest) -> Bool { true }
  override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
  override func stopLoading() { }
}
