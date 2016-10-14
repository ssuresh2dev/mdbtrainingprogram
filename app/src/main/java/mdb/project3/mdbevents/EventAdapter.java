package mdb.project3.mdbevents;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;

import java.util.ArrayList;
import java.util.Locale;

/**
 * Created by Kedar on 10/4/2016.
 */

public class EventAdapter extends RecyclerView.Adapter<EventAdapter.CustomViewHolder> {

    private Context context;
    public ArrayList<Event> eventList;

    public EventAdapter(Context context, ArrayList<Event> events) {
        this.context = context;
        eventList = events;
    }

    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_view, parent, false);
        return new CustomViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final CustomViewHolder holder, int position) {
        Event currEvent = eventList.get(position);

        // Set holders for TextViews to values of the current Event
        holder.eventName.setText(currEvent.getName());
        holder.eventEmail.setText(currEvent.getEmailAddress());
        holder.eventInterested.setText(String.format(Locale.getDefault(), "%d others are interested", currEvent.getNumInterested()));

        Glide.with(context).load(currEvent.imageUrl).into(holder.eventImage);
    }

    @Override
    public int getItemCount() {
        return eventList.size();
    }

    class CustomViewHolder extends RecyclerView.ViewHolder {

        // Create views to be held by the ViewHolder
        ImageView eventImage;
        TextView eventName;
        TextView eventEmail;
        TextView eventInterested;

        public CustomViewHolder(View view) {
            super(view);

            // Set the views within the holder to the corresponding XML attributes
            this.eventImage = (ImageView) (view.findViewById(R.id.social_image));
            this.eventName = (TextView) (view.findViewById(R.id.event_name));
            this.eventEmail = (TextView) (view.findViewById(R.id.event_email));
            this.eventInterested = (TextView) (view.findViewById(R.id.event_interested));

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(v.getContext(), DetailActivity.class);
                    intent.putExtra("DBKEY", FeedActivity.databaseKeys.get(getAdapterPosition()));
                    v.getContext().startActivity(intent);
                }
            });
        }
    }
}

