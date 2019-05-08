module sigmoid_LUT(clk,resetn, enable,z, h);
    parameter DW =8; 
    input clk;
    input resetn;
    input enable;
    input [DW -1:0] z;
    output reg [DW -1:0] h;

  always @ (posedge clk or  negedge resetn)
  begin
    if(!resetn) begin
         h = 0;
         end
      
      else if (enable == 1) begin 
        case (z)
    8'b1: h = 8'b10000000;  // 0.5039
    8'b10: h = 8'b10000001;  // 0.5078
    8'b11: h = 8'b10000010;  // 0.5117
    8'b100: h = 8'b10000011;  // 0.5156
    8'b101: h = 8'b10000100;  // 0.5195
    8'b110: h = 8'b10000101;  // 0.5234
    8'b111: h = 8'b10000110;  // 0.5273
    8'b1000: h = 8'b10000111;  // 0.5312
    8'b1001: h = 8'b10001000;  // 0.5351
    8'b1010: h = 8'b10001001;  // 0.5390
    8'b1011: h = 8'b10001010;  // 0.5429
    8'b1100: h = 8'b10001011;  // 0.5467
    8'b1101: h = 8'b10001100;  // 0.5506
    8'b1110: h = 8'b10001101;  // 0.5545
    8'b1111: h = 8'b10001110;  // 0.5583
    8'b10000: h = 8'b10001111;  // 0.5622
    8'b10001: h = 8'b10010000;  // 0.5660
    8'b10010: h = 8'b10010001;  // 0.5699
    8'b10011: h = 8'b10010010;  // 0.5737
    8'b10100: h = 8'b10010011;  // 0.5775
    8'b10101: h = 8'b10010100;  // 0.5813
    8'b10110: h = 8'b10010101;  // 0.5851
    8'b10111: h = 8'b10010110;  // 0.5889
    8'b11000: h = 8'b10010111;  // 0.5927
    8'b11001: h = 8'b10011000;  // 0.5964
    8'b11010: h = 8'b10011001;  // 0.6002
    8'b11011: h = 8'b10011010;  // 0.6039
    8'b11100: h = 8'b10011011;  // 0.6077
    8'b11101: h = 8'b10011100;  // 0.6114
    8'b11110: h = 8'b10011101;  // 0.6151
    8'b11111: h = 8'b10011110;  // 0.6188
    8'b100000: h = 8'b10011111;  // 0.6225
    8'b100001: h = 8'b10100000;  // 0.6261
    8'b100010: h = 8'b10100001;  // 0.6298
    8'b100011: h = 8'b10100010;  // 0.6334
    8'b100100: h = 8'b10100011;  // 0.6370
    8'b100101: h = 8'b10100100;  // 0.6406
    8'b100110: h = 8'b10100100;  // 0.6442
    8'b100111: h = 8'b10100101;  // 0.6478
    8'b101000: h = 8'b10100110;  // 0.6514
    8'b101001: h = 8'b10100111;  // 0.6549
    8'b101010: h = 8'b10101000;  // 0.6584
    8'b101011: h = 8'b10101001;  // 0.6619
    8'b101100: h = 8'b10101010;  // 0.6654
    8'b101101: h = 8'b10101011;  // 0.6689
    8'b101110: h = 8'b10101100;  // 0.6723
    8'b101111: h = 8'b10101100;  // 0.6758
    8'b110000: h = 8'b10101101;  // 0.6792
    8'b110001: h = 8'b10101110;  // 0.6826
    8'b110010: h = 8'b10101111;  // 0.6859
    8'b110011: h = 8'b10110000;  // 0.6893
    8'b110100: h = 8'b10110001;  // 0.6926
    8'b110101: h = 8'b10110010;  // 0.6960
    8'b110110: h = 8'b10110011;  // 0.6993
    8'b110111: h = 8'b10110011;  // 0.7025
    8'b111000: h = 8'b10110100;  // 0.7058
    8'b111001: h = 8'b10110101;  // 0.7090
    8'b111010: h = 8'b10110110;  // 0.7122
    8'b111011: h = 8'b10110111;  // 0.7154
    8'b111100: h = 8'b10110111;  // 0.7186
    8'b111101: h = 8'b10111000;  // 0.7217
    8'b111110: h = 8'b10111001;  // 0.7249
    8'b111111: h = 8'b10111010;  // 0.7280
    8'b1000000: h = 8'b10111011;  // 0.7311
    8'b1000001: h = 8'b10111011;  // 0.7341
    8'b1000010: h = 8'b10111100;  // 0.7372
    8'b1000011: h = 8'b10111101;  // 0.7402
    8'b1000100: h = 8'b10111110;  // 0.7432
    8'b1000101: h = 8'b10111111;  // 0.7461
    8'b1000110: h = 8'b10111111;  // 0.7491
    8'b1000111: h = 8'b11000000;  // 0.7520
    8'b1001000: h = 8'b11000001;  // 0.7549
    8'b1001001: h = 8'b11000001;  // 0.7578
    8'b1001010: h = 8'b11000010;  // 0.7607
    8'b1001011: h = 8'b11000011;  // 0.7635
    8'b1001100: h = 8'b11000100;  // 0.7663
    8'b1001101: h = 8'b11000100;  // 0.7691
    8'b1001110: h = 8'b11000101;  // 0.7718
    8'b1001111: h = 8'b11000110;  // 0.7746
    8'b1010000: h = 8'b11000110;  // 0.7773
    8'b1010001: h = 8'b11000111;  // 0.7800
    8'b1010010: h = 8'b11001000;  // 0.7827
    8'b1010011: h = 8'b11001001;  // 0.7853
    8'b1010100: h = 8'b11001001;  // 0.7879
    8'b1010101: h = 8'b11001010;  // 0.7905
    8'b1010110: h = 8'b11001011;  // 0.7931
    8'b1010111: h = 8'b11001011;  // 0.7957
    8'b1011000: h = 8'b11001100;  // 0.7982
    8'b1011001: h = 8'b11001100;  // 0.8007
    8'b1011010: h = 8'b11001101;  // 0.8032
    8'b1011011: h = 8'b11001110;  // 0.8056
    8'b1011100: h = 8'b11001110;  // 0.8081
    8'b1011101: h = 8'b11001111;  // 0.8105
    8'b1011110: h = 8'b11010000;  // 0.8129
    8'b1011111: h = 8'b11010000;  // 0.8152
    8'b1100000: h = 8'b11010001;  // 0.8176
    8'b1100001: h = 8'b11010001;  // 0.8199
    8'b1100010: h = 8'b11010010;  // 0.8222
    8'b1100011: h = 8'b11010011;  // 0.8245
    8'b1100100: h = 8'b11010011;  // 0.8267
    8'b1100101: h = 8'b11010100;  // 0.8289
    8'b1100110: h = 8'b11010100;  // 0.8311
    8'b1100111: h = 8'b11010101;  // 0.8333
    8'b1101000: h = 8'b11010101;  // 0.8355
    8'b1101001: h = 8'b11010110;  // 0.8376
    8'b1101010: h = 8'b11010110;  // 0.8397
    8'b1101011: h = 8'b11010111;  // 0.8418
    8'b1101100: h = 8'b11011000;  // 0.8439
    8'b1101101: h = 8'b11011000;  // 0.8459
    8'b1101110: h = 8'b11011001;  // 0.8480
    8'b1101111: h = 8'b11011001;  // 0.8500
    8'b1110000: h = 8'b11011010;  // 0.8520
    8'b1110001: h = 8'b11011010;  // 0.8539
    8'b1110010: h = 8'b11011011;  // 0.8559
    8'b1110011: h = 8'b11011011;  // 0.8578
    8'b1110100: h = 8'b11011100;  // 0.8597
    8'b1110101: h = 8'b11011100;  // 0.8615
    8'b1110110: h = 8'b11011101;  // 0.8634
    8'b1110111: h = 8'b11011101;  // 0.8652
    8'b1111000: h = 8'b11011101;  // 0.8670
    8'b1111001: h = 8'b11011110;  // 0.8688
    8'b1111010: h = 8'b11011110;  // 0.8706
    8'b1111011: h = 8'b11011111;  // 0.8723
    8'b1111100: h = 8'b11011111;  // 0.8741
    8'b1111101: h = 8'b11100000;  // 0.8758
    8'b1111110: h = 8'b11100000;  // 0.8775
    8'b1111111: h = 8'b11100001;  // 0.8791
    8'b10000000: h = 8'b11100001;  // 0.8808
    8'b10000001: h = 8'b11100001;  // 0.8824
    8'b10000010: h = 8'b11100010;  // 0.8840
    8'b10000011: h = 8'b11100010;  // 0.8856
    8'b10000100: h = 8'b11100011;  // 0.8872
    8'b10000101: h = 8'b11100011;  // 0.8888
    8'b10000110: h = 8'b11100011;  // 0.8903
    8'b10000111: h = 8'b11100100;  // 0.8918
    8'b10001000: h = 8'b11100100;  // 0.8933
    8'b10001001: h = 8'b11100101;  // 0.8948
    8'b10001010: h = 8'b11100101;  // 0.8963
    8'b10001011: h = 8'b11100101;  // 0.8977
    8'b10001100: h = 8'b11100110;  // 0.8991
    8'b10001101: h = 8'b11100110;  // 0.9005
    8'b10001110: h = 8'b11100110;  // 0.9019
    8'b10001111: h = 8'b11100111;  // 0.9033
    8'b10010000: h = 8'b11100111;  // 0.9047
    8'b10010001: h = 8'b11100111;  // 0.9060
    8'b10010010: h = 8'b11101000;  // 0.9073
    8'b10010011: h = 8'b11101000;  // 0.9086
    8'b10010100: h = 8'b11101000;  // 0.9099
    8'b10010101: h = 8'b11101001;  // 0.9112
    8'b10010110: h = 8'b11101001;  // 0.9124
    8'b10010111: h = 8'b11101001;  // 0.9137
    8'b10011000: h = 8'b11101010;  // 0.9149
    8'b10011001: h = 8'b11101010;  // 0.9161
    8'b10011010: h = 8'b11101010;  // 0.9173
    8'b10011011: h = 8'b11101011;  // 0.9185
    8'b10011100: h = 8'b11101011;  // 0.9196
    8'b10011101: h = 8'b11101011;  // 0.9208
    8'b10011110: h = 8'b11101100;  // 0.9219
    8'b10011111: h = 8'b11101100;  // 0.9230
    8'b10100000: h = 8'b11101100;  // 0.9241
    8'b10100001: h = 8'b11101100;  // 0.9252
    8'b10100010: h = 8'b11101101;  // 0.9263
    8'b10100011: h = 8'b11101101;  // 0.9274
    8'b10100100: h = 8'b11101101;  // 0.9284
    8'b10100101: h = 8'b11101101;  // 0.9294
    8'b10100110: h = 8'b11101110;  // 0.9305
    8'b10100111: h = 8'b11101110;  // 0.9315
    8'b10101000: h = 8'b11101110;  // 0.9325
    8'b10101001: h = 8'b11101110;  // 0.9334
    8'b10101010: h = 8'b11101111;  // 0.9344
    8'b10101011: h = 8'b11101111;  // 0.9353
    8'b10101100: h = 8'b11101111;  // 0.9363
    8'b10101101: h = 8'b11101111;  // 0.9372
    8'b10101110: h = 8'b11110000;  // 0.9381
    8'b10101111: h = 8'b11110000;  // 0.9390
    8'b10110000: h = 8'b11110000;  // 0.9399
    8'b10110001: h = 8'b11110000;  // 0.9408
    8'b10110010: h = 8'b11110001;  // 0.9417
    8'b10110011: h = 8'b11110001;  // 0.9425
    8'b10110100: h = 8'b11110001;  // 0.9433
    8'b10110101: h = 8'b11110001;  // 0.9442
    8'b10110110: h = 8'b11110001;  // 0.9450
    8'b10110111: h = 8'b11110010;  // 0.9458
    8'b10111000: h = 8'b11110010;  // 0.9466
    8'b10111001: h = 8'b11110010;  // 0.9474
    8'b10111010: h = 8'b11110010;  // 0.9482
    8'b10111011: h = 8'b11110010;  // 0.9489
    8'b10111100: h = 8'b11110011;  // 0.9497
    8'b10111101: h = 8'b11110011;  // 0.9504
    8'b10111110: h = 8'b11110011;  // 0.9511
    8'b10111111: h = 8'b11110011;  // 0.9519
    8'b11000000: h = 8'b11110011;  // 0.9526
    8'b11000001: h = 8'b11110100;  // 0.9533
    8'b11000010: h = 8'b11110100;  // 0.9540
    8'b11000011: h = 8'b11110100;  // 0.9546
    8'b11000100: h = 8'b11110100;  // 0.9553
    8'b11000101: h = 8'b11110100;  // 0.9560
    8'b11000110: h = 8'b11110100;  // 0.9566
    8'b11000111: h = 8'b11110101;  // 0.9573
    8'b11001000: h = 8'b11110101;  // 0.9579
    8'b11001001: h = 8'b11110101;  // 0.9585
    8'b11001010: h = 8'b11110101;  // 0.9592
    8'b11001011: h = 8'b11110101;  // 0.9598
    8'b11001100: h = 8'b11110101;  // 0.9604
    8'b11001101: h = 8'b11110110;  // 0.9610
    8'b11001110: h = 8'b11110110;  // 0.9615
    8'b11001111: h = 8'b11110110;  // 0.9621
    8'b11010000: h = 8'b11110110;  // 0.9627
    8'b11010001: h = 8'b11110110;  // 0.9632
    8'b11010010: h = 8'b11110110;  // 0.9638
    8'b11010011: h = 8'b11110110;  // 0.9643
    8'b11010100: h = 8'b11110111;  // 0.9649
    8'b11010101: h = 8'b11110111;  // 0.9654
    8'b11010110: h = 8'b11110111;  // 0.9659
    8'b11010111: h = 8'b11110111;  // 0.9664
    8'b11011000: h = 8'b11110111;  // 0.9669
    8'b11011001: h = 8'b11110111;  // 0.9674
    8'b11011010: h = 8'b11110111;  // 0.9679
    8'b11011011: h = 8'b11110111;  // 0.9684
    8'b11011100: h = 8'b11111000;  // 0.9689
    8'b11011101: h = 8'b11111000;  // 0.9693
    8'b11011110: h = 8'b11111000;  // 0.9698
    8'b11011111: h = 8'b11111000;  // 0.9702
    8'b11100000: h = 8'b11111000;  // 0.9707
    8'b11100001: h = 8'b11111000;  // 0.9711
    8'b11100010: h = 8'b11111000;  // 0.9716
    8'b11100011: h = 8'b11111000;  // 0.9720
    8'b11100100: h = 8'b11111000;  // 0.9724
    8'b11100101: h = 8'b11111001;  // 0.9728
    8'b11100110: h = 8'b11111001;  // 0.9732
    8'b11100111: h = 8'b11111001;  // 0.9736
    8'b11101000: h = 8'b11111001;  // 0.9740
    8'b11101001: h = 8'b11111001;  // 0.9744
    8'b11101010: h = 8'b11111001;  // 0.9748
    8'b11101011: h = 8'b11111001;  // 0.9752
    8'b11101100: h = 8'b11111001;  // 0.9756
    8'b11101101: h = 8'b11111001;  // 0.9759
    8'b11101110: h = 8'b11111001;  // 0.9763
    8'b11101111: h = 8'b11111010;  // 0.9767
    8'b11110000: h = 8'b11111010;  // 0.9770
    8'b11110001: h = 8'b11111010;  // 0.9774
    8'b11110010: h = 8'b11111010;  // 0.9777
    8'b11110011: h = 8'b11111010;  // 0.9781
    8'b11110100: h = 8'b11111010;  // 0.9784
    8'b11110101: h = 8'b11111010;  // 0.9787
    8'b11110110: h = 8'b11111010;  // 0.9790
    8'b11110111: h = 8'b11111010;  // 0.9794
    8'b11111000: h = 8'b11111010;  // 0.9797
    8'b11111001: h = 8'b11111010;  // 0.9800
    8'b11111010: h = 8'b11111010;  // 0.9803
    8'b11111011: h = 8'b11111011;  // 0.9806
    8'b11111100: h = 8'b11111011;  // 0.9809
    8'b11111101: h = 8'b11111011;  // 0.9812
    8'b11111110: h = 8'b11111011;  // 0.9815
    8'b11111111: h = 8'b11111011;  // 0.9817
    8'b100000000: h = 8'b11111011;  // 0.9820
            default: h <= 0;
        endcase
    end
    end
endmodule
