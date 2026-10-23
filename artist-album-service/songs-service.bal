import ballerina/http;
import ballerina/io;

const int PORT = 8086;
configurable string serviceURL = os:getEnv("CHOREO_CON1_SERVICEURL");
configurable string consumerKey = os:getEnv("CHOREO_CON1_CONSUMERKEY");
configurable string consumerSecret = os:getEnv("CHOREO_CON1_CONSUMERSECRET");
configurable string tokenURL = os:getEnv("CHOREO_CON1_TOKENURL");
configurable string choreoApiKey = os:getEnv("CHOREO_CON1_APIKEY");

type Album readonly & record {
    string title;
    string artist;
};

@display {
    id: "songs-backend",
    label: "songs_backend"
}
service /backend on new http:Listener(PORT) {
    private Album[] albums = [];

    resource function post albums(@http:Payload Album album) returns error? {
        // check caller->respond(http:ACCEPTED);
        self.albums.push(album);
    }

    resource function get albums/[string artistName]() returns Album[]|error? {
        io:println("artistName: " + artistName);
        io:println("serviceURL: " + serviceURL);
        io:println("consumerKey: " + consumerKey);
        io:println("tokenURL: " + tokenURL);
        io:println("choreoApiKey: " + choreoApiKey);
        Album[] artistAlbums = self.albums.filter(function (Album album) returns boolean {
            return album.artist == artistName;
        });

        // json payload = artistAlbums.toJson();

        // http:Response response = new;
        // response.setJsonPayload(payload);

        return artistAlbums;
    }
}
