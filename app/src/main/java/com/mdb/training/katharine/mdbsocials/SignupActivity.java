package com.mdb.training.katharine.mdbsocials;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class SignupActivity extends AppCompatActivity {

    private EditText name;
    private EditText email;
    private EditText username;
    private EditText password;
    private Button signup;

    private FirebaseAuth mAuth;
    private FirebaseAuth.AuthStateListener mAuthListener;

    private DatabaseReference dbRef;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup);

        name = (EditText) findViewById(R.id.name);
        email = (EditText) findViewById(R.id.email);
        username = (EditText) findViewById(R.id.username);
        password = (EditText) findViewById(R.id.password);
        signup = (Button) findViewById(R.id.signup);

        mAuth = FirebaseAuth.getInstance();
        dbRef = FirebaseDatabase.getInstance().getReference();

        mAuthListener = new FirebaseAuth.AuthStateListener() {
            @Override
            public void onAuthStateChanged(@NonNull FirebaseAuth firebaseAuth) {
                FirebaseUser user = firebaseAuth.getCurrentUser();
                if (user != null) {
                    startActivity(new Intent(SignupActivity.this, FeedActivity.class));
                }
            }
        };

        String em = email.getText().toString();
        String pass = password.getText().toString();
        mAuth.createUserWithEmailAndPassword(em, pass).addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                if (!task.isSuccessful()) {
                    Toast.makeText(SignupActivity.this, "Sign up problem", Toast.LENGTH_LONG).show();
                } else if (task.isSuccessful()) {
                    Toast.makeText(SignupActivity.this, "Sign up success", Toast.LENGTH_LONG).show();
                }
            }
        });

        signup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // signupAuth();
                String n = name.getText().toString();
                String us = username.getText().toString();
                String em = email.getText().toString();
                String pass = password.getText().toString();
                //String userid = mAuth.getCurrentUser().getUid();
                signup(n, us, em, pass);

            }
        });


    }

    @Override
    public void onStart() {
        super.onStart();
        mAuth.addAuthStateListener(mAuthListener);
    }

    @Override
    public void onStop() {
        super.onStop();
        if (mAuthListener != null) {
            mAuth.removeAuthStateListener(mAuthListener);
        }
    }

    private void signup(String name, String username, String email, String pass) {
        User user = new User(name, username, email, pass);
        dbRef.child("users").setValue(user);
    }

    private void signupAuth() {
        String em = email.getText().toString();
        String pass = password.getText().toString();
        mAuth.createUserWithEmailAndPassword(em, pass).addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                if (!task.isSuccessful()) {
                    Toast.makeText(SignupActivity.this, "Sign up problem", Toast.LENGTH_LONG).show();
                } else if (task.isSuccessful()) {
                    Toast.makeText(SignupActivity.this, "Sign up success", Toast.LENGTH_LONG).show();
                }
            }
        });
    }

}
