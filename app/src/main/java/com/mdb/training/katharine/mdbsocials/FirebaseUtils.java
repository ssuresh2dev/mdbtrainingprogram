package com.mdb.training.katharine.mdbsocials;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;

/**
 * Created by KJ on 10/21/16.
 */

public class FirebaseUtils {

    private FirebaseAuth mAuth;

    public FirebaseUtils(FirebaseAuth mAuth) {
        this.mAuth = mAuth;
    }

    public void signIn(final Context context, String email, String pass) {
        if(email.length()==0 || pass.length()==0){
            Toast.makeText(context, "Sign in problem", Toast.LENGTH_LONG).show();
            return;
        }
        mAuth.signInWithEmailAndPassword(email, pass)
                .addOnCompleteListener(new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                if (!task.isSuccessful()) {
                    Toast.makeText(context, "Sign in problem", Toast.LENGTH_LONG).show();
                }
            }
        });
    }

    public void signOut() {
        mAuth.signOut();
    }
}
