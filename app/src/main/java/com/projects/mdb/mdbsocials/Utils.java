package com.projects.mdb.mdbsocials;

import android.content.Context;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.AsyncTask;
import android.support.annotation.NonNull;
import android.support.v7.graphics.Palette;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.GenericTypeIndicator;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FirebaseStorage;

import java.util.ArrayList;

/**
 * Created by Aayush on 10/4/2016.
 */

//long live the revolution
public class Utils {
    private DatabaseReference ref;
    private ArrayList<Social> socialist;

    /**
     * initializes list of socials Socialist
     */
    public Utils() {
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

    /**
     * @return the list of socials
     */
    public ArrayList<Social> getSocialist() {
        return socialist;
    }

    /**
     * A class to represent a social
     */
    public class Social{
        private String creator;
        private String date;
        private String description;
        private int interested = 0;
        private String id;
        private String name;

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
        }

        //TODO get rid of unused functions
        public String getCreator() {return creator;}
        public void setCreator(String creator) {this.creator = creator;}
        public String getDate() {return date;}
        public String getDescription() {return description;}
        public int getInterested() {return interested;}
        public String getName() {return name;}
        public void setName(String name) {this.name = name;}
        public String getID() {return id;}
    }

    /**
     * sets the bitmap of the image view and the background color using Palette
     * @param context
     * @param view containing view of imageViewId
     * @param imageViewId
     * @param id
     */
    public static void setBitmap(final Context context, final View view, final int imageViewId, String id) {
        class DownloadFilesTask extends AsyncTask<String, Void, Bitmap> {
            protected Bitmap doInBackground(String... strings) {
                try {return Glide.
                        with(context).
                        load(strings[0]).
                        asBitmap().
                        into(100, 100). // Width and height
                        get();}
                catch (Exception e) {return null;}
            }

            protected void onProgressUpdate(Void... progress) {}

            protected void onPostExecute(Bitmap result) {
                ((ImageView)view.findViewById(imageViewId)).setImageBitmap(result);
                Palette.PaletteAsyncListener paletteListener = new Palette.PaletteAsyncListener() {
                    public void onGenerated(Palette palette) {
                        int defaulto = 0x000000;
                        view.setBackgroundColor(palette.getDominantColor(defaulto));
                    }
                };
                if (result != null && !result.isRecycled()) {
                    Palette.from(result).generate(paletteListener);
                }
            }
        }

        FirebaseStorage.getInstance().getReferenceFromUrl("gs://mdbsocials-700a9.appspot.com").child(id + ".png").getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>() {
            @Override
            public void onSuccess(Uri uri) {
                Log.d("ye", uri.toString());
                new DownloadFilesTask().execute(uri.toString());
            }
        }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception exception) {
                Log.d("sad", exception.toString());
            }
        });
    }
}
