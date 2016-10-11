package com.mdb.training.katharine.mdbsocials;

import java.lang.reflect.Array;
import java.util.ArrayList;

/**
 * Created by KJ on 10/4/16.
 */

public class SocialsList {

    public ArrayList<Social> socials;

    public SocialsList() {
        socials = new ArrayList<>();
    }

    public void addSocial(String title, String author, String descrip, String date) {
        Social social = new Social(title, author, descrip, date);
        socials.add(social);
    }

    public ArrayList<Social> getSocials() {
        return socials;
    }


    public static class Social {
        public String title;
        public String author;
        public String description;
        public ArrayList<String> interested;
        public String date;

        public Social() {

        }

        public Social(String title, String author, String description, String date) {
            this.title = title;
            this.author = author;
            this.description = description;
            this.date = date;
            this.interested = new ArrayList<>();
        }

        public void addInterested(String uid) {
            interested.add(uid);
        }
    }



}
