package com.sharie.mdb.pokedex2;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.RadioButton;

import java.lang.reflect.Array;
import java.util.ArrayList;

public class Filter extends AppCompatActivity {
    ArrayList<Pokedex.Pokemon> pokemon, filtered;
    PokemonAdapter pokemonAdapter;
    Pokedex pokedex;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_filter);

        RecyclerView recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new GridLayoutManager(this,2));

        pokedex = new Pokedex();
        pokemon = pokedex.getPokemon();
        filtered = pokedex.getPokemon();

        pokemonAdapter = new PokemonAdapter(getApplicationContext(), filtered);
        recyclerView.setAdapter(pokemonAdapter);

        RadioButton low = (RadioButton) findViewById(R.id.low);
        RadioButton medium = (RadioButton) findViewById(R.id.medium);
        RadioButton high = (RadioButton) findViewById(R.id.high);

    }

    public void onRadioButtonClicked(View view) {
        // Is the button now checked?
        boolean checked = ((RadioButton) view).isChecked();

        // Check which radio button was clicked
        switch (view.getId()) {
            case R.id.low:
                if (checked){
                    filtered.clear();
                    for(int i=0; i<pokemon.size(); i++) {
                        if (Integer.parseInt(pokemon.get(i).hp) < 50)
                            filtered.add(pokemon.get(i));
                    }
                }
                break;
            case R.id.medium:
                if (checked){
                    filtered.clear();
                    for(int i=0; i<pokemon.size(); i++) {
                        if (Integer.parseInt(pokemon.get(i).hp) >= 50 && Integer.parseInt(pokemon.get(i).hp) <= 100)
                            filtered.add(pokemon.get(i));
                    }
                }
                break;
            case R.id.high:
                if (checked) {
                    filtered.clear();
                    for(int i=0; i<pokemon.size(); i++) {
                        if (Integer.parseInt(pokemon.get(i).hp) > 100)
                            filtered.add(pokemon.get(i));
                    }
                }
                break;
        }

        pokemonAdapter.notifyDataSetChanged();

    }

}
