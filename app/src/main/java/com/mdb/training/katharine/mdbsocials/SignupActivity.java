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

import java.util.HashMap;
import java.util.Map;

public class SignupActivity extends AppCompatActivity {

    private EditText name;
    private EditText email;
    private EditText password;
    private Button signup;

    private FirebaseAuth mAuth;

    private DatabaseReference mDatabase;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup);

        name = (EditText) findViewById(R.id.name);
        email = (EditText) findViewById(R.id.email);
        password = (EditText) findViewById(R.id.password);
        signup = (Button) findViewById(R.id.signup);

        mAuth = FirebaseAuth.getInstance();
        mDatabase = FirebaseDatabase.getInstance().getReference();

        signup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                signup();
            }
        });
    }

    private void signup() {
        final String n = name.getText().toString();
        final String em = email.getText().toString();
        String pass = password.getText().toString();
        final User user = new User(n, em);
        mAuth.createUserWithEmailAndPassword(em, pass).addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                if (task.isSuccessful()) {
                    String uid = mAuth.getCurrentUser().getUid();
                    Map<String, Object> post = new HashMap<>();
                    post.put("uid", uid);
                    post.put("name", n);
                    post.put("email", em);
                    mDatabase.child("Users").push().setValue(post);
                    startActivity(new Intent(SignupActivity.this, FeedActivity.class));
                } else if (!(task.isSuccessful())) {
                    Toast.makeText(SignupActivity.this, "Sign up problem", Toast.LENGTH_LONG).show();
                }
            }
        });

    }

}
