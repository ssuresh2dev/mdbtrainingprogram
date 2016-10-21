package com.mdb.training.katharine.mdbsocials;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.HashMap;

public class FeedActivity extends AppCompatActivity {

    private FirebaseAuth mAuth;
    private RecyclerView rv;
    public  FeedAdapter adapter;
    public  ArrayList<SocialsList.Social> socials = new ArrayList<SocialsList.Social>();
    private FloatingActionButton createSocial;
    private DatabaseReference mDatabase;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_feed);

        SocialsList socialsList = new SocialsList();
        socials = socialsList.getSocials();
        createSocial = (FloatingActionButton) findViewById(R.id.createNew);
        mDatabase = FirebaseDatabase.getInstance().getReference();

        rv = (RecyclerView) findViewById(R.id.rv);
        rv.setLayoutManager(new LinearLayoutManager(this));
        adapter = new FeedAdapter(getApplicationContext(), socials);
        rv.setAdapter(adapter);

        ValueEventListener postListener = new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                socials = new ArrayList<SocialsList.Social>();

                for(DataSnapshot dsp: dataSnapshot.getChildren()){
                    HashMap<String, Object> map = (HashMap<String, Object>) dsp.getValue();
                    String name = (String) map.get("name");
                    String author = (String) map.get("author");
                    String description = (String) map.get("description");
                    String date = (String) map.get("date");
                    String firebasePath = (String) map.get("path");
                    ArrayList<String> interested = (ArrayList<String>) map.get("interested");
                    if(interested == null){
                        interested = new ArrayList<String>();
                    }
                    SocialsList.Social social = new SocialsList.Social(name, author, description, date, firebasePath);
                    social.setInterested(interested);
                    socials.add(social);
                }
                adapter.socials = socials;
                adapter.notifyDataSetChanged();
                rv.setAdapter(adapter);
            }


            @Override
            public void onCancelled(DatabaseError databaseError) {
                Log.w("TAG", "loadPost:onCancelled", databaseError.toException());
            }

        };
        mDatabase.child("Socials").addValueEventListener(postListener);


        mAuth = FirebaseAuth.getInstance();


        createSocial.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(FeedActivity.this, CreateNewSocial.class);
                intent.putExtra("numSocials", socials.size());
                startActivity(intent);
            }
        });

    }

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
