package room;

import cartago.Artifact;
import cartago.*;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

/**
 * A CArtAgO artifact that provides an operation for sending messages to agents 
 * with KQML performatives using the dweet.io API
 */
public class DweetArtifact extends Artifact {
    
    
    void init() {
    }

    @OPERATION
    void sendDweet(String friendName, String message) {
        String thingName = friendName; // Unique identifier for the friend
        String dweetURL = "https://dweet.io/dweet/for/" + thingName; 
        /*https://dweet.io:443/dweet/for/stephannef */

        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(dweetURL))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(message))
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                log("Message sent successfully to " + friendName);
            } else {
                log("Failed to send message to " + friendName);
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
