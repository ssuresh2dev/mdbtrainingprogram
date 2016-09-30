package mdb.project2.pokedex;

import android.content.Intent;
import android.support.v4.content.ContextCompat;
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

    private boolean[] buttonToggle = new boolean[]{true, true, true};

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

    public void toggleLow(View v) {
        Button b = (Button) v;
        if (buttonToggle[0])
            b.setBackgroundColor(ContextCompat.getColor(getApplicationContext(), R.color.default_button));
        else
            b.setBackgroundColor(ContextCompat.getColor(getApplicationContext(), R.color.low));
        buttonToggle[0] = !buttonToggle[0];
        filterPokemonList();
    }

    public void toggleMedium(View v) {
        Button b = (Button) v;
        if (buttonToggle[1])
            b.setBackgroundColor(ContextCompat.getColor(getApplicationContext(), R.color.default_button));
        else
            b.setBackgroundColor(ContextCompat.getColor(getApplicationContext(), R.color.medium));
        buttonToggle[1] = !buttonToggle[1];
        filterPokemonList();
    }

    public void toggleHigh(View v) {
        Button b = (Button) v;
        if (buttonToggle[2])
            b.setBackgroundColor(ContextCompat.getColor(getApplicationContext(), R.color.default_button));
        else
            b.setBackgroundColor(ContextCompat.getColor(getApplicationContext(), R.color.high));
        buttonToggle[2] = !buttonToggle[2];
        filterPokemonList();
    }

    private boolean isLow(int x) {
        return 0 <= x && x < 50;
    }

    private boolean isMedium(int x) {
        return 50 <= x && x <= 100;
    }

    private boolean isHigh(int x) {
        return x > 100;
    }

    private boolean filter(int x) {
        return buttonToggle[0] && isLow(x) ||
                buttonToggle[1] && isMedium(x) ||
                buttonToggle[2] && isHigh(x);
    }

    private void filterPokemonList() {
        ArrayList<Pokedex.Pokemon> pokeListCopy = new ArrayList<>();
        for (Pokedex.Pokemon p : pokeList) {
            if (filter(Integer.parseInt(p.hp)))
                pokeListCopy.add(p);
        }
        pokemonAdapter.setList(pokeListCopy);
        pokemonAdapter.notifyDataSetChanged();
    }
}
