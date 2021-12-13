import Foundation

enum WebAPIError: Error {
    case invalidRequest
    case noBodyContent
case invalidBodyContent(reason: String)
}

/// Web APIへリクエストを行うクライアント
///
enum WebAPIClient{
    static let scheme = "http"
    static let host = "localhost"
    static let port = 3000
    static let path = "/steps"
    
    ///読み上げるメッセージの一覧を取得するメソッド
    /// -Parameters:
    ///  -parameters: クエリ文字列として設定する値
    ///  -handler: レスポンス取得後に実行するコールバック
    static func getMessages(
        parameters: [String: String],
        handler: @escaping (Result<[WebMessage], WebAPIError >) -> Void) {
        
        ///リクエスト先のURLを指定して、URLオブジェクトを作成
        ///TODO2-1 URLComponentsオブジェクトを作成し、パスまでの部分を設定
        var components = URLComponents()
            components.scheme = self.scheme
            components.port = self.port
            components.path = self.path
        
        ///TODO2-2 URLComponentsにリクエストパラメータ（クエリパラメータ）を指定
            components.queryItems = parameters.map{(key, value) -> URLQueryItem in
                URLQueryItem(name: key, value: value)
            }
        
        ///TODO2-3 URLComponentsから　URLを作成
            let url = components.url!
        
        ///TODO3 URLRequestを作成
            let request = URLRequest(url:url)
        
        ///TODO4 URLSessionから、データ送受信を行うタスクを作成
            let task = URLSession.shared.dataTask(with:request){(data, response, error) in
                let result: Result<[WebMessage], WebAPIError>
            
                defer {
                    DispatchQueue.main.async{
                        handler(result)
                    }
                }
                
                //レスポンスのステータスコードが200(ok)出なければエラー
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          result = .failure(.invalidRequest)
                          return
                      }
                //レスポンスボディが取得できない場合はfailure
                guard let data = data else {
                    result = .failure(.noBodyContent)
                    return
                }
                
                //JSONのデコードが成功すればsuccess, 失敗した場合はfailure
                do {
                    let decoder = JSONDecoder()
                    let message = try decoder.decode([WebMessage].self, from: data)
                
                    result = .success(message)
                }catch {
                    result = .failure(.invalidBodyContent(reason:"\(error)"))
                }
            }
            // TODO5. タスクを実行
            task.resume()
    }
}
