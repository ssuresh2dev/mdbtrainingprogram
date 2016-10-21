package com.mdb.training.katharine.mdbsocials;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by victorsun on 10/5/16.
 */

public class InterestedAdapter extends RecyclerView.Adapter<InterestedAdapter.CustomViewHolder>  {

    private Context context;
    public ArrayList<String> names;
    public ArrayList<String> emails;

    public InterestedAdapter(Context context, @NonNull ArrayList<String> interestedName,
                             @NonNull ArrayList<String> interestedEmail) {
        this.context = context;
        names = interestedName;
        emails = interestedEmail;
    }

    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_view_members,
                parent, false);
        return new CustomViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {
        holder.name.setText(names.get(position));
        holder.email.setText(emails.get(position));
    }

    public int getItemCount() {
        return names.size();
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {
        TextView name, email;
        public CustomViewHolder(View view) {
            super(view);
            this.name = (TextView) view.findViewById(R.id.name);
            this.email = (TextView) view.findViewById(R.id.email);
        }
    }
}
