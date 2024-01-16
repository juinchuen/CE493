module gamma_mem (
    input logic [4:0] iter,
    output logic [15:0] gamma
);

    assign gamma =  (iter == 5'h0) ? 16'h8000 :
                    (iter == 5'h1) ? 16'h4b90 :
                    (iter == 5'h2) ? 16'h27ed :
                    (iter == 5'h3) ? 16'h1444 :
                    (iter == 5'h4) ? 16'h0a2c :
                    (iter == 5'h5) ? 16'h0517 :
                    (iter == 5'h6) ? 16'h028b :
                    (iter == 5'h7) ? 16'h0145 :
                    (iter == 5'h8) ? 16'h00a2 :
                    (iter == 5'h9) ? 16'h0051 :
                    (iter == 5'ha) ? 16'h0028 :
                    (iter == 5'hb) ? 16'h0014 :
                    (iter == 5'hc) ? 16'h000a :
                    (iter == 5'hd) ? 16'h0005 :
                    (iter == 5'he) ? 16'h0002 :
                    (iter == 5'hf) ? 16'h0001 : 
                                     16'h0000;

endmodule