package com.demo.mdb.mdbsocials;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.widget.CheckBox;
import android.widget.ImageView;

import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

/**
 * Created by reddy on 10/12/2016.
 */

// THIS CLASS FUNCTIONS AS A UTILS CLASS AND CONTAINS METHODS USED IN THE ACTIVITIES
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
        String pushId;
        String description;
        String date;
        ArrayList<String> interestedPeople;

        public Event(String email, String name, String pushId, String description, String date,
                     ArrayList<String> interestedPeople) {
            this.email = email;
            this.name = name;
            this.pushId = pushId;
            this.description = description;
            this.date = date;
            this.interestedPeople = new ArrayList<String>();
            this.interestedPeople.add(0, "no one");
        }

        //method takes in name of event and imageview to set as parameters
        //method sets imageview by URL according to corresponding image stored in firebase
        public static void setImage(String eventNm, final ImageView img){
            StorageReference ref = FirebaseStorage.getInstance().getReferenceFromUrl("gs://mdb-socials-6fb87.appspot.com");
            StorageReference eventRef = ref.child(eventNm);
            eventRef.getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>() {
                @Override
                public void onSuccess(final Uri uri) {
                    AsyncTask<Void, Void, Bitmap> asyncTask = new AsyncTask<Void, Void, Bitmap>() {
                        @Override
                        protected Bitmap doInBackground(Void... params) {
                            return getBitmapFromURL(uri.toString());
                        }

                        public Bitmap getBitmapFromURL(String src) {
                            try {
                                URL url = new URL(src);
                                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                                connection.setDoInput(true);
                                connection.connect();
                                InputStream input = connection.getInputStream();
                                Bitmap myBitmap = BitmapFactory.decodeStream(input);
                                return myBitmap;
                            } catch (IOException e) {
                                return null;
                            }
                        }

                        @Override
                        protected void onPostExecute(Bitmap result) {
                            img.setImageBitmap(result);
                        }
                    }.execute();
                }
            });
        }

        //method's parameters take in user email, push key, and checkbox to be set
        //method saves checkbox state when entering detail activity
        public static void checkInterestedArray(final String user, String id, final CheckBox c){
            DatabaseReference dbref = FirebaseDatabase.getInstance().getReference();
            ValueEventListener eventListener = new ValueEventListener() {
                @Override
                public void onDataChange(DataSnapshot dataSnapshot) {
                    ArrayList<String> interestedPeople = (ArrayList<String>) dataSnapshot.getValue();
                    if (interestedPeople.contains(user)) {
                        c.setChecked(true);
                    }
                    else{
                        c.setChecked(false);
                    }
                }

                @Override
                public void onCancelled(DatabaseError databaseError) {}
            };
            dbref.child("Events").child(id).child("interestedPeople").addValueEventListener(eventListener);
        }
    }
}