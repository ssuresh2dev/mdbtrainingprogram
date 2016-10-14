package mdb.project3.mdbevents;

import com.google.firebase.database.IgnoreExtraProperties;

import java.util.ArrayList;
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
    public String date;
    public String description;
    public List<String> peopleInterested = new ArrayList<>();

    public Event() {
        // Default constructor required for calls to DataSnapshot.getValue(User.class)
    }

    public Event(String aName, String aEmailAddress, int aNumInterested, String aImageUrl, String aTimestamp, String aDescription, String aDate, List<String> aPeopleInterested){
        name = aName;
        emailAddress = aEmailAddress;
        numInterested = aNumInterested;
        imageUrl = aImageUrl;
        timestamp = aTimestamp;
        date = aDate;
        peopleInterested = aPeopleInterested;
        description = aDescription;
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
