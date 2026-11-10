package com.example.sleephollow;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import java.util.ArrayList;

public class MainActivity4 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main4);

        Spinner spinner = findViewById(R.id.spinner);
        TextView tvHeader = findViewById(R.id.tvHeader);
        TextView tvProducts = findViewById(R.id.tvProducts);
        String ssn = getIntent().getStringExtra("ssn");

        ArrayList<String> list = new ArrayList<>();
        RequestQueue queue = Volley.newRequestQueue(this);

        // Fill spinner with transaction IDs
        String url1 = "http://10.0.2.2:8080/sleepyhollow/Transactions.jsp?ssn=" + ssn;
        StringRequest req1 = new StringRequest(Request.Method.GET, url1,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String s) {
                        String[] rows = s.trim().split("#");
                        for (String row : rows) {
                            list.add(row.split(",")[0]);
                        }
                        ArrayAdapter<String> adapter = new ArrayAdapter<>(MainActivity4.this,
                                android.R.layout.simple_spinner_dropdown_item, list);
                        spinner.setAdapter(adapter);
                    }
                }, null);
        queue.add(req1);

        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String txnid = parent.getSelectedItem().toString();
                String url2 = "http://10.0.2.2:8080/sleepyhollow/TransactionDetails.jsp?txnid=" + txnid;

                StringRequest req2 = new StringRequest(Request.Method.GET, url2,
                        new Response.Listener<String>() {
                            @Override
                            public void onResponse(String s) {
                                String[] rows = s.trim().split("#");
                                String[] head = rows[0].split(",");

                                // Header: date + amount
                                tvHeader.setText(String.format("%-12s        $%s", head[0], head[1]));

                                // Products
                                StringBuilder sb = new StringBuilder();
                                sb.append(String.format("%-12s %-8s %-4s\n", "Prod Name", "Price", "Qty"));
                                sb.append("------------------------------\n");
                                for (int i = 1; i < rows.length; i++) {
                                    String[] c = rows[i].split(",");
                                    sb.append(String.format("%-12s %-8s %-4s\n", c[0], c[1], c[2]));
                                }
                                sb.append("------------------------------");
                                tvProducts.setText(sb.toString());
                            }
                        }, null);
                queue.add(req2);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
    }
}