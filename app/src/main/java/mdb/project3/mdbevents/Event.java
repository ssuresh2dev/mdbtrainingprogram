package mdb.project3.mdbevents;

import com.google.firebase.database.IgnoreExtraProperties;

import java.util.HashMap;
import java.util.List;
import java.util.ResourceBundle;

/**
 * Created by Kedar on 10/4/2016.
 */

@IgnoreExtraProperties
public class Event implements Comparable<Event>{

    public String name;
    public String emailAddress;
    public int numInterested;
    public String imageUrl;
    public String timestamp;
    public List<String> dates;

    public Event() {
        // Default constructor required for calls to DataSnapshot.getValue(User.class)
    }

    public Event(String aName, String aEmailAddress, int aNumInterested, String aImageUrl, String aTimestamp, List<String> aDates){
        name = aName;
        emailAddress = aEmailAddress;
        numInterested = aNumInterested;
        imageUrl = aImageUrl;
        timestamp = aTimestamp;
        dates = aDates;
    }
    public String getName(){
        return name;
    }

    public String getEmailAddress(){
        return emailAddress;
    }

    public int getNumInterested(){
        return numInterested;
    }

    public String getImageUrl(){
        return imageUrl;
    }

    public String getTimestamp(){
        return timestamp;
    }

    public int compareTo(Event other){
        return other.timestamp.compareTo(timestamp);
    }
}
