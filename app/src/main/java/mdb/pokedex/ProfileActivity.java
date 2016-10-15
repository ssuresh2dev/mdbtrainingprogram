package mdb.pokedex;

import android.app.SearchManager;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;

public class ProfileActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent search = new Intent(Intent.ACTION_WEB_SEARCH);
                search.putExtra(SearchManager.QUERY, (new Pokedex()).getPokemon().get(getIntent().getExtras().getInt("POKEMON")).name);
                startActivity(search);
            }
        });

        populateView((getIntent().getExtras().getInt("POKEMON")));
    }

    public void populateView(int adapterPosition){

        Pokedex pokedex = new Pokedex();
        Pokedex.Pokemon currentPokemon = pokedex.getPokemon().get(adapterPosition);

        TextView name = (TextView) (findViewById(R.id.textView3));
        name.setText(currentPokemon.name);

        TextView number = (TextView) (findViewById(R.id.textView));
        number.setText("#" + currentPokemon.number);

        TextView attack = (TextView) (findViewById(R.id.textView6));
        attack.setText("Attack: " + currentPokemon.attack);

        TextView defense = (TextView) (findViewById(R.id.textView2));
        defense.setText("Defense: " + currentPokemon.defense);

        TextView hp = (TextView) (findViewById(R.id.textView7));
        hp.setText("HP: " + currentPokemon.hp);

        TextView species = (TextView) (findViewById(R.id.textView5));
        species.setText("Species: " + currentPokemon.species);

        String pokeName = currentPokemon.name.toLowerCase();
        String url = "http://img.pokemondb.net/artwork/" + pokeName + ".jpg";

        ImageView imageView = (ImageView) findViewById(R.id.poke_image);

        Glide.with(this)
                .load(url)
                .into(imageView);
    }
}
