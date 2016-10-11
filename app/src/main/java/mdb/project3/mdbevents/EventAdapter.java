package mdb.project3.mdbevents;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by Kedar on 10/4/2016.
 */

public class EventAdapter extends RecyclerView.Adapter<EventAdapter.CustomViewHolder> {

    private Context context;
    public ArrayList<Event> eventList;

    public EventAdapter(Context context, ArrayList<Event> events){
        this.context = context;
        eventList = events;
    }

    @Override
    public CustomViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {

//        This "inflates" the views, using the layout R.layout.row_view
        //if(MainActivity.listView){
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_view, parent, false);
        //}
        //else
        //  view = LayoutInflater.from(parent.getContext()).inflate(R.layout.grid_view, parent, false);
        return new CustomViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CustomViewHolder holder, int position) {

        Event currEvent = eventList.get(position);

        // Set holders for TextViews to values of the current Event
        holder.eventName.setText(currEvent.getName());
        holder.eventEmail.setText(currEvent.getEmailAddress());
        holder.eventInterested.setText(currEvent.getNumInterested());

        // Set holder for the ImageView to image of the current Event

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
            this.eventImage = (ImageView) (view.findViewById(R.id.event_image));
            this.eventName = (TextView) (view.findViewById(R.id.event_name));
            this.eventEmail = (TextView) (view.findViewById(R.id.event_email));
            this.eventInterested = (TextView) (view.findViewById(R.id.event_interested));

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                }
            });
            /*Think about what we said in the comment above onCreateViewHolder to determine the
            purpose of the ViewHolder. Does it make sense why we are doing this in the constructor?
            */

        }
    }
}

