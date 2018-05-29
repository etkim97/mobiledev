package kimnguyen.cs4640.bucketlist;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.content.Intent;
import android.widget.EditText;
import android.widget.CalendarView;
import android.util.Log;
import android.app.Activity;

import java.util.GregorianCalendar;

public class AddItemActivity extends AppCompatActivity {
    static final int ADD_ITEM_REQUEST = 1;
    GregorianCalendar currDate;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_item);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent backToBucketList = new Intent(getApplicationContext(), BucketListActivity.class);
                startActivity(backToBucketList);
            }
        });

        CalendarView simpleCalendarView = (CalendarView) findViewById(R.id.simpleCalendarView);

        simpleCalendarView.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
            @Override
            public void onSelectedDayChange(CalendarView view, int year, int month, int dayOfMonth) {
                currDate = new GregorianCalendar();
                currDate.set(year, month, dayOfMonth);
            }
        });

    }
    public void submit(View view) {
        Intent intent = new Intent(getApplicationContext(), BucketListActivity.class);

        EditText value = (EditText)findViewById(R.id.NameText);
        String userText = value.getText().toString();
        intent.putExtra("Name", userText);
        Log.d("bucket", "UserText: " + userText);
        EditText value2 = (EditText)findViewById(R.id.DescText);
        String userText2 = value2.getText().toString();
        intent.putExtra("Description", userText2);

        EditText value3 = (EditText)findViewById(R.id.LatText);
        String userText3 = value3.getText().toString();
        intent.putExtra("Latitude", userText3);

        EditText value4 = (EditText)findViewById(R.id.LongText);
        String userText4 = value4.getText().toString();
        intent.putExtra("Longitude", userText4);

        CalendarView simpleCalendarView = (CalendarView) findViewById(R.id.simpleCalendarView);
        long selectedDate = simpleCalendarView.getDate();
        if(currDate!=null){
            intent.putExtra("Date", currDate.getTimeInMillis());
        }
        else{
            intent.putExtra("Date", simpleCalendarView.getDate());
        }

        Log.d("bucket", "additem activity");
        setResult(Activity.RESULT_OK, intent);
        finish();
        //startActivity(intent);
    }
}
