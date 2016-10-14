package com.demo.mdb.mdbsocials;

import android.content.Intent;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Toast;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.ArrayList;

public class InterestedActivity extends AppCompatActivity {
    ArrayList<String> userArrayList;
    RecyclerView recyclerView;
    InterestedViewAdapter interestedViewAdapter;
    DatabaseReference ref;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_interested);

        Intent intent = getIntent();
        userArrayList = intent.getStringArrayListExtra("users");

        recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        interestedViewAdapter = new InterestedViewAdapter(getApplicationContext(), userArrayList);
        recyclerView.setAdapter(interestedViewAdapter);
    }
}
