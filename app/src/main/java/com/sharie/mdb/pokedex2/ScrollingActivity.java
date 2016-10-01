package com.sharie.mdb.pokedex2;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.CollapsingToolbarLayout;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;

import org.w3c.dom.Text;

import java.util.ArrayList;

public class ScrollingActivity extends AppCompatActivity {
    ArrayList<Pokedex.Pokemon> pokemons;
    int num;
    String url;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scrolling);

        Pokedex pokedex = new Pokedex();
        pokemons = pokedex.getPokemon();
        Bundle extras = getIntent().getExtras();
        String name = extras.getString("name");
        for(Pokedex.Pokemon poke : pokemons){
            if(poke.name.equals(name)){
                num = pokemons.indexOf(poke);
            }
        }

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        TextView textView = (TextView) findViewById(R.id.info);
        textView.setText(getMessage());

        CollapsingToolbarLayout ctl = (CollapsingToolbarLayout) findViewById(R.id.toolbar_layout);
        ctl.setTitle(pokemons.get(num).name);




        ImageView picture = (ImageView) findViewById(R.id.imageViewCard);
//        if(pokemons.get(num).name.equals("Farfetch'd"))
//            url = "http://img.pokemondb.net/artwork/farfetchd.jpg";
//        else if (pokemons.get(num).name.equals("Flabébé"))
//            url = "http://img.pokemondb.net/artwork/flabebe.jpg";
//        else
        url = "http://img.pokemondb.net/artwork/" + pokemons.get(num).name.toLowerCase() + ".jpg";
        Glide.with(getApplicationContext()).load(url).into(picture);



        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String name = pokemons.get(num).name.toLowerCase();
                Uri uri = Uri.parse("http://www.google.com/#q="+name);
                Intent intent = new Intent(Intent.ACTION_VIEW, uri);
                startActivity(intent);
            }
        });
    }
    public String getMessage(){
        String ans = "";
        ans += "Pokemon #"+pokemons.get(num).number + "\n";
        ans += "HP: "+pokemons.get(num).hp + "\n";
        ans += "Defense: "+pokemons.get(num).defense + "\n";
        ans += "Attack: "+pokemons.get(num).attack + "\n";
        ans += "Species: "+pokemons.get(num).species + "\n";
        return ans;
    }
}
