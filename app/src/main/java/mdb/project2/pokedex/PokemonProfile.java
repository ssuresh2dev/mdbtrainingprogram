package mdb.project2.pokedex;

import android.content.Intent;
import android.graphics.Color;
import android.graphics.PorterDuff;
import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;

import org.w3c.dom.Text;

import java.text.Normalizer;
import java.util.ArrayList;

public class PokemonProfile extends AppCompatActivity {
    private Pokedex pokedex = new Pokedex();
    private ArrayList<Pokedex.Pokemon> pokeList = pokedex.getPokemon();
    private Pokedex.Pokemon pokemon = null;
    private ImageView pokeProfile;
    private TextView profileName,
            profileNumber,
            profileAttack,
            profileDefense,
            profileHp,
            profileSpecies;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pokemon_profile);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        Intent intent = getIntent();
        String name = intent.getStringExtra("NAME");
        for (Pokedex.Pokemon p : pokeList)
            if (name.equals(p.name))
                pokemon = p;
        bindViews();
        populateViewsWithPokemonData();

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Uri searchUri = Uri.parse(String.format("https://google.com/#q=%s", pokemon.name));
                startActivity(new Intent(Intent.ACTION_VIEW, searchUri));
            }
        });
    }

    private void bindViews() {
        profileHp = (TextView) findViewById(R.id.pokemon_profile_hp);
        pokeProfile = (ImageView) findViewById(R.id.pokemon_profile_picture);
        profileName = (TextView) findViewById(R.id.pokemon_profile_name);
        profileNumber = (TextView) findViewById(R.id.pokemon_profile_number);
        profileAttack = (TextView) findViewById(R.id.pokemon_profile_attack);
        profileDefense = (TextView) findViewById(R.id.pokemon_profile_defense);
        profileSpecies = (TextView) findViewById(R.id.pokemon_profile_species);
    }

    private void populateViewsWithPokemonData() {
        Glide.with(this).load(findUrl(pokemon.name)).into(pokeProfile);
        if (getSupportActionBar() != null)
            getSupportActionBar().setTitle(pokemon.name);
        profileName.setText(pokemon.name);
        profileNumber.setText("#" + pokemon.number);
        profileAttack.setText(pokemon.attack);
        profileDefense.setText(pokemon.defense);
        profileHp.setText(pokemon.hp);
        profileSpecies.setText(pokemon.species);
    }

    private String findUrl(String name) {
        name = Normalizer.normalize(name.toLowerCase(), Normalizer.Form.NFD);
        name = name.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "").replaceAll("\\p{P}", "");
        return String.format("http://img.pokemondb.net/artwork/%s.jpg", name);
    }
}
