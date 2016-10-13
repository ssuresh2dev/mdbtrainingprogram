package com.mdb.training.katharine.mdbsocials;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TextView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class DetailsActivity extends AppCompatActivity {

    private TextView eventName, date, author, description, numInterested;
    private CheckBox interested;

    private Toolbar toolbar;
    FloatingActionButton fab;

    private DatabaseReference dbRef;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details);
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        dbRef = FirebaseDatabase.getInstance().getReference();

        eventName = (TextView) findViewById(R.id.eventName);
        eventName.setText(getIntent().getExtras().getString("title"));

        date = (TextView) findViewById(R.id.textView);
        date.setText(getIntent().getExtras().getString("date"));

        author = (TextView) findViewById(R.id.textView2);
        author.setText(getIntent().getExtras().getString("author"));

        description = (TextView) findViewById(R.id.textView3);
        description.setText(getIntent().getExtras().getString("description"));

        numInterested = (TextView) findViewById(R.id.textView4);
        numInterested.setText("Interested: " + getIntent().getExtras().getInt("interested"));

        numInterested.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getApplicationContext(),InterestedActivity.class);
                intent.putExtra("interestedName", getIntent().getStringArrayListExtra("interestedName"));
                intent.putExtra("interestedEmail", getIntent().getStringArrayListExtra("interestedEmail"));
                startActivity(intent);
            }
        });
        interested = (CheckBox) findViewById(R.id.interested);

        interested.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    ValueEventListener postListener = new ValueEventListener() {
                        @Override
                        public void onDataChange(DataSnapshot dataSnapshot) {
                            for(DataSnapshot dsp: dataSnapshot.getChildren()){
                                HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                                ArrayList<String> interested = (ArrayList<String>) map.get("interested");
                                if(interested == null){
                                    interested = new ArrayList<String>();
                                }

                                String uid = FirebaseAuth.getInstance().getCurrentUser().getUid();
                                if (map.get("name").equals(eventName.getText().toString()) && !interested.contains(uid)) {
                                    interested.add(uid);
                                    Map<String, Object> newMap = new HashMap<String, Object>();
                                    newMap.put("name", map.get("name"));
                                    newMap.put("author", map.get("author"));
                                    newMap.put("date", map.get("date"));
                                    newMap.put("description", map.get("description"));
                                    newMap.put("interested", interested);
                                    dbRef.child("Socials").child(dsp.getKey()).setValue(newMap);
                                    Log.d("test","event listener works"); //listener still not quite working

                                }

                            }

                        }
                        @Override
                        public void onCancelled(DatabaseError databaseError) {
                            Log.w("TAG", "loadPost:onCancelled", databaseError.toException());
                        }

                    };
                    dbRef.child("Socials").addValueEventListener(postListener);
                } else {
                    ValueEventListener postListener = new ValueEventListener() {
                        @Override
                        public void onDataChange(DataSnapshot dataSnapshot) {
                            for(DataSnapshot dsp: dataSnapshot.getChildren()){
                                HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                                if (map.get("name").equals(eventName)) {
                                    ArrayList<String> interested = (ArrayList<String>) map.get("interested");
                                    for (int i = 0; i < interested.size(); i += 1) {
                                        if (interested.get(i).equals(map.get("uid"))) {
                                            interested.remove(i);
                                        }
                                    }
                                    Map<String, Object> newMap = new HashMap<String, Object>();
                                    newMap.put("name", map.get("name"));
                                    newMap.put("author", map.get("author"));
                                    newMap.put("date", map.get("date"));
                                    newMap.put("description", map.get("description"));
                                    newMap.put("interested", interested);
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


            }
        });










    }
}
