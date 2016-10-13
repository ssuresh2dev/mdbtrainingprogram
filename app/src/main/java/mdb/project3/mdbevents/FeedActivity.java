package mdb.project3.mdbevents;

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
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

public class FeedActivity extends AppCompatActivity implements View.OnClickListener {

    EventAdapter eventAdapter;
    DatabaseReference rootNode;

    FloatingActionButton createSocialFab;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_feed);

        // Create a variable for the recycler view and set its layout manager to be linear
        RecyclerView recyclerView = (RecyclerView) findViewById(R.id.recycler_view);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        // Create a list of test events and bind the event adapter to this list
        final ArrayList<Event> eventList = new ArrayList<>();
        eventAdapter = new EventAdapter(getApplicationContext(), eventList);

        Toast.makeText(getApplicationContext(), "Loading events...", Toast.LENGTH_SHORT).show();
        
        rootNode = FirebaseDatabase.getInstance().getReference();
        DatabaseReference eventNode = rootNode.child("Events");
        eventNode.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                Log.e("Count " ,""+snapshot.getChildrenCount());
                for (DataSnapshot postSnapshot: snapshot.getChildren()) {
                    Event event = postSnapshot.getValue(Event.class);
                    eventList.add(event);
                }

                Collections.sort(eventList);
                eventAdapter.eventList = eventList;
                eventAdapter.notifyDataSetChanged();
            }
            @Override
            public void onCancelled(DatabaseError firebaseError) {
                Log.e("The read failed: " ,firebaseError.getMessage());
            }
        });

        // Set the adapter of the recycler view to the event adapter
        recyclerView.setAdapter(eventAdapter);
        createSocialFab = (FloatingActionButton) findViewById(R.id.create_social_fab);
        createSocialFab.setOnClickListener(this);
    }

    public void startNewSocialActivity() {
        Intent intent = new Intent(getApplicationContext(), CreateSocial.class);
        startActivity(intent);
    }

    @Override
    public void onClick(View v) {
        int id = v.getId();
        switch (id) {
            case R.id.create_social_fab:
	    	startNewSocialActivity();
                break;
        }
    }
}
