package com.mdb.training.katharine.mdbsocials;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.graphics.Palette;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.auth.FirebaseAuth;
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
import java.util.HashMap;

public class DetailsActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView eventName, date, author, description;
    private Button numInterested;
    private int numInt;
    private ImageView eventPic;
    private CheckBox interested;
    private String uid;
    private Toolbar toolbar;
    private ArrayList<String> interestedNames;
    private ArrayList<String> interestedEmails;
    private ArrayList<String> interestedUids;
    public int color;
    public Bitmap bitmap;
    public android.app.ActionBar actionbar;

    private DatabaseReference dbRef;
    private FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details);
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        actionbar = getActionBar();

        dbRef = FirebaseDatabase.getInstance().getReference();
        mAuth = FirebaseAuth.getInstance();
        uid = FirebaseAuth.getInstance().getCurrentUser().getUid();
        interestedNames = new ArrayList<>();
        interestedEmails = new ArrayList<>();
        interestedUids = new ArrayList<>();
        eventPic = (ImageView) findViewById(R.id.picture);

        /* Async task */
        StorageReference storageRef = FirebaseStorage.getInstance().getReference()
                .child(getIntent().getExtras().getString("firebasePath"));
        storageRef.getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>() {
            @Override
            public void onSuccess(final Uri downloadUrl) {

                AsyncTask<Void, Void, Bitmap> asyncTask = new AsyncTask<Void, Void, Bitmap>() {

                    @Override
                    protected Bitmap doInBackground(Void... params) {
                        return getBitmapFromURL(downloadUrl.toString());
                    }

                    public Bitmap getBitmapFromURL(String src) {
                        try {
                            URL url = new URL(src);
                            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                            connection.setDoInput(true);
                            connection.connect();
                            InputStream input = connection.getInputStream();
                            bitmap = BitmapFactory.decodeStream(input);
                            return bitmap;
                        } catch (IOException e) {
                            // Log exception
                            return null;
                        }
                    }

                    @Override
                    protected void onPostExecute(Bitmap result) {
                        eventPic.setImageBitmap(result);
                        Palette.from(result).generate(new Palette.PaletteAsyncListener() {
                            public void onGenerated(Palette p) {
                                Palette.Swatch vibrant = p.getVibrantSwatch();
                                if (vibrant != null) {
                                    // Set the background color of a layout based on color
                                    getWindow().getDecorView().setBackgroundColor(vibrant.getRgb());
                                }
                            }
                        });

                    }
                }.execute();
            }

        });

        setData();
        checkInterestedBox();
    }

    /* Gets and sets data from intents passed from FeedActivity */
    public void setData() {
        eventName = (TextView) findViewById(R.id.eventName);
        eventName.setText(getIntent().getExtras().getString("title"));

        date = (TextView) findViewById(R.id.textView);
        date.setText("Date: " + getIntent().getExtras().getString("date"));

        author = (TextView) findViewById(R.id.textView2);
        author.setText("Created by: " + getIntent().getExtras().getString("author"));

        description = (TextView) findViewById(R.id.textView3);
        description.setText("Event details: " + getIntent().getExtras().getString("description"));

        numInterested = (Button) findViewById(R.id.button);
        numInt = getIntent().getExtras().getInt("interested");
        numInterested.setText("Interested: " + numInt);
        numInterested.setOnClickListener(this);

        interested = (CheckBox) findViewById(R.id.interested);

    }

    /*  * Checks if current user is interested in current social
        * Sets interestedUids to initial list of interested users
     */
    public void checkInterestedBox() {
        dbRef.child("Socials").addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for(DataSnapshot dsp: dataSnapshot.getChildren()) {
                    HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                    ArrayList<String> interestedList = (ArrayList<String>) map.get("interested");
                    if(interestedList == null){
                        interestedList = new ArrayList<String>();
                    }
                    if(map.get("name").equals(eventName.getText().toString())){
                        if(interestedList.contains(uid)) {
                            interested.setChecked(true);
                        }
                        interestedUids = interestedList;
                    }
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }

    /* Handles pressing the Interested people button */
    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            /*  If the Interested button is clicked, put all the interested people and their
                emails in intents and send to InterestedActivity */
            case R.id.button:
                dbRef.child("Users").addValueEventListener(new ValueEventListener() {
                    @Override
                    public void onDataChange(DataSnapshot dataSnapshot) {
                        interestedNames = new ArrayList<String>();
                        interestedEmails = new ArrayList<String>();
                        for (DataSnapshot dsp: dataSnapshot.getChildren()) {
                            HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                            if (interestedUids.contains(map.get("uid"))) {
                                interestedNames.add((String) map.get("name"));
                                interestedEmails.add((String) map.get("email"));
                            }
                        }
                        Intent intent = new Intent(DetailsActivity.this, InterestedActivity.class);
                        intent.putExtra("interestedName", interestedNames);
                        intent.putExtra("interestedEmail", interestedEmails);
                        startActivity(intent);
                    }

                    @Override
                    public void onCancelled(DatabaseError databaseError) {

                    }
                });
                break;
        }
    }

    /*  * Handles checking and unchecking the interested box
     *  * Updates the number of interested people when you check/uncheck */
    public void onCheckboxClicked(View view) {
        // Is the view now checked?
        boolean checked = ((CheckBox) view).isChecked();
        // Check which checkbox was clicked
        switch(view.getId()) {
            case R.id.interested:
                if (checked) {
                    checkInterested();
                } else {
                    uncheckInterested();
                }
                break;
        }
    }

    /* Helper function for when a user checks the interested box */
    public void checkInterested() {
        dbRef.child("Socials").addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot dsp: dataSnapshot.getChildren()) {
                    HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                    // list of interested people for the current social
                    ArrayList<String> interestedList = (ArrayList<String>) map.get("interested");
                    if (interestedList == null) {
                        interestedList = new ArrayList<String>();
                    }
                    /* If the social's name matches the current social's name and the
                        current user is not already included in interestedList,
                        add the current user's uid to the social's list of interested users */
                    if (map.get("name").equals(eventName.getText().toString()) &&
                            !interestedList.contains(uid)) {
                        interestedList.add(uid);
                        dbRef.child("Socials").child(dsp.getKey()).child("interested")
                                .setValue(interestedList);
                        numInt += 1;
                        numInterested.setText("Interested: " + numInt);
                    }
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }

    /* Helper function for when a user unchecks the interested box */
    public void uncheckInterested() {
        dbRef.child("Socials").addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot dsp: dataSnapshot.getChildren()) {
                    HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                    ArrayList<String> interestedList = (ArrayList<String>) map.get("interested");
                    if (interestedList == null) {
                        interestedList = new ArrayList<String>();
                    }
                    /* If the social's name == current social's name and
                        current user is in interestedList,
                        remove the current user's uid from interestedList */
                    if (map.get("name").equals(eventName.getText().toString()) &&
                            interestedList.contains(uid)) {
                        interestedList.remove(uid);
                        dbRef.child("Socials").child(dsp.getKey()).child("interested")
                                .setValue(interestedList);
                        numInt -= 1;
                        numInterested.setText("Interested: " + numInt);
                    }
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });

    }

    /* When a user presses back, recycle to fix memory issues */
    public void onBackPressed(){
        bitmap.recycle();
        bitmap=null;
        super.onBackPressed();
    }

    /* Inflates menu bar */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_details, menu);
        return super.onCreateOptionsMenu(menu);
    }

    /* Handles logout from menu bar */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.logout:
                FirebaseUtils fb = new FirebaseUtils(mAuth);
                fb.signOut();
                startActivity(new Intent(this, MainActivity.class));
        }
        return super.onOptionsItemSelected(item);
    }

}
