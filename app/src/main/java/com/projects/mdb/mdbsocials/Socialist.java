package com.projects.mdb.mdbsocials;

import android.graphics.Bitmap;
import android.util.Log;
import android.widget.Toast;

import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.GenericTypeIndicator;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;

/**
 * Created by Aayush on 10/4/2016.
 */

//long live the revolution
public class Socialist {
    private DatabaseReference ref;
    private ArrayList<Social> socialist;

    public Socialist() {
        socialist = new ArrayList<Social>();
        ref = FirebaseDatabase.getInstance().getReference("/socials");
        ref.orderByChild("date").addChildEventListener(new ChildEventListener() {
            @Override
            public void onChildAdded(DataSnapshot dataSnapshot, String s) {
                Log.d(dataSnapshot.getKey(), dataSnapshot.getValue().toString());
                if (dataSnapshot.child("interested").getValue() == null) {
                    socialist.add(new Social(dataSnapshot.getKey(),
                            dataSnapshot.child("creator").getValue(String.class),
                            dataSnapshot.child("date").getValue(String.class),
                            dataSnapshot.child("description").getValue(String.class),
                            dataSnapshot.child("name").getValue(String.class)));
                }
                else {
                    socialist.add(new Social(dataSnapshot.getKey(),
                            dataSnapshot.child("creator").getValue(String.class),
                            dataSnapshot.child("date").getValue(String.class),
                            dataSnapshot.child("description").getValue(String.class),
                            dataSnapshot.child("interested").getValue(Integer.class),
                            dataSnapshot.child("name").getValue(String.class),
                            dataSnapshot.child("interestedPeople").getValue(new GenericTypeIndicator<ArrayList<String>>() {
                            })));
                }
            }

            @Override
            public void onChildChanged(DataSnapshot dataSnapshot, String s) {

            }

            @Override
            public void onChildRemoved(DataSnapshot dataSnapshot) {

            }

            @Override
            public void onChildMoved(DataSnapshot dataSnapshot, String s) {

            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });

    }

    public ArrayList<Social> getSocialist() {
        return socialist;
    }

    public class Social{
        private String creator;
        private String date;
        private String description;
        private int interested = 0;
        private String id;
        private ArrayList<String> interestedPeople = new ArrayList<String>();
        //private Bitmap image;
        private String name;
        private String photoURL;

        public Social() {}

        public Social(String id, String creator, String date, String description, String name) {
            this.name = name;
            this.description = description;
            this.creator = creator;
            this.date = date;
            this.id = id;
        }

        public Social(String id, String creator, String date, String description, int interested, String name, ArrayList<String> interestedPeople) {
            this.name = name;
            this.interested = interested;
            this.description = description;
            this.creator = creator;
            this.date = date;
            this.id = id;
            this.interestedPeople = interestedPeople;
        }

        public String getCreator() {return creator;}
        public void setCreator(String creator) {this.creator = creator;}
        public String getDate() {return date;}
        public void setDate(String date) {this.date = date;}
        public String getDescription() {return description;}
        public void setDescription(String desc) {this.description = desc;}
        public int getInterested() {return interested;}
        public void setInterested(int n) {this.interested = n;}
        public String[] getInterestedPeople() {
            String[] s = new String[interestedPeople.size()];
            for(int i = 0; i < s.length; i++) {
                s[i] = interestedPeople.get(i);
            }
            return s;
        }
        public void setInterestedPeople(ArrayList<String> s) {
            interestedPeople = new ArrayList<String>();
            if (s != null) {
                for(int i = 0; i < s.size(); ++i) {
                    interestedPeople.add(s.get(i));
                }
            }
        }
        public String getName() {return name;}
        public void setName(String name) {this.name = name;}
        public String getID() {return id;}
        public void setID(String id) {this.id = id;}

        public void setPhotoURL(String url) {photoURL = url;}
    }
}
