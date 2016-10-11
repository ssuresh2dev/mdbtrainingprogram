package com.mdb.training.katharine.mdbsocials;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.ArrayList;

public class CreateNewSocial extends AppCompatActivity {

    private EditText name;
    private EditText date;
    private EditText description;
    private Button choosePic;
    private Button createSocial;
    private ArrayList<SocialsList.Social> socialsList;

    private FirebaseAuth mAuth;
    // private FirebaseDatabase mData;
    private DatabaseReference mDatabase;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_new_social);

        name = (EditText) findViewById(R.id.name);
        date = (EditText) findViewById(R.id.date);
        description = (EditText) findViewById(R.id.description);
        choosePic = (Button) findViewById(R.id.pic);
        createSocial = (Button) findViewById(R.id.create);

        Intent intent = getIntent();
        socialsList = (ArrayList< SocialsList.Social>) intent.getExtras().get("socialsList");

        mAuth = FirebaseAuth.getInstance();
        // mData = FirebaseDatabase.getInstance();
        mDatabase = FirebaseDatabase.getInstance().getReference();

        createSocial.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                createSocial();
                startActivity(new Intent(CreateNewSocial.this, FeedActivity.class));
            }
        });

    }

    public void createSocial() {
        String n = name.getText().toString();
        String d = date.getText().toString();
        String descrip = description.getText().toString();
        String author = mAuth.getCurrentUser().getEmail();
        SocialsList.Social social = new SocialsList.Social(n, author, descrip, d);
        mDatabase.child("socials").child("n").setValue(social);
    }
}
