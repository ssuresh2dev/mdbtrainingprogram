package mdb.project3.mdbevents;

import java.util.HashMap;

/**
 * Created by Kedar on 10/4/2016.
 */

public class Event {

    String name;
    String emailAddress;
    String numInterested;
    String imageUrl;
    HashMap timestamp;

    public Event(String aName, String aEmailAddress, String aNumInterested, String aImageUrl, HashMap aTimestamp){
        name = aName;
        emailAddress = aEmailAddress;
        numInterested = aNumInterested;
        imageUrl = aImageUrl;
        timestamp = aTimestamp;
    }
    public String getName(){
        return name;
    }

    public String getEmailAddress(){
        return emailAddress;
    }

    public String getNumInterested(){
        return numInterested;
    }

    public String getImageUrl(){
        return imageUrl;
    }

    public HashMap getTimestamp(){
        return timestamp;
    }
}
