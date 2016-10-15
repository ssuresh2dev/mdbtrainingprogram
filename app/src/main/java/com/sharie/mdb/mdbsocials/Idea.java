package com.sharie.mdb.mdbsocials;

import android.os.Parcelable;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Sharie on 10/4/16.
 */

public class Idea{

    public String title;
    public String author;
    public String description;
    public int stars;
    public String key;
    public String email;
    public String date;

    public Idea(){}

    public Idea(String name, String author, String email, String describe, String key, String date, int stars){
        this.title = name;
        this.author = author;
        this.description = describe;
        this.key = key;
        this.email = email;
        this.stars = stars;
        this.date = date;
    }









}
