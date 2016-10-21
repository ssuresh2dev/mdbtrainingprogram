package mdb.project3.mdbevents;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.design.widget.Snackbar;
import android.text.TextUtils;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;

/**
 * Created by Sayan on 10/19/2016.
 */

public class FirebaseUtils {

    public static void signIn(final Context context, FirebaseAuth mAuth, String email, String password) {
        Toast.makeText(context, "Logging in...", Toast.LENGTH_SHORT).show();
        mAuth.signInWithEmailAndPassword(email, password).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                if (!task.isSuccessful())
                    Toast.makeText(context, R.string.auth_failed, Toast.LENGTH_SHORT).show();
            }
        });
    }
}
