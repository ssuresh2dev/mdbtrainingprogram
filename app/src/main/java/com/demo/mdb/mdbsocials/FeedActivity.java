package com.demo.mdb.mdbsocials;

import android.content.Intent;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.Menu;
import android.view.MenuInflater;
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
    FloatingActionButton fab;
    RecyclerView recyclerView;
    ListViewAdapter listViewAdapter;
    DatabaseReference ref;
    EventList eventList;
    ArrayList<EventList.Event> eventArrayList;
    FirebaseAuth mAuth;

    //eventlistener to retrieve firebase data about event
    ValueEventListener eventListener = new ValueEventListener() {
        @Override
        public void onDataChange(DataSnapshot dataSnapshot) {
            eventArrayList = new ArrayList<>();
            for (DataSnapshot eventSnapshot: dataSnapshot.getChildren()) {
                HashMap<String,Object> map = (HashMap<String,Object>) eventSnapshot.getValue();
                String email = (String) map.get("user");
                String name = (String) map.get("name");
                String pushId = (String) map.get("pushId");
                String description = (String) map.get("description");
                String date = (String) map.get("date");
                ArrayList<String> interestedPeople = (ArrayList<String>) map.get("interestedPeople");
                EventList.Event event = new EventList.Event(email, name, pushId, description, date, interestedPeople);
                eventArrayList.add(0, event);
            }
            listViewAdapter.eventArrayList = eventArrayList;
            listViewAdapter.notifyItemInserted(0);
            listViewAdapter.notifyDataSetChanged();
            recyclerView.setAdapter(listViewAdapter);
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {}
    };

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
    public void onResume(){
        super.onResume();
        listViewAdapter.notifyDataSetChanged();
        listViewAdapter.eventArrayList = eventArrayList;
        recyclerView.setAdapter(listViewAdapter);
    }

    @Override
    public void onBackPressed() {
        Intent a = new Intent(Intent.ACTION_MAIN);
        a.addCategory(Intent.CATEGORY_HOME);
        a.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(a);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.logout, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        mAuth = FirebaseAuth.getInstance();

        switch (item.getItemId()) {
            case R.id.action_logout:
                mAuth.getInstance().signOut();
                Intent intent = new Intent(FeedActivity.this, MainActivity.class);
                startActivity(intent);
                return true;

            default:
                return super.onOptionsItemSelected(item);

        }
    }
}
