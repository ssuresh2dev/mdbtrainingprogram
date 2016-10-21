package mdb.project3.mdbevents;

import android.content.Intent;
import android.graphics.Typeface;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.AppCompatButton;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class RegisterActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView registerTitle;
    private EditText fullNameInput;
    private EditText registerEmailInput;
    private EditText registerPasswordInput;
    private AppCompatButton signUpButton;

    private FirebaseAuth mAuth;
    private FirebaseAuth.AuthStateListener mAuthListener;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        initializeViews();

        mAuth = FirebaseAuth.getInstance();
        mAuthListener = new FirebaseAuth.AuthStateListener() {
            @Override
            public void onAuthStateChanged(@NonNull FirebaseAuth firebaseAuth) {
                FirebaseUser user = firebaseAuth.getCurrentUser();
                if (user != null) {
                    startActivity(new Intent(RegisterActivity.this, FeedActivity.class));
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
        if (id == R.id.sign_up_button) {
            String fullName = fullNameInput.getText().toString();
            String email = registerEmailInput.getText().toString();
            String password = registerPasswordInput.getText().toString();
            // Create a user if all the fields are filled, else display an error message
            if (FirebaseUtils.validate(findViewById(R.id.activity_register), fullName, email, password))
                FirebaseUtils.createUser(getApplicationContext(), mAuth, fullName, email, password);
        }
    }

    // Find each view in the layout and bind it to a class attribute
    private void initializeViews() {
        registerTitle = (TextView) findViewById(R.id.register_title);
        fullNameInput = (EditText) findViewById(R.id.full_name_input);
        registerEmailInput = (EditText) findViewById(R.id.register_email_input);
        registerPasswordInput = (EditText) findViewById(R.id.register_password_input);
        signUpButton = (AppCompatButton) findViewById(R.id.sign_up_button);

        // Set up the fonts used for views which require custom fonts
        Typeface customFont = Typeface.createFromAsset(getAssets(), "fonts/cornerstone.ttf");
        registerTitle.setTypeface(customFont);
        registerPasswordInput.setTypeface(Typeface.DEFAULT);
        signUpButton.setOnClickListener(this);
    }
}