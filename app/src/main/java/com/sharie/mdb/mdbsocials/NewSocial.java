package com.sharie.mdb.mdbsocials;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class NewSocial extends AppCompatActivity {

    private DatabaseReference database;
    private FirebaseAuth mAuth;
    private String my_uid;
    EditText name;
    EditText description;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new_social);

        database = FirebaseDatabase.getInstance().getReference();

        ImageButton photo = (ImageButton) findViewById(R.id.photo);
        name = (EditText) findViewById(R.id.name);
        description = (EditText) findViewById(R.id.description);
        EditText dates = (EditText) findViewById(R.id.dates);
        Button create = (Button) findViewById(R.id.create_event);

        create.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Idea idea = new Idea(name.getText().toString(),description.getText().toString());
                database.child("ideas").setValue(idea);

            }
        });
    }

}
