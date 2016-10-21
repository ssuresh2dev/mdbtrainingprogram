package mdb.project3.mdbevents;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.design.widget.Snackbar;
import android.text.TextUtils;
import android.view.View;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.UserProfileChangeRequest;

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

    public static void createUser(final Context context, final FirebaseAuth mAuth, final String fullName,
                                  String email, String password) {
        mAuth.createUserWithEmailAndPassword(email, password).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                if (task.isSuccessful()) {
                    updateUserInfo(mAuth, fullName);
                } else {
                    // If registering fails
                    Toast.makeText(context, R.string.auth_failed, Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    public static boolean validate(View v, String... inputs) {
        boolean valid = true;
        for (String i : inputs) {
            valid = valid && !TextUtils.isEmpty(i);
        }

        if (!valid) {
            Snackbar.make(v,
                    "Required fields are empty",
                    Snackbar.LENGTH_SHORT).show();
        }

        return valid;
    }

    private static void updateUserInfo(FirebaseAuth mAuth, String fullName) {
        FirebaseUser user = mAuth.getCurrentUser();
        UserProfileChangeRequest profileUpdates = new UserProfileChangeRequest.Builder()
                .setDisplayName(fullName).build();
        user.updateProfile(profileUpdates);
    }
}
