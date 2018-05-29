package kimnguyen.cs4640.bucketlist;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.CalendarView;
import android.widget.EditText;
import android.util.Log;
import java.util.GregorianCalendar;

public class EditItemActivity extends AppCompatActivity {
    int index = 0;
    GregorianCalendar currDate;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_item);
        Toolbar toolbar = (Toolbar) findViewById(R.id.edittoolbar);
        //setSupportActionBar(toolbar);
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent backToBucketList = new Intent(getApplicationContext(), BucketListActivity.class);
                setResult(Activity.RESULT_CANCELED, backToBucketList);
                finish();
                //startActivity(backToBucketList);
            }
        });

        CalendarView simpleCalendarView = (CalendarView) findViewById(R.id.editsimpleCalendarView);

        simpleCalendarView.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
            @Override
            public void onSelectedDayChange(CalendarView view, int year, int month, int dayOfMonth) {
                currDate = new GregorianCalendar();
                currDate.set(year, month, dayOfMonth);
            }
        });

        Bundle extras = getIntent().getExtras();
        if(extras!=null){
            EditText text1 = (EditText) findViewById(R.id.editNameText);
            text1.setText(extras.getString("name"));

            EditText text2 = (EditText) findViewById(R.id.editDescText);
            text2.setText(extras.getString("description"));

            EditText text3 = (EditText) findViewById(R.id.editLatText);
            text3.setText(extras.getString("latitude"));

            EditText text4 = (EditText) findViewById(R.id.editLongText);
            text4.setText(extras.getString("longitude"));

            CalendarView cal = (CalendarView) findViewById(R.id.editsimpleCalendarView);
            cal.setDate(extras.getLong("date"));

            index = extras.getInt("index");

        }
    }

    public void editSubmit(View v){
        Intent intent = new Intent(getApplicationContext(), BucketListActivity.class);
        EditText text1 = (EditText) findViewById(R.id.editNameText);
        intent.putExtra("Name", text1.getText().toString());

        EditText text2 = (EditText) findViewById(R.id.editDescText);
        intent.putExtra("Description", text2.getText().toString());

        EditText text3 = (EditText) findViewById(R.id.editLatText);
        intent.putExtra("Latitude", text3.getText().toString());

        EditText text4 = (EditText) findViewById(R.id.editLongText);
        intent.putExtra("Longitude", text4.getText().toString());

        CalendarView cal = (CalendarView) findViewById(R.id.editsimpleCalendarView);
        if(currDate!=null){
            intent.putExtra("Date", currDate.getTimeInMillis());
        }
        else{
            intent.putExtra("Date", cal.getDate());
        }

        intent.putExtra("index", index);
        setResult(Activity.RESULT_OK, intent);
        finish();
    }
}
