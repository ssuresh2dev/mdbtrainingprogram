package com.mdb.training.katharine.mdbsocials;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;

public class FeedActivity extends AppCompatActivity {

    private FirebaseAuth mAuth;
    private RecyclerView rv;
    public  FeedAdapter adapter;
    public  ArrayList<SocialsList.Social> socials = new ArrayList<SocialsList.Social>();
    private FloatingActionButton logout;
    private FloatingActionButton createSocial;
    private DatabaseReference mDatabase;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_feed);

        SocialsList socialsList = new SocialsList();
        socials = socialsList.getSocials();
        logout = (FloatingActionButton) findViewById(R.id.logout);
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
                    System.out.println(dsp.getValue());

                    //socials.add(dsp.getValue(SocialsList.Social.class));
                    //issue is that were getting string values instead of social classes, also how do i new socials, using set value in create new social just replaces values
                }
                adapter.notifyDataSetChanged();
            }


            @Override
            public void onCancelled(DatabaseError databaseError) {
                Log.w("TAG", "loadPost:onCancelled", databaseError.toException());
            }

        };
        mDatabase.child("socials").addValueEventListener(postListener);



            mAuth = FirebaseAuth.getInstance();
        logout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mAuth.signOut();
                startActivity(new Intent(FeedActivity.this, MainActivity.class));
            }
        });

        createSocial.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(FeedActivity.this, CreateNewSocial.class);
                startActivity(intent);
            }
        });

    }




}
