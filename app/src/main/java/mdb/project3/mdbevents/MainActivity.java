package mdb.project3.mdbevents;

import android.content.Intent;
import android.graphics.Typeface;
import android.support.annotation.NonNull;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.AppCompatButton;
import android.text.TextUtils;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
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
                    startActivity(new Intent(MainActivity.this, FeedActivity.class));
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

    @Override
    public void onClick(View v) {
        int id = v.getId();
        switch (id) {
            case R.id.register_button:
                Intent myIntent = new Intent(MainActivity.this, RegisterActivity.class);
                myIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(myIntent);
                break;
            case R.id.login_button:
                signIn(emailView.getText().toString(), passwordView.getText().toString());
                break;
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

    private void signIn(String email, String password) {
        if (!validate(email, password))
            return;
        Toast.makeText(getApplicationContext(), "Logging in...", Toast.LENGTH_SHORT).show();
        mAuth.signInWithEmailAndPassword(email, password).addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                if (!task.isSuccessful())
                    Toast.makeText(getApplicationContext(), R.string.auth_failed, Toast.LENGTH_SHORT).show();
            }
        });
    }

    private boolean validate(String email, String password) {
        boolean valid = !(TextUtils.isEmpty(email) ||
                TextUtils.isEmpty(password));
        if (!valid) {
            Snackbar.make(findViewById(R.id.activity_register),
                    "Required fields are empty",
                    Snackbar.LENGTH_SHORT).show();
        }
        return valid;
    }
}
