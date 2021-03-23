import ballerina/test;
import ballerina/http;

# Test function

@test:Config {}
function testServiceFunction() {
    http:Request req = new();
    req.setJsonPayload({expr : "2*(7-3)"});

    http:Client clientEP = new ("http://localhost:9090");
    http:Response|error getResult = clientEP->get("/hello/sayHello", req);
    test:assertTrue(getResult is http:Response);
    http:Response response = <http:Response>getResult;
    test:assertEquals(response.getTextPayload().toString(), "8");
}
