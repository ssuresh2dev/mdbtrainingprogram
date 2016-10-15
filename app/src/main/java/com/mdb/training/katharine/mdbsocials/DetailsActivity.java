package com.mdb.training.katharine.mdbsocials;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
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
    private ImageView eventPic;
    private CheckBox interested;
    private String uid;
    private Toolbar toolbar;
    FloatingActionButton fab;
    private ArrayList<String> interestedName = new ArrayList<>();
    private ArrayList<String> interestedEmail = new ArrayList<>();
    private ArrayList<String> interestedUid = new ArrayList<>();

    private DatabaseReference dbRef;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details);
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        dbRef = FirebaseDatabase.getInstance().getReference();
        uid = FirebaseAuth.getInstance().getCurrentUser().getUid();

        eventPic = (ImageView) findViewById(R.id.picture);

        StorageReference storageRef = FirebaseStorage.getInstance().getReference().child(getIntent().getExtras().getString("firebasePath"));
        storageRef.getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>()
        {
            @Override
            public void onSuccess(final Uri downloadUrl)
            {


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
                            Bitmap bitmap = BitmapFactory.decodeStream(input);
                            return bitmap;
                        } catch (IOException e) {
                            // Log exception
                            return null;
                        }
                    }


                    @Override
                    protected void onPostExecute(Bitmap result) {
                        eventPic.setImageBitmap(result);
                    }
                }.execute();


            }

        });





        eventName = (TextView) findViewById(R.id.eventName);
        eventName.setText(getIntent().getExtras().getString("title"));

        date = (TextView) findViewById(R.id.textView);
        date.setText(getIntent().getExtras().getString("date"));

        author = (TextView) findViewById(R.id.textView2);
        author.setText(getIntent().getExtras().getString("author"));

        description = (TextView) findViewById(R.id.textView3);
        description.setText(getIntent().getExtras().getString("description"));

        numInterested = (Button) findViewById(R.id.button);
        numInterested.setText("Interested: " + getIntent().getExtras().getInt("interested"));


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
        interested = (CheckBox) findViewById(R.id.interested);
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







        interested.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    ValueEventListener postListener = new ValueEventListener() {
                        @Override
                        public void onDataChange(DataSnapshot dataSnapshot) {
                            for(DataSnapshot dsp: dataSnapshot.getChildren()){
                                HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                                ArrayList<String> listInterested = (ArrayList<String>) map.get("interested");
                                if(listInterested == null){
                                    listInterested = new ArrayList<String>();
                                }

                                if (map.get("name").equals(eventName.getText().toString()) && !listInterested.contains(uid)) {
                                    listInterested.add(uid);
                                    Map<String, Object> newMap = new HashMap<String, Object>();
                                    newMap.put("name", map.get("name"));
                                    newMap.put("author", map.get("author"));
                                    newMap.put("date", map.get("date"));
                                    newMap.put("description", map.get("description"));
                                    newMap.put("path", map.get("path"));
                                    newMap.put("interested", listInterested);
                                    dbRef.child("Socials").child(dsp.getKey()).setValue(newMap);

                                }

                            }

                        }
                        @Override
                        public void onCancelled(DatabaseError databaseError) {
                            Log.w("TAG", "loadPost:onCancelled", databaseError.toException());
                        }

                    };
                    dbRef.child("Socials").addValueEventListener(postListener);
                }
                else {
                    Log.d("test", "unchecked");
                    ValueEventListener postListener = new ValueEventListener() {
                        @Override
                        public void onDataChange(DataSnapshot dataSnapshot) {
                            for(DataSnapshot dsp: dataSnapshot.getChildren()){
                                HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                                if (map.get("name").equals(eventName.getText().toString())) {
                                    Log.d("test", "inside social");
                                    ArrayList<String> listInterested = (ArrayList<String>) map.get("interested");
                                    if(listInterested==null){
                                        listInterested = new ArrayList<String>();
                                    }
                                    for (int i = 0; i < listInterested.size(); i++) {
                                        Log.d("test", "inside forloop");
                                        if (listInterested.get(i).equals(uid)) {
                                            listInterested.remove(i);
                                            Log.d("test", "removed from interested");
                                            break;
                                        }
                                    }
                                    if(listInterested==null){
                                        listInterested = new ArrayList<String>();
                                    }
                                    Map<String, Object> newMap = new HashMap<String, Object>();
                                    newMap.put("name", map.get("name"));
                                    newMap.put("author", map.get("author"));
                                    newMap.put("date", map.get("date"));
                                    newMap.put("description", map.get("description"));
                                    newMap.put("path", map.get("path"));
                                    newMap.put("interested", listInterested);
                                    dbRef.child("Socials").child(dsp.getKey()).setValue(newMap);
                                    Log.d("test", "database changed");
                                    break;
                                }

                            }

                        }
                        @Override
                        public void onCancelled(DatabaseError databaseError) {
                            Log.w("TAG", "loadPost:onCancelled", databaseError.toException());
                        }

                    };
                    dbRef.child("Socials").addValueEventListener(postListener);

                }


            }
        });

    }
}
