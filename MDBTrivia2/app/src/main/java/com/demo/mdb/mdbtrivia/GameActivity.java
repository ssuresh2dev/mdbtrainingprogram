package com.demo.mdb.mdbtrivia;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.CountDownTimer;
import android.os.StrictMode;
import android.provider.ContactsContract;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;
import android.net.Uri;

import org.w3c.dom.Text;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.StringTokenizer;

public class GameActivity extends AppCompatActivity {

    ImageView imageView;
    Button button1;
    Button button2;
    Button button3;
    Button button4;
    TextView score;
    int points;
    TextView countdown;
    Button endButton;
    final String[] MEMBERS = {"Jessica Cherny", "Mansi Shah", "Alice Wang", "Jessica Ji", "Kevin Jiang", "Jared Gutierrez", "Kristin Ho", "Christine Munar", "Mudit Mittal", "Ali Shelton", "Richard Hu", "Shaan Appel", "Ankur Mahesh", "Edward Liu", "Wilbur Shi", "Young Lin", "Abhinav Koppu", "Abhishek Mangla", "Akkshay Khoslaa", "Ally Koo", "Andy Wang", "Aneesh Jindal", "Anisha Salunkhe", "Aparna Krishnan", "Ashwin Vaidyanathan", "Cody Hsieh", "Connor Killion", "Jeffrey Zhang", "Justin Kim", "Kenneth Steele", "Krishnan Rajiyah", "Lisa Lee", "Peter Schafhalter", "Riley Edmunds", "Rohan Narayan", "Sahil Lamba", "Sameer Suresh", "Sona Jeswani", "Sirjan Kafle", "Tarun Khasnavis", "Virindh Borra", "Billy Lu", "Aayush Tyagi", "Ben Goldberg", "Candice Ye", "Eliot Han", "Emaan Hariri", "Jessica Chen", "Katharine Jiang", "Kedar Thakkar", "Leon Kwak", "Mohit Katyal", "Rochelle Shen", "Sayan Paul", "Sharie Wang", "Shreya Reddy", "Shubham Goenka", "Victor Sun", "Vidya Ravikumar"};
    final Context context = this;
    int correctButton;
    String chosenMember;

    public String getRandomMember(ArrayList<String> doNotChoose)
    {
        int random = (int) (Math.random() * MEMBERS.length);
        while (doNotChoose.contains(MEMBERS[random]))
        {
            random = (int) (Math.random() * MEMBERS.length);
        }
        return MEMBERS[random];
    }


    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);

        imageView = (ImageView) findViewById(R.id.imageView);
        button1 = (Button) findViewById(R.id.button1);
        button2 = (Button) findViewById(R.id.button2);
        button3 = (Button) findViewById(R.id.button3);
        button4 = (Button) findViewById(R.id.button4);
        score = (TextView) findViewById(R.id.scoreTextView);
        countdown= (TextView) findViewById(R.id.countdownTextView);
        endButton = (Button) findViewById(R.id.endButton);
        final Button[] buttons = {button1, button2, button3, button4};
        points = 0;


        long timeLimit = 6000;
        final CountDownTimer countDownTimer = new CountDownTimer(timeLimit, 100) {

            public void onTick(long millisUntilFinished) {
                countdown.setText("Time left: " + millisUntilFinished / 1000);
            }

            public void onFinish() {
                score.setText("Score: "+ points);
                ArrayList<String> chosenMembers = new ArrayList<String>();
                correctButton = (int) (Math.random() * buttons.length);

                chosenMember = MEMBERS[(int) (Math.random() * MEMBERS.length)];
                String chosenMemberDrawable = chosenMember.toLowerCase().replace(" ","_");
                int resourceId = getResources().getIdentifier(chosenMemberDrawable , "drawable", getPackageName());
                imageView.setImageResource(resourceId);
                chosenMembers.add(chosenMember);
                buttons[correctButton].setText(chosenMember);

                int i = 0;
                while (i < buttons.length)
                {
                    if (i != correctButton)
                    {
                        String member = getRandomMember(chosenMembers);
                        buttons[i].setText(member);
                        chosenMembers.add(member);
                    }
                    i++;
                }
                chosenMembers.clear();
                this.start();
            }
        };
        countDownTimer.onFinish();


        button1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (correctButton == 0)
                {
                    points++;
                    countDownTimer.onFinish();
                }
                else
                {
                    Toast toast = Toast.makeText(context, "Sorry, wrong answer!", Toast.LENGTH_SHORT);
                    toast.show();

                    countDownTimer.onFinish();
                }
            }
        });

        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (correctButton == 1)
                {
                    points++;
                    countDownTimer.onFinish();
                }
                else
                {
                    Toast toast = Toast.makeText(context, "Sorry, wrong answer!", Toast.LENGTH_SHORT);
                    toast.show();

                    countDownTimer.onFinish();
                }
            }
        });

        button3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (correctButton == 2)
                {
                    points++;
                    countDownTimer.onFinish();
                }
                else
                {
                    Toast toast = Toast.makeText(context, "Sorry, wrong answer!", Toast.LENGTH_SHORT);
                    toast.show();

                    countDownTimer.onFinish();
                }
            }
        });

        button4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (correctButton == 3)
                {
                    points++;
                    countDownTimer.onFinish();
                }
                else
                {
                    Toast toast = Toast.makeText(context, "Sorry, wrong answer!", Toast.LENGTH_SHORT);
                    toast.show();

                    countDownTimer.onFinish();
                }
            }
        });

        imageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                countDownTimer.cancel();
                Intent intent = new Intent(Intent.ACTION_INSERT);
                intent.setType(ContactsContract.Contacts.CONTENT_TYPE);
                intent.putExtra(ContactsContract.Intents.Insert.NAME, chosenMember);
                startActivity(intent);
            }
        });

        endButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                countDownTimer.cancel();
                AlertDialog.Builder builder1 = new AlertDialog.Builder(context);
                builder1.setMessage("Are you sure you want to exit the game?");
                builder1.setCancelable(true);

                builder1.setPositiveButton(
                        "Yes",
                        new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                finish();
                            }
                        });

                builder1.setNegativeButton(
                        "No",
                        new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                countDownTimer.onFinish();
                                dialog.cancel();
                            }
                        });

                AlertDialog alert = builder1.create();
                alert.show();
            }
        });
    }
}
