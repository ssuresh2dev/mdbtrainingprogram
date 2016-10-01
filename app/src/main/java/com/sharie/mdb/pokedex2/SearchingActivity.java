package com.sharie.mdb.pokedex2;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.EditText;

import java.lang.reflect.Array;
import java.util.ArrayList;

public class SearchingActivity extends AppCompatActivity {
    ArrayList<Pokedex.Pokemon> pokemon, searched;
    PokemonAdapter pokemonAdapter;
    Pokedex pokedex;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_searching);

        RecyclerView recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new GridLayoutManager(this,2));

        pokedex = new Pokedex();
        pokemon = pokedex.getPokemon();
        searched = pokedex.getPokemon();

        pokemonAdapter = new PokemonAdapter(getApplicationContext(), searched);
        recyclerView.setAdapter(pokemonAdapter);

        EditText editText = (EditText) findViewById(R.id.editText);
        editText.setHint("Search by Pokemon name or type");
        editText.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                searched.clear();
                for(int i=0; i<pokemon.size(); i++){
                    if(pokemon.get(i).name.toLowerCase().startsWith(s.toString().toLowerCase()))
                        searched.add(pokemon.get(i));
                    if(pokemon.get(i).species.toLowerCase().startsWith(s.toString().toLowerCase()))
                        searched.add(pokemon.get(i));
                }
                pokemonAdapter.notifyDataSetChanged();
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });


    }

}
