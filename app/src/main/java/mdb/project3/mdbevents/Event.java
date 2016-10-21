package mdb.project3.mdbevents;

import com.google.firebase.database.IgnoreExtraProperties;

import java.util.ArrayList;
import java.util.List;

/**
 * Event implements a way to manage user-created events that have descriptions.
 *
 * @author Emaan Hariri, Sayan Paul, Kedar Thakkar
 * @since 10-4-2016
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
        // Default constructor required for calls to DataSnapshot.getValue(Event.class)
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

    // Getter methods for class attributes
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

    // Implement the compareTo method such that the timestamps of the event and the other event passed in are compared
    public int compareTo(Event other){
        return other.timestamp.compareTo(timestamp);
    }
}
