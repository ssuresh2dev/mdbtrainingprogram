package com.sharie.mdb.pokedex2;

import android.content.Intent;
import android.os.Build;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    boolean is_listView;
    Button layout, filter;
    PokemonAdapter pokemonAdapter;
    RecyclerView recyclerView;

    public void setButtonText(){
        if(is_listView)
            layout.setText("Display as grid");
        else
            layout.setText("Display as list");
    }
    public boolean getTypeView(){
        return is_listView;
    }

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        Pokedex pokedex = new Pokedex();
        ArrayList<Pokedex.Pokemon> pokemon = pokedex.getPokemon();

        recyclerView = (RecyclerView) findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new GridLayoutManager(this,2));

        pokemonAdapter = new PokemonAdapter(getApplicationContext(), pokemon);
        recyclerView.setAdapter(pokemonAdapter);


        layout = (Button) findViewById(R.id.layout);
        filter = (Button) findViewById(R.id.filter);
        is_listView = false;

        layout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                is_listView = !is_listView;
                if(is_listView)
                    recyclerView.setLayoutManager(new LinearLayoutManager(getApplicationContext()));
                else
                    recyclerView.setLayoutManager(new GridLayoutManager(getApplicationContext(),2));
                pokemonAdapter.notifyDataSetChanged();
                setButtonText();
            }
        });
        filter.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent filtering = new Intent(getApplicationContext(),Filter.class);
                startActivity(filtering);
            }
        });
        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent open_search = new Intent(getApplicationContext(),SearchingActivity.class);
                startActivity(open_search);
            }
        });





    }


}
