package com.demo.mdb.mdbsocials;

import java.util.ArrayList;

/**
 * Created by reddy on 10/12/2016.
 */

public class EventList {
    public ArrayList<Event> eventArrayList;

    public EventList() {
        this.eventArrayList = new ArrayList<>();
    }

    public ArrayList<Event> getArrayList() {
        return eventArrayList;
    }

    public static class Event {
        String email;
        String name;
        String pictureURL;
        String description;
        String date;
        ArrayList<String> interestedPeople;

        public Event(String email, String name, String pictureURL, String description, String date,
                     ArrayList<String> interestedPeople) {
            this.email = email;
            this.name = name;
            this.pictureURL = pictureURL;
            this.description = description;
            this.date = date;
            this.interestedPeople = interestedPeople;
        }
    }
}