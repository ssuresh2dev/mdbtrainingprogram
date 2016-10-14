package com.demo.mdb.mdbsocials;

import android.content.Intent;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.HashMap;

public class FeedActivity extends AppCompatActivity {
    FloatingActionButton fab;
    RecyclerView recyclerView;
    ListViewAdapter listViewAdapter;
    DatabaseReference ref;
    EventList eventList;
    ArrayList<EventList.Event> eventArrayList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_feed);

        ref = FirebaseDatabase.getInstance().getReference();
        eventList = new EventList();
        eventArrayList = eventList.getArrayList();

        recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
        listViewAdapter = new ListViewAdapter(getApplicationContext(), eventArrayList);
        recyclerView.setAdapter(listViewAdapter);

        ValueEventListener eventListener = new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                eventArrayList = new ArrayList<>();
                for (DataSnapshot eventSnapshot: dataSnapshot.getChildren()) {
                    HashMap<String,Object> map = (HashMap<String,Object>) eventSnapshot.getValue();
                    String email = (String) map.get("user");
                    String name = (String) map.get("name");
                    String pictureURL = (String) map.get("pictureURL");
                    String description = (String) map.get("description");
                    String date = (String) map.get("date");
                    ArrayList<String> interestedPeople = (ArrayList<String>) map.get("interestedPeople");
                    EventList.Event event = new EventList.Event(email, name, pictureURL, description, date, interestedPeople);
                    Log.d("SOS", email + name + pictureURL + description + date + interestedPeople);
                    eventArrayList.add(0, event);
                }
                listViewAdapter.eventArrayList = eventArrayList;
                listViewAdapter.notifyItemInserted(0);
                recyclerView.setAdapter(listViewAdapter);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {}
        };

        ref.child("Events").addValueEventListener(eventListener);

        fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(FeedActivity.this, NewSocial.class);
                startActivity(intent);
            }
        });
    }

    @Override
    public void onBackPressed() {
        Intent a = new Intent(Intent.ACTION_MAIN);
        a.addCategory(Intent.CATEGORY_HOME);
        a.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(a);
    }
}
