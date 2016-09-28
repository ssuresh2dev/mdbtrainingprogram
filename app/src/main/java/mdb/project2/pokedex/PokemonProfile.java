package mdb.project2.pokedex;

import android.content.Intent;
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
    private Pokedex.Pokemon pokemon;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pokemon_profile);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        Intent intent = getIntent();
        pokemon = pokeList.get(intent.getIntExtra("INDEX", 0));

        Glide.with(this).load(findUrl(pokemon.name))
                .into((ImageView) findViewById(R.id.pokemon_profile_picture));
        getSupportActionBar().setTitle(pokemon.name);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Uri searchUri = Uri.parse(String.format("https://google.com/#q=%s", pokemon.name));
                startActivity(new Intent(Intent.ACTION_VIEW, searchUri));
            }
        });
    }

    private String findUrl(String name) {
        name = Normalizer.normalize(name.toLowerCase(), Normalizer.Form.NFD);
        return String.format("http://img.pokemondb.net/artwork/%s.jpg", name);
    }
}
