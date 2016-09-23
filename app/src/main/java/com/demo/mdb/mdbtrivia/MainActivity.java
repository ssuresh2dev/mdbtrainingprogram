package com.demo.mdb.mdbtrivia;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;


/**
 * Activity will contain start button to run game. This is a trivia game where the user will have to identify names of MDB members, given a photo.
 * 1 point is earned for each correct answer, answered on time and user can also click on photo of member to create a contact.
 */


public class MainActivity extends AppCompatActivity {

    Button startActivityButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        startActivityButton =  (Button) findViewById(R.id.startActivityButton);         //start button to open up game activity

        startActivityButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getApplicationContext(), GameActivity.class);
                startActivity(intent);
            }
        });


    }
}
