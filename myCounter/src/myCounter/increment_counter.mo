// Create a simple Counter actor.
import Text "mo:base/Text";
import Nat "mo:base/Nat";

actor Counter {
  stable var currentValue : Nat = 0;

  // Increment the counter with the increment function.
  public func increment() : async () {
    currentValue += 1;
  };

  // Read the counter value with a get function.
  public query func get() : async Nat {
    currentValue
  };

  // Write an arbitrary value with a set function.
  public func set(n: Nat) : async () {
    currentValue := n;
  };
type HeaderField = (Text, Text);
type StreamingCallbackHttpResponse = {
    body: Blob;
    token: ?Token;
};
type Token = {}; // 对象类型，可根据需要添加参数
type StreamingStrategy = {
    #Callback: {
        callback: shared (Token) -> async (StreamingCallbackHttpResponse);
        token: Token;
    }
};
type HttpRequest =  {
    method: Text;
    url: Text;
    headers: [HeaderField];        
    body: Blob;
};
type HttpResponse = {
    status_code: Nat16;
    headers: [HeaderField];
    body: Blob;
    streaming_strategy: ?StreamingStrategy;
};

    public query func http_request(request: HttpRequest): async HttpResponse {
        if(request.url == "/CurrentValue") {
            {
                status_code = 200;
                headers = [];
                body = Text.encodeUtf8(Nat.toText(currentValue));
                streaming_strategy = null;
            }
        } else {
            {
              
                status_code = 404;
                headers = [];
                body = Text.encodeUtf8("worng url");
                streaming_strategy = null;
            }
        }
    };

}