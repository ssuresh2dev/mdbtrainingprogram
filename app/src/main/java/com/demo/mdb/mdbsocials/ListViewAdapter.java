package com.demo.mdb.mdbsocials;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by reddy on 10/4/2016.
 */

public class ListViewAdapter extends RecyclerView.Adapter<ListViewAdapter.CustomViewHolder> {

    public Context context;
    public ArrayList<EventList.Event> eventArrayList;

    public ListViewAdapter(Context context, ArrayList<EventList.Event> eventArrayList) {
        this.context = context;
        this.eventArrayList = eventArrayList;
    }

    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.list_view, parent, false);
        return new CustomViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {
        EventList.Event event = eventArrayList.get(position);
        //set imageView of holder
        holder.eventTitleTextView.setText(event.name);
        holder.eventUserTextView.setText("Created by " + event.email);
        if (event.interestedPeople != null) {
            holder.eventInterestedTextView.setText(event.interestedPeople.size() + " people interested");
        }

    }

    @Override
    public int getItemCount() {
        if (eventArrayList != null) {
            return eventArrayList.size();
        }
        else {
            return 0;
        }
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {
        ImageView eventImageView;
        TextView eventTitleTextView;
        TextView eventUserTextView;
        TextView eventInterestedTextView;

        public CustomViewHolder(View view) {
            super(view);
            this.eventImageView = (ImageView) view.findViewById(R.id.eventImageView);
            this.eventTitleTextView = (TextView) view.findViewById(R.id.eventTitleTextView);
            this.eventUserTextView = (TextView) view.findViewById(R.id.eventUserTextView);
            this.eventInterestedTextView = (TextView) view.findViewById(R.id.eventInterestedTextView);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    EventList.Event event = eventArrayList.get(getAdapterPosition());
                    Intent intent = new Intent(v.getContext(), DetailActivity.class);
                    intent.putExtra("title", event.name);
                    intent.putExtra("user", event.email);
                    intent.putExtra("description", event.description);
                    intent.putStringArrayListExtra("interestedPeople", event.interestedPeople);
                    v.getContext().startActivity(intent);
                }
            });
        }
    }
}

