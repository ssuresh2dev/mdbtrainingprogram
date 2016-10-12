package com.mdb.training.katharine.mdbsocials;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;

import java.util.ArrayList;

public class InterestedActivity extends AppCompatActivity {
    private ArrayList<String> interestedName;
    private ArrayList<String> interestedEmail;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_interested);

        RecyclerView recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));


        interestedName = getIntent().getStringArrayListExtra("interestedName");
        interestedEmail = getIntent().getStringArrayListExtra("interestedEmail");

        InterestedAdapter interestedAdapter = new InterestedAdapter(getApplicationContext(), interestedName, interestedEmail);

        recyclerView.setAdapter(interestedAdapter);



    }
}
