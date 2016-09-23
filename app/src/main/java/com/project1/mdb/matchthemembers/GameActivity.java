package com.project1.mdb.matchthemembers;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.CountDownTimer;
import android.provider.ContactsContract;
import android.support.v4.content.res.ResourcesCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.*;

public class GameActivity extends AppCompatActivity {

    private String[] members = {"Jessica Cherny", "Mansi Shah", "Alice Wang", "Jessica Ji",
            "Kevin Jiang", "Jared Gutierrez", "Kristin Ho", "Christine Munar", "Mudit Mittal",
            "Ali Shelton", "Richard Hu", "Shaan Appel", "Ankur Mahesh", "Edward Liu", "Wilbur Shi",
            "Young Lin", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Ally Koo", "Andy Wang",
            "Aneesh Jindal", "Anisha Salunkhe", "Aparna Krishnan", "Ashwin Vaidyanathan",
            "Cody Hsieh", "Connor Killion", "Jeffrey Zhang", "Justin Kim", "Kenneth Steele",
            "Krishnan Rajiyah", "Lisa Lee", "Peter Schafhalter", "Riley Edmunds", "Rohan Narayan",
            "Sahil Lamba", "Sameer Suresh", "Sona Jeswani", "Sirjan Kafle", "Tarun Khasnavis",
            "Virindh Borra", "Billy Lu", "Aayush Tyagi", "Ben Goldberg", "Candice Ye", "Eliot Han",
            "Emaan Hariri", "Jessica Chen", "Katharine Jiang", "Kedar Thakkar", "Leon Kwak",
            "Mohit Katyal", "Rochelle Shen", "Sayan Paul", "Sharie Wang", "Shreya Reddy",
            "Shubham Goenka", "Victor Sun", "Vidya Ravikumar"};

    private int score, currentMember;
    private CountDownTimer timer;
    private List<String> memberList;

    private TextView scoreView, countdownView;
    private Button[] choices;
    private ImageView memberPhoto;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);

        choices = new Button[]{
                (Button) findViewById(R.id.top_left_name),
                (Button) findViewById(R.id.top_right_name),
                (Button) findViewById(R.id.bottom_left_name),
                (Button) findViewById(R.id.bottom_right_name)
        };
        scoreView = (TextView) findViewById(R.id.score);
        countdownView = (TextView) findViewById(R.id.countdown);
        memberPhoto = (ImageView) findViewById(R.id.member_photo);

        memberList = Arrays.asList(members);
        Collections.shuffle(memberList);
        score = 0;
        currentMember = 0;
        timer = new CountDownTimer(5000, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                countdownView.setText(String.format("%d", millisUntilFinished / 1000));
            }

            @Override
            public void onFinish() {
                countdownView.setText(String.valueOf(0));
                updateQuizItems(false);
            }
        };
    }

    @Override
    protected void onResume() {
        super.onResume();
        refreshViews();
    }

    @Override
    protected void onDestroy() {
        timer.cancel();
        super.onDestroy();
    }

    @Override
    protected void onPause() {
        timer.cancel();
        super.onPause();
    }

    //region Click handlers
    public void endGame(View v) {
        timer.cancel();
        new AlertDialog.Builder(this)
                .setTitle("End Game")
                .setMessage("Are you sure you want to end the game?")
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        Intent myIntent = new Intent(getApplicationContext(), StartScreen.class);
                        startActivity(myIntent);
                    }
                })
                .setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        timer.start();
                    }
                })
                .show();
    }

    public void checkChoice(View v) {
        timer.cancel();
        Button clicked = (Button) v;
        boolean isCorrect = clicked.getText().toString().equals(memberList.get(currentMember));
        updateQuizItems(isCorrect);
    }

    public void goToContacts(View v) {
        Intent intent = new Intent(Intent.ACTION_INSERT);
        intent.setType(ContactsContract.RawContacts.CONTENT_TYPE);
        intent.putExtra(ContactsContract.Intents.Insert.NAME, memberList.get(currentMember));
        startActivity(intent);
    }
    //endregion

    //region Helper methods
    private void updateQuizItems(boolean isCorrect) {
        if (isCorrect)
            score++;
        else
            incorrectChoice();
        currentMember++;
        if (currentMember >= memberList.size()) {
            timer.cancel();
            Toast.makeText(getApplicationContext(), "Your score was: " + score, Toast.LENGTH_LONG).show();
            Intent myIntent = new Intent(getApplicationContext(), StartScreen.class);
            startActivity(myIntent);
        } else {
            refreshViews();
        }
    }

    private void refreshViews() {
        scoreView.setText(String.valueOf(score));
        setMemberDrawable();
        setChoices();
        timer.start();
    }

    private void setMemberDrawable() {
        String name = memberList.get(currentMember).toLowerCase().replaceAll("\\s", "");
        int photoId = getResources().getIdentifier(name, "drawable", getPackageName());
        memberPhoto.setImageDrawable(ResourcesCompat.getDrawable(getResources(), photoId, null));
    }

    private void setChoices() {
        List<String> membersCopy = new ArrayList<>();
        for (String member : memberList)
            membersCopy.add(member);
        membersCopy.remove(memberList.get(currentMember));
        Collections.shuffle(membersCopy);
        membersCopy = membersCopy.subList(0, 3);
        membersCopy.add((int) (Math.random() * 4), memberList.get(currentMember));
        for (int i = 0; i < membersCopy.size(); i++)
            choices[i].setText(membersCopy.get(i));
    }

    private void incorrectChoice() {
        Toast.makeText(getApplicationContext(), "Wrong choice!", Toast.LENGTH_SHORT).show();
    }
    //endregion
}
