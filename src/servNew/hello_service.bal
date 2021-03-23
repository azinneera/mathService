import ballerina/http;
import ballerina/io;

http:Client mathClient = new("https://api.mathjs.org/");

# A service representing a network-accessible API
# bound to port `9090`.
service hello on new http:Listener(9090) {

    # A resource respresenting an invokable API method
    # accessible at `/hello/sayHello`.
    #
    # + caller - the client invoking this resource
    # + request - the inbound request
    resource function sayHello(http:Caller caller, http:Request request) {
        json jsonPayload = <json>request.getJsonPayload();
        http:Response|error getResult = mathClient->get(<@untained> ("/v4/?expr=" + <string>jsonPayload.expr));
        // Send a response back to the caller.
        error? result;
        if (getResult is http:Response) {
            result = caller->respond(<http:Response>getResult);
        } else {
            result = caller->respond("request failed!");
        }
        
        if (result is error) {
            io:println("Error in responding: ", result);
        }
    }
}
