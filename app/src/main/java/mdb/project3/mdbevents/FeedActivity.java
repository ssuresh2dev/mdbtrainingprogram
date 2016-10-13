package mdb.project3.mdbevents;

import android.content.Intent;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.ArrayList;
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
        ArrayList<Event> eventTestList = new ArrayList<>();

        Event testEvent1 = new Event("Kedar Thakkar", "kedarthakkar@berkeley.edu", "10 others are interested", "fakeurl1.com", "", new ArrayList<String>());
        Event testEvent2 = new Event("Sayan Bigcok", "sayansdope@berkeley.edu", "20 others are intereseted", "probablyporn.com", "", new ArrayList<String>());
        Event testEvent3 = new Event("Eman Swift", "emanfyb@berkeley.edu", "30 others are interested", "sleepsalot.com", "", new ArrayList<String>());

        eventTestList.add(testEvent1);
        eventTestList.add(testEvent2);
        eventTestList.add(testEvent3);
        eventTestList.add(testEvent1);
        eventTestList.add(testEvent2);
        eventTestList.add(testEvent3);
        eventTestList.add(testEvent1);
        eventTestList.add(testEvent2);
        eventTestList.add(testEvent3);
        eventTestList.add(testEvent1);
        eventTestList.add(testEvent2);
        eventTestList.add(testEvent3);
        rootNode = FirebaseDatabase.getInstance().getReference();

        eventAdapter = new EventAdapter(getApplicationContext(), eventTestList);

        // Set the adapter of the recycler view to the event adapter
        recyclerView.setAdapter(eventAdapter);
        createSocialFab = (FloatingActionButton) findViewById(R.id.create_social_fab);
        createSocialFab.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        int id = v.getId();
        switch (id) {
            case R.id.create_social_fab:
                startActivity(new Intent(FeedActivity.this, CreateSocial.class));
                break;
        }
    }
}
