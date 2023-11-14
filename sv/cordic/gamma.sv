module gamma_mem (
    input logic [4:0] iter,
    output logic [15:0] gamma
);

    assign gamma =  (iter == 4'h0) ? 16'h8000 :
                    (iter == 4'h1) ? 16'h4b90 :
                    (iter == 4'h2) ? 16'h27ed :
                    (iter == 4'h3) ? 16'h1444 :
                    (iter == 4'h4) ? 16'h0a2c :
                    (iter == 4'h5) ? 16'h0517 :
                    (iter == 4'h6) ? 16'h028b :
                    (iter == 4'h7) ? 16'h0145 :
                    (iter == 4'h8) ? 16'h00a2 :
                    (iter == 4'h9) ? 16'h0051 :
                    (iter == 4'ha) ? 16'h0028 :
                    (iter == 4'hb) ? 16'h0014 :
                    (iter == 4'hc) ? 16'h000a :
                    (iter == 4'hd) ? 16'h0005 :
                    (iter == 4'he) ? 16'h0002 :
                    (iter == 4'hf) ? 16'h0001 : 
                                     16'h0000;

endmodule