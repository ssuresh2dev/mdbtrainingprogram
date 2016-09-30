package mdb.project2.pokedex;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.ButtonBarLayout;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    private Pokedex pokedex = new Pokedex();
    private ArrayList<Pokedex.Pokemon> pokeList = pokedex.getPokemon();
    private PokemonAdapter pokemonAdapter;

    private RecyclerView pokemonListView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        pokemonListView = (RecyclerView) findViewById(R.id.pokemon_list);
        pokemonListView.setLayoutManager(new GridLayoutManager(this, 2));
        pokemonAdapter = new PokemonAdapter(getApplicationContext(), pokeList);
        pokemonListView.setAdapter(pokemonAdapter);
    }

    public void startSearch(View v) {
        startActivity(new Intent(getApplicationContext(), SearchActivity.class));
    }

    public void switchLayoutManager(View v) {
        Button b = (Button) v;
        if (b.getText().toString().equals(getString(R.string.linear))) {
            pokemonListView.setLayoutManager(new LinearLayoutManager(this));
            b.setText(R.string.grid);
        } else {
            pokemonListView.setLayoutManager(new GridLayoutManager(this, 2));
            b.setText(R.string.linear);
        }
    }
}
