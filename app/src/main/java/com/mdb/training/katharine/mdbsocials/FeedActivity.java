package com.mdb.training.katharine.mdbsocials;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;

import com.google.firebase.auth.FirebaseAuth;

import java.util.ArrayList;

public class FeedActivity extends AppCompatActivity {

    private FirebaseAuth mAuth;
    private RecyclerView rv;
    public  FeedAdapter adapter;
    private ArrayList<SocialsList.Social> socials;
    private FloatingActionButton logout;
    private FloatingActionButton createSocial;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_feed);

        SocialsList socialsList = new SocialsList();
        socials = socialsList.getSocials();
        logout = (FloatingActionButton) findViewById(R.id.logout);
        createSocial = (FloatingActionButton) findViewById(R.id.createNew);


        rv = (RecyclerView) findViewById(R.id.rv);
        rv.setLayoutManager(new LinearLayoutManager(this));
        adapter = new FeedAdapter(getApplicationContext(), socials);
        rv.setAdapter(adapter);


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
                startActivity(new Intent(FeedActivity.this, CreateNewSocial.class));
            }
        });

    }




}
