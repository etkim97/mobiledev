package kimnguyen.cs4640.bucketlist;


import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.TextView;
import android.widget.CheckBox;
import java.util.Collections;

import java.util.List;

// Create the basic adapter extending from RecyclerView.Adapter
// Note that we specify the custom ViewHolder which gives us access to our views
public class BucketListAdapter extends
        RecyclerView.Adapter<BucketListAdapter.ViewHolder> {

    // Provide a direct reference to each of the views within a data item
    // Used to cache the views within the item layout for fast access
    public static class ViewHolder extends RecyclerView.ViewHolder {
        // Your holder should contain a member variable
        // for any view that will be set as you render a row
        public CheckBox nameCheckBox;
        public TextView nameTextView;
        public TextView dateTextView;


        // We also create a constructor that accepts the entire item row
        // and does the view lookups to find each subview
        public ViewHolder(View itemView) {
            // Stores the itemView in a public final member variable that can be used
            // to access the context from any ViewHolder instance.
            super(itemView);

            nameCheckBox = (CheckBox) itemView.findViewById(R.id.bucket_name);
            nameTextView = (TextView) itemView.findViewById(R.id.name_text);
            dateTextView = (TextView) itemView.findViewById(R.id.date_text);

        }
    }

    private List<BucketItem> mBucketList;
    private Context mContext;

    // Pass in the contact array into the constructor
    public BucketListAdapter(Context context, List<BucketItem> contacts) {
        mBucketList = contacts;
        mContext = context;
    }

    private Context getContext() { return mContext; }
    // Usually involves inflating a layout from XML and returning the holder
    @Override
    public BucketListAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        Context context = parent.getContext();
        LayoutInflater inflater = LayoutInflater.from(context);

        // Inflate the custom layout
        View BucketListView = inflater.inflate(R.layout.content_bucket_list, parent, false);

        // Return a new holder instance
        ViewHolder viewHolder = new ViewHolder(BucketListView);
        return viewHolder;
    }

    // Involves populating data into the item through holder

    public void onBindViewHolder(BucketListAdapter.ViewHolder viewHolder, int position) {
        // Get the data model based on position
        final BucketItem bucketItem = mBucketList.get(position);

        // Set item views based on your views and data model
        CheckBox check = viewHolder.nameCheckBox;
        check.setChecked(bucketItem.getCompleted());
        check.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                bucketItem.setCompleted(!bucketItem.getCompleted());
                Collections.sort(mBucketList);
                notifyDataSetChanged();
            }
        });

        /*
        viewHolder.nameCheckBox.setOnCheckedChangeListener(null);
        viewHolder.nameCheckBox.setSelected(bucketItem.getCompleted());
        viewHolder.nameCheckBox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                if(b) {
                    bucketItem.setCompleted(true);
                    notifyDataSetChanged();
                }
                else {
                    bucketItem.setCompleted(false);
                    notifyDataSetChanged();
                }
            }
        });
        viewHolder.nameCheckBox.setChecked(bucketItem.getCompleted());
        */


        //textView.setText(bucketItem.getName());
        TextView ntext = viewHolder.nameTextView;
        ntext.setText(bucketItem.getName());

        TextView dtext = viewHolder.dateTextView;
        dtext.setText(bucketItem.getDate());
    }

    // Returns the total count of items in the list
    @Override
    public int getItemCount() {
        return mBucketList.size();
    }

}