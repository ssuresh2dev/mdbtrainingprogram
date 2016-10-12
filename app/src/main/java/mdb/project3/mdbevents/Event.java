package mdb.project3.mdbevents;

import com.google.firebase.database.IgnoreExtraProperties;

import java.util.HashMap;
import java.util.ResourceBundle;

/**
 * Created by Kedar on 10/4/2016.
 */

@IgnoreExtraProperties
public class Event {

    public String name;
    public String emailAddress;
    public String numInterested;
    public String imageUrl;
    public String timestamp;

    public Event() {
        // Default constructor required for calls to DataSnapshot.getValue(User.class)
    }

    public Event(String aName, String aEmailAddress, String aNumInterested, String aImageUrl, String aTimestamp){
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

    public String getTimestamp(){
        return timestamp;
    }
}
