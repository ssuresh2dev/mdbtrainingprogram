package mdb.project3.mdbevents;

import android.content.Intent;
import android.graphics.Typeface;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.AppCompatButton;
import android.view.View;
import android.widget.TextView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView titleView, emailView, passwordView;
    private AppCompatButton signInButton, registerButton;
    private FirebaseAuth mAuth;
    private FirebaseAuth.AuthStateListener mAuthListener;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initializeViews();
        mAuth = FirebaseAuth.getInstance();
        mAuthListener = new FirebaseAuth.AuthStateListener() {
            @Override
            public void onAuthStateChanged(@NonNull FirebaseAuth firebaseAuth) {
                FirebaseUser user = firebaseAuth.getCurrentUser();
                if (user != null) {
                    // User is signed in
                } else {
                    // User is signed out
                }
            }
        };
    }

    @Override
    protected void onStart() {
        super.onStart();
        mAuth.addAuthStateListener(mAuthListener);
    }

    @Override
    protected void onStop() {
        super.onStop();
        if (mAuthListener != null) {
            mAuth.removeAuthStateListener(mAuthListener);
        }
    }

    private void initializeViews() {
        titleView = (TextView) findViewById(R.id.title_view);
        emailView = (TextView) findViewById(R.id.email_input);
        passwordView = (TextView) findViewById(R.id.password_input);
        signInButton = (AppCompatButton) findViewById(R.id.login_button);
        registerButton = (AppCompatButton) findViewById(R.id.register_button);

        Typeface customFont = Typeface.createFromAsset(getAssets(), "fonts/cornerstone.ttf");
        titleView.setTypeface(customFont);
        passwordView.setTypeface(Typeface.DEFAULT);
        signInButton.setOnClickListener(this);
        registerButton.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        int id = v.getId();
        if (id == R.id.register_button) {
            Intent myIntent = new Intent(getApplicationContext(), RegisterActivity.class);
            startActivity(myIntent);
        }
    }
}
