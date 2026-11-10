package com.example.sleephollow;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

public class MainActivity6 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main6);

        EditText etDest = findViewById(R.id.etDest);
        EditText etAmount = findViewById(R.id.etAmount);
        Button btnTransfer = findViewById(R.id.btnTransfer);

        String ssn = getIntent().getStringExtra("ssn");

        RequestQueue queue = Volley.newRequestQueue(this);

        btnTransfer.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String dest = etDest.getText().toString().trim();
                String amount = etAmount.getText().toString().trim();

                // Quick client-side validation to prevent bad requests
                if (dest.isEmpty() || amount.isEmpty()) {
                    Toast.makeText(MainActivity6.this, "Please fill in all fields", Toast.LENGTH_SHORT).show();
                    return;
                }

                String url = "http://10.0.2.2:8080/sleepyhollow/Transfer.jsp?ssn1=" + ssn + "&ssn2=" + dest + "&amount=" + amount;

                StringRequest req = new StringRequest(Request.Method.GET, url,
                        new Response.Listener<String>() {
                            @Override
                            public void onResponse(String response) {
                                String result = response.trim();

                                // Read the server response text.
                                if (result.equalsIgnoreCase("transfer completed")) {
                                    Toast.makeText(MainActivity6.this,
                                            "Transfer Executed Successfully",
                                            Toast.LENGTH_LONG).show();

                                    // Clear input fields on success
                                    etDest.setText("");
                                    etAmount.setText("");

                                } else if (result.equalsIgnoreCase("INVALID_DESTINATION")) {
                                    Toast.makeText(MainActivity6.this,
                                            "Error: Destination SSN not found in database!",
                                            Toast.LENGTH_LONG).show();

                                } else {
                                    Toast.makeText(MainActivity6.this,
                                            "Transfer Failed: Server Database Error",
                                            Toast.LENGTH_LONG).show();
                                }
                            }
                        }, null);
                queue.add(req);
            }
        });
    }
}