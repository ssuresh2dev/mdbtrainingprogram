package com.sharie.mdb.mdbsocials;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.CollapsingToolbarLayout;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.MutableData;
import com.google.firebase.database.Transaction;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;

public class Details extends AppCompatActivity {

    private String title, description, email, key, date;
    private int stars;
    private DatabaseReference database;
    private DatabaseReference starsRef;
    private FirebaseAuth mAuth;
    private FloatingActionButton star;
    private TextView content;
    private String url;
    private ImageView image;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);




        title = getIntent().getExtras().getString("title");
        description = getIntent().getExtras().getString("descript");
        email = getIntent().getExtras().getString("email");
        key = getIntent().getExtras().getString("key");
        stars = getIntent().getExtras().getInt("stars");
        date = getIntent().getExtras().getString("date");
        url = getIntent().getExtras().getString("url");

        image = (ImageView) findViewById(R.id.imageView2);
        Glide.with(getApplicationContext()).load(url).into(image);

        content = (TextView) findViewById(R.id.content);
        setMessage();

        starsRef = FirebaseDatabase.getInstance().getReference("ideas/"+key+"/stars");
        database = FirebaseDatabase.getInstance().getReference();
        mAuth = FirebaseAuth.getInstance();

        CollapsingToolbarLayout tool = (CollapsingToolbarLayout) findViewById(R.id.toolbar_layout);
        tool.setTitle(title);

        star = (FloatingActionButton) findViewById(R.id.star);
        star.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //BUG: DOES NOT REBIND VIEW HOLDER NOR DETAIL SCREEN IF YOU CLICK ON DETAIL AGAIN UNTIL RE-SIGN IN.
                FirebaseUser cur = mAuth.getCurrentUser();

                if (cur != null)
                    database.child("interested").child(key).child(cur.getUid()).setValue(cur.getEmail());
                    starsRef.runTransaction(new Transaction.Handler() {
                        @Override
                        public Transaction.Result doTransaction(MutableData mutableData) {
                            Integer cur = mutableData.getValue(Integer.class);
                            mutableData.setValue(cur+1);
                            return Transaction.success(mutableData);
                        }
                        @Override
                        public void onComplete(DatabaseError databaseError, boolean b, DataSnapshot dataSnapshot) {}
                    });
                    starsRef.addValueEventListener(new ValueEventListener() {
                        @Override
                        public void onDataChange(DataSnapshot dataSnapshot) {
                            stars = dataSnapshot.getValue(Integer.class);
                            setMessage();
                        }

                        @Override
                        public void onCancelled(DatabaseError databaseError) {

                        }
                    });
                    star.setImageResource(R.drawable.star);
            }
        });
        FloatingActionButton info = (FloatingActionButton) findViewById(R.id.interested);
        info.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent show_info = new Intent(getApplicationContext(),Interested.class);
                show_info.putExtra("key", key);
                startActivity(show_info);
            }
        });
    }

    public void setMessage(){
        String ans = "";
        ans += date + "\n";
        ans += description + "\n\n";
        ans += "Submitted by " + email+ "\n";
        if(stars == 1)
            ans += stars + " person is interested.";
        else
            ans += stars + " people are interested.";
        content.setText(ans);
    }
}
