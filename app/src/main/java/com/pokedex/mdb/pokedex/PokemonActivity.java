package com.pokedex.mdb.pokedex;

import android.app.SearchManager;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.support.design.widget.CollapsingToolbarLayout;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.graphics.Palette;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;

public class PokemonActivity extends AppCompatActivity {

    private String number;
    private String url;
    private TextView name;
    private TextView attack;
    private TextView defense;
    private TextView hp;
    private TextView species;
    private ImageView img;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scrolling);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        name = (TextView)findViewById(R.id.name);
        attack = (TextView)findViewById(R.id.attack);
        defense = (TextView)findViewById(R.id.defense);
        hp = (TextView)findViewById(R.id.hp);
        species = (TextView)findViewById(R.id.species);
        img = (ImageView)findViewById(R.id.imageView);
        Intent intent = getIntent();
        Bundle b = intent.getExtras();

        number = (String)b.get("number");
        while(number.length() < 3){number = "0" + number;}
        ((Toolbar)findViewById(R.id.toolbar)).setTitle("#" + number);
        url = (String)b.get("url");
        Glide.with(getApplicationContext()).load(url).thumbnail(0.5f).crossFade().diskCacheStrategy(DiskCacheStrategy.ALL).into(img);
        name.setText((String)b.get("name"));
        attack.setText("Attack: " + b.get("attack"));
        defense.setText("Defense: " + b.get("defense"));
        hp.setText("HP: " + b.get("hp"));
        species.setText("Species: " + b.get("species"));

/*
        Palette.PaletteAsyncListener paletteListener = new Palette.PaletteAsyncListener() {
            public void onGenerated(Palette palette) {
                // access palette colors here
            }
        };

        Bitmap myBitmap = ((BitmapDrawable)img.getDrawable()).getBitmap()
        if (myBitmap != null && !myBitmap.isRecycled()) {
            Palette.from(myBitmap).generate(paletteListener);
        }
*/
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = getIntent();
                Bundle b = intent.getExtras();
                searchWeb((String)b.get("name"));
            }
        });
    }

    public void searchWeb(String query) {
        Intent intent = new Intent(Intent.ACTION_SEARCH);
        intent.putExtra(SearchManager.QUERY, query);
        if (intent.resolveActivity(getPackageManager()) != null) {
            startActivity(intent);
        }
    }
}
