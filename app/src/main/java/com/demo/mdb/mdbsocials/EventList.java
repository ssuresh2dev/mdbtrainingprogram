package com.demo.mdb.mdbsocials;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import java.io.IOException;
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
        Bitmap picture;
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

        public static Bitmap decodeFromFirebase(String image) throws IOException {
            byte[] decodedByteArray = android.util.Base64.decode(image, Base64.DEFAULT);
            return BitmapFactory.decodeByteArray(decodedByteArray, 0, decodedByteArray.length);
        }
    }
}