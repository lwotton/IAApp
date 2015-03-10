import twitter4j.util.*;
import twitter4j.*;
import twitter4j.management.*;
import twitter4j.api.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.auth.*;
import java.util.*;
import ketai.sensors.*;
//Static point - GeoLocation geo = new GeoLocation(50.3752770, -4.1366650);
Twitter twitter;
List<Status> tweets;
int currentTweet;
double longitude, latitude;
KetaiLocation location;

void setup()
{
    size(800,600);
    //Twitter
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("8g521OjdDD4zE7i4aQ6kEtm7c");
    cb.setOAuthConsumerSecret("KZhbk3fDVOagZw8isOXgE4oFUwGRbCwxcip051uRommPk80QZG");
    cb.setOAuthAccessToken("15146063-zSMl0g0wDOtMSHCjswqYlykp9LU3BqwkWwk3yzQOT");
    cb.setOAuthAccessTokenSecret("apaEUUzNUltgzqgU6X9o6AXtCNcCLVRZmOyU410nM6SiI");
    TwitterFactory tf = new TwitterFactory(cb.build());
    twitter = tf.getInstance();
    getNewTweets();
    currentTweet = 0;
    thread("refreshTweets");
    //Android Location
    location = new KetaiLocation(this);
}

void draw()
{
    fill(0, 40);
    rect(0, 0, width, height);

    currentTweet = currentTweet + 1;

    if (currentTweet >= tweets.size())
    {
        currentTweet = 0;
    }

    Status status = tweets.get(currentTweet);

    fill(200);
    text(status.getText(), random(width), random(height), 300, 200);

    delay(250);
}

void getNewTweets()
{
    try 
    {
        Query query = new Query().geoCode(geo,1,"mi");

        QueryResult result = twitter.search(query);

        tweets = result.getTweets();
    } 
    catch (TwitterException te) 
    {
        System.out.println("Failed to search tweets: " + te.getMessage());
        System.exit(-1);
    } 
}

void refreshTweets()
{
    while (true)
    {
        getNewTweets();

        println("Updated Tweets"); 

        delay(30000);
    }
}