package com.mdb.training.katharine.mdbsocials;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.graphics.Palette;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
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
import java.util.Map;

public class DetailsActivity extends AppCompatActivity {

    private TextView eventName, date, author, description;
    private Button numInterested;
    private int numInt;
    private ImageView eventPic;
    private CheckBox interested;
    private String uid;
    private Toolbar toolbar;
    // FloatingActionButton fab;
    private ArrayList<String> interestedName = new ArrayList<>();
    private ArrayList<String> interestedEmail = new ArrayList<>();
    private ArrayList<String> interestedUid = new ArrayList<>();
    public int color;
    public Bitmap bitmap;

    private DatabaseReference dbRef;
    private FirebaseAuth mAuth;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details);
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        dbRef = FirebaseDatabase.getInstance().getReference();
        mAuth = FirebaseAuth.getInstance();
        uid = FirebaseAuth.getInstance().getCurrentUser().getUid();

        eventPic = (ImageView) findViewById(R.id.picture);

        StorageReference storageRef = FirebaseStorage.getInstance().getReference().child(getIntent().getExtras().getString("firebasePath"));
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
                                    // Set the background color of a layout based on the vibrant color
                                    getWindow().getDecorView().setBackgroundColor(vibrant.getRgb());
                                }
                            }
                        });

                    }
                }.execute();


            }

        });

        /* Gets and sets data from intents passed from FeedActivity */
        eventName = (TextView) findViewById(R.id.eventName);
        eventName.setText(getIntent().getExtras().getString("title"));

        date = (TextView) findViewById(R.id.textView);
        date.setText(getIntent().getExtras().getString("date"));

        author = (TextView) findViewById(R.id.textView2);
        author.setText(getIntent().getExtras().getString("author"));

        description = (TextView) findViewById(R.id.textView3);
        description.setText(getIntent().getExtras().getString("description"));

        numInterested = (Button) findViewById(R.id.button);
        numInt = getIntent().getExtras().getInt("interested");
        numInterested.setText("Interested: " + numInt);
        interested = (CheckBox) findViewById(R.id.interested);

        /* Gets all the interested users for an activity and passes their names and emails to
            InterestedActivity
         */
        numInterested.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            dbRef.child("Users").addValueEventListener(new ValueEventListener() {
                @Override
                public void onDataChange(DataSnapshot dataSnapshot) {
                    interestedName = new ArrayList<String>();
                    interestedEmail = new ArrayList<String>();
                    for(DataSnapshot dsp: dataSnapshot.getChildren()) {
                        HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                        if(interestedUid.contains(map.get("uid"))){
                            interestedName.add((String) map.get("name"));
                            interestedEmail.add((String) map.get("email"));
                        }
                    }
                }

                @Override
                public void onCancelled(DatabaseError databaseError) {

                }
            });
            Intent intent = new Intent(getApplicationContext(),InterestedActivity.class);
            intent.putExtra("interestedName", interestedName);
            intent.putExtra("interestedEmail", interestedEmail);
            startActivity(intent);
            }
        });



        /* checks interested box if the user is interested */
        dbRef.child("Socials").addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for(DataSnapshot dsp: dataSnapshot.getChildren()) {
                    HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                    ArrayList<String> listInterested = (ArrayList<String>) map.get("interested");
                    if(listInterested == null){
                        listInterested = new ArrayList<String>();
                    }
                    if(map.get("name").equals(eventName.getText().toString())){
                        if(listInterested.contains(uid)) {
                            interested.setChecked(true);
                            numInterested.setText("Interested: " + listInterested.size());
                        }
                        interestedUid = listInterested;
                    }
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });


        dbRef.child("Users").addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                interestedName = new ArrayList<String>();
                interestedEmail = new ArrayList<String>();
                for(DataSnapshot dsp: dataSnapshot.getChildren()) {
                    HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                    if(interestedUid.contains(map.get("uid"))){
                        interestedName.add((String) map.get("name"));
                        interestedEmail.add((String) map.get("email"));
                    }
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });

    }

    public void onCheckboxClicked(View view) {
        // Is the view now checked?
        boolean checked = ((CheckBox) view).isChecked();

        // Check which checkbox was clicked
        switch(view.getId()) {
            case R.id.interested:
                if (checked) {
                    dbRef.child("Socials").addListenerForSingleValueEvent(new ValueEventListener() {
                        @Override
                        public void onDataChange(DataSnapshot dataSnapshot) {
                            for (DataSnapshot dsp: dataSnapshot.getChildren()) {
                                HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                                ArrayList<String> interestedList = (ArrayList<String>) map.get("interested"); // list of interested people for the current social
                                if (interestedList == null) {
                                    interestedList = new ArrayList<String>();
                                }
                                /*  * If the social's name matches the current social's name and the current user is not already included in interestedList,
                                      add the current user's uid to the social's list of interested users
                                 */
                                if (map.get("name").equals(eventName.getText().toString()) && !interestedList.contains(uid)) {
                                    interestedList.add(uid);
                                    dbRef.child("Socials").child(dsp.getKey()).child("interested").setValue(interestedList);
                                    numInt += 1;
                                    numInterested.setText("Interested: " + numInt);
                                }
                            }

                        }

                        @Override
                        public void onCancelled(DatabaseError databaseError) {

                        }
                    });
                } else {
                    dbRef.child("Socials").addListenerForSingleValueEvent(new ValueEventListener() {
                        @Override
                        public void onDataChange(DataSnapshot dataSnapshot) {
                            for (DataSnapshot dsp: dataSnapshot.getChildren()) {
                                HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                                ArrayList<String> interestedList = (ArrayList<String>) map.get("interested");
                                if (interestedList == null) {
                                    interestedList = new ArrayList<String>();
                                }
                                /*  * If the social's name == current social's name and current user is in interestedList,
                                        remove the current user's uid from interestedList
                                 */
                                if (map.get("name").equals(eventName.getText().toString()) && interestedList.contains(uid)) {
                                    interestedList.remove(uid);
                                    dbRef.child("Socials").child(dsp.getKey()).child("interested").setValue(interestedList);
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
                break;
        }
    }


    /**protected void onStop(){
        super.onStop();
        bitmap.recycle();
        bitmap=null;
    }

    protected void onStart(){
        super.onStart();
        eventPic = (ImageView) findViewById(R.id.picture);

        StorageReference storageRef = FirebaseStorage.getInstance().getReference().child(getIntent().getExtras().getString("firebasePath"));
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
                                    // Set the background color of a layout based on the vibrant color
                                    getWindow().getDecorView().setBackgroundColor(vibrant.getRgb());

                                }
                            }
                        });

                    }
                }.execute();

            }
        });
    }**/

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_details, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.logout:
                mAuth.signOut();
                startActivity(new Intent(this, MainActivity.class));
        }
        return super.onOptionsItemSelected(item);
    }


}
