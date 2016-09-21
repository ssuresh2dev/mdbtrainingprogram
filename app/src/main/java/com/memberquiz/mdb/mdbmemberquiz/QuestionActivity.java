package com.memberquiz.mdb.mdbmemberquiz;

        import android.content.DialogInterface;
        import android.content.Intent;
        import android.os.CountDownTimer;
        import android.provider.ContactsContract;
        import android.support.v4.content.res.ResourcesCompat;
        import android.support.v7.app.AlertDialog;
        import android.support.v7.app.AppCompatActivity;
        import android.os.Bundle;
        import android.view.View;
        import android.widget.Button;
        import android.widget.ImageButton;
        import android.widget.ImageView;
        import android.widget.TextView;
        import android.widget.Toast;

        import java.util.*;

public class QuestionActivity extends AppCompatActivity {

    private String[] members = {"Jessica Cherny", "Mansi Shah", "Alice Wang", "Jessica Ji",
            "Kevin Jiang", "Jared Gutierrez", "Kristin Ho", "Christine Munar", "Mudit Mittal",
            "Ali Shelton", "Richard Hu", "Shaan Appel", "Ankur Mahesh", "Edward Liu", "Wilbur Shi",
            "Young Lin", "Abhinav Koppu", "Abhishek Mangla",  "Akkshay Khoslaa", "Ally Koo", "Andy Wang",
            "Aneesh Jindal", "Anisha Salunkhe", "Aparna Krishnan", "Ashwin Vaidyanathan",
            "Cody Hsieh", "Connor Killion", "Jeffrey Zhang", "Justin Kim", "Kenneth Steele",
            "Krishnan Rajiyah", "Lisa Lee", "Peter Schafhalter", "Riley Edmunds", "Rohan Narayan",
            "Sahil Lamba", "Sameer Suresh", "Sona Jeswani", "Sirjan Kafle", "Tarun Khasnavis",
            "Virindh Borra", "Billy Lu", "Aayush Tyagi", "Ben Goldberg", "Candice Ye", "Eliot Han",
            "Emaan Hariri", "Jessica Chen", "Katharine Jiang", "Kedar Thakkar", "Leon Kwak",
            "Mohit Katyal", "Rochelle Shen", "Sayan Paul", "Sharie Wang", "Shreya Reddy",
            "Shubham Goenka", "Victor Sun", "Vidya Ravikumar"};

    private final boolean DEBUG = true;

    private int score;
    private CountDownTimer timer;
    private List<String> memberList;

    // Views
    private TextView scoreView, countdownView, endbutton;
    private Button[] buttons = new Button[4];
    private ImageView memberPhoto;
    private int timelimit = 30;
    private int indexOfCorrectMember, indexOfCorrectButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_question);

        buttons[0] = (Button) findViewById(R.id.button1);
        buttons[1] = (Button) findViewById(R.id.button2);
        buttons[2] = (Button) findViewById(R.id.button3);
        buttons[3] = (Button) findViewById(R.id.button4);
        scoreView = (TextView) findViewById(R.id.scoreView);
        countdownView = (TextView) findViewById(R.id.timerView);
        memberPhoto = (ImageView) findViewById(R.id.imageButton);
        endbutton = (TextView) findViewById(R.id.endbutton);

        memberPhoto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Intent.ACTION_INSERT);
                intent.setType(ContactsContract.Contacts.CONTENT_TYPE);
                String name = memberList.get(indexOfCorrectMember);
                intent.putExtra(ContactsContract.Intents.Insert.NAME, name);

                startActivity(intent);
            }
        });

        endbutton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new AlertDialog.Builder(QuestionActivity.this).setTitle("Warning")
                        .setMessage("Do you really want to end the game?")
                        .setIcon(android.R.drawable.ic_dialog_alert)
                        .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int whichButton) {
                                Intent intent = new Intent(getApplicationContext(), MainActivity.class);
                                startActivity(intent);
                            }
                        }).setNegativeButton(android.R.string.no, null).show();
            }

        });

        memberList = Arrays.asList(members);
        Collections.shuffle(memberList);
        score = 0;
        timer = new CountDownTimer(timelimit*1000, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                countdownView.setText("Time remaining: " + String.format("%d", millisUntilFinished / 1000));
            }

            @Override
            public void onFinish() {
                countdownView.setText("Time remaining: " + String.format("%d", 0));
                toast("Out of time!");
            }
        };
        for (int i = 0; i < 4; i++) {
            final int index = i;
            buttons[i].setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if(index == indexOfCorrectButton) {
                        updateScore(score+1);
                        setButtons();
                    }
                    else{
                        toast("ur so dum -1 4 u");
                        updateScore(score-1);
                    }
                }
            });
        }

        setButtons();
    }

    protected void setButtons() {
        updateScore(score);
        List<Integer> indices = new ArrayList<Integer>();
        for (int i = 0; i < 4; ++i) {
            int rand = randomIndex();
            while (indices.contains(rand)) {rand = randomIndex();}
            indices.add(rand);
            buttons[i].setText(memberList.get(rand));
        }
        indexOfCorrectButton = (int)(Math.random() * 4);
        indexOfCorrectMember = indices.get(indexOfCorrectButton);
        setMemberDrawable(indexOfCorrectMember);
        timer.start();
    }

    private void updateScore(int s) {
        score = s;
        scoreView.setText("Score: " + score);
    }

    private int randomIndex() {
        return (int)(Math.random() * memberList.size());
    }

    @Override
    protected void onResume() {
        super.onResume();
        timer.start();;
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        timer.cancel();
    }

    // TODO: 9/18/2016 Add image to imageview on start of game & with every iteration
    // TODO: 9/18/2016 Figure out what happens when a button is pressed
    public void endGame(View v) {
        Intent myIntent = new Intent(getApplicationContext(), MainActivity.class);
        startActivity(myIntent);
    }

    private void toast(String str) {
        Toast.makeText(getApplicationContext(), str, Toast.LENGTH_SHORT).show();
    }

    private void setMemberDrawable(int index) {
        String name = memberList.get(index).toLowerCase().replaceAll("\\s", "");
        if(DEBUG) {toast(name);}
        int photoId = getResources().getIdentifier(name, "drawable", getPackageName());
        memberPhoto.setImageDrawable(ResourcesCompat.getDrawable(getResources(), photoId, null));
    }

    
}
