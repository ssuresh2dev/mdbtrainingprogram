package com.mdb.training.katharine.mdbsocials;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;

import java.util.ArrayList;

public class InterestedActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_interested);

        RecyclerView recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        ArrayList<User> interestedMembers = new ArrayList<User>();
        //Todo: use firebase to get interested users

        InterestedAdapter interestedAdapter = new InterestedAdapter(getApplicationContext(), interestedMembers);

        recyclerView.setAdapter(interestedAdapter);
    }
}
