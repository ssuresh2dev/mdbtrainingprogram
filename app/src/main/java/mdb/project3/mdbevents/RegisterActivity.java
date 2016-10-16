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
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.UserProfileChangeRequest;

public class RegisterActivity extends AppCompatActivity implements View.OnClickListener {
    private TextView registerTitle;
    private EditText fullNameInput,
            registerEmailInput,
            registerPasswordInput;
    private AppCompatButton signUpButton;

    private FirebaseAuth mAuth;
    private FirebaseAuth.AuthStateListener mAuthListener;
    private FirebaseUser user;

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
                    // User is signed in
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
            createAccount(fullNameInput.getText().toString(),
                    registerEmailInput.getText().toString(),
                    registerPasswordInput.getText().toString());
        }
    }

    private void initializeViews() {
        registerTitle = (TextView) findViewById(R.id.register_title);
        fullNameInput = (EditText) findViewById(R.id.full_name_input);
        registerEmailInput = (EditText) findViewById(R.id.register_email_input);
        registerPasswordInput = (EditText) findViewById(R.id.register_password_input);
        signUpButton = (AppCompatButton) findViewById(R.id.sign_up_button);

        Typeface customFont = Typeface.createFromAsset(getAssets(), "fonts/cornerstone.ttf");
        registerTitle.setTypeface(customFont);
        registerPasswordInput.setTypeface(Typeface.DEFAULT);
        signUpButton.setOnClickListener(this);
    }


    private void createAccount(final String fullName, String email, String password) {
        if (!validate(fullName, email, password))
            return;
        mAuth.createUserWithEmailAndPassword(email, password).addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                // If registering fails
                if (task.isSuccessful()) {
                    updateUserInfo(fullName);
                } else {
                    Toast.makeText(getApplicationContext(), R.string.auth_failed, Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    private boolean validate(String fullName, String email, String password) {
        boolean valid = !(TextUtils.isEmpty(fullName) ||
                TextUtils.isEmpty(email) ||
                TextUtils.isEmpty(password));
        if (!valid) {
            Snackbar.make(findViewById(R.id.activity_register),
                    "Required fields are empty",
                    Snackbar.LENGTH_SHORT).show();
        }
        return valid;
    }

    private void updateUserInfo(String fullName) {
        user = mAuth.getCurrentUser();
        UserProfileChangeRequest profileUpdates = new UserProfileChangeRequest.Builder()
                .setDisplayName(fullName).build();
        user.updateProfile(profileUpdates);
    }
}