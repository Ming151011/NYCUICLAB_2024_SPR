module CC(
  // Input signals
    opt,
    in_n0, in_n1, in_n2, in_n3, in_n4,  
  // Output signals
    out_n
);


input [3:0] in_n0, in_n1, in_n2, in_n3, in_n4;
input [2:0] opt;
output  [9:0] out_n;
///output reg [9:0] out_n;         					


//==================================================================
// reg & wire
//==================================================================

wire [3:0] n0_fir,n1_fir,n2_fir,n3_fir,n4_fir;
wire [3:0] n0_sec,n1_sec,n2_sec,n3_sec,n4_sec;
wire [3:0] n0_thi,n1_thi,n2_thi,n3_thi,n4_thi;
wire [3:0] n0_fou,n1_fou,n2_fou,n3_fou,n4_fou;
wire [3:0] n0_fif,n1_fif,n2_fif,n3_fif,n4_fif;
wire [4:0] avg2;
wire [3:0] avg3;
wire signed[7:0] sum;
wire [3:0] n01,n11,n21,n31,n41;
//wire signed[4:0] n01,n11,n21,n31,n41;

wire signed[4:0] avg;
wire signed[4:0] n0,n1,n2,n3,n4;
wire signed[9:0] out;
wire signed[9:0] out_1;
wire signed[9:0] out_n;




/////Sorting network for 5 inputs, 9 CEs //////////////////
///////////////// first change //////////
assign n0_fir = in_n0 <= in_n1 ? in_n0 : in_n1;
assign n1_fir = in_n0 <= in_n1 ? in_n1 : in_n0;
					   
assign n2_fir = in_n2 <= in_n3 ? in_n2 : in_n3;
assign n3_fir = in_n2 <= in_n3 ? in_n3 : in_n2;

assign n4_fir = in_n4 ;

///////////////// second change /////////
assign n0_sec = n0_fir;

assign n1_sec = n1_fir <= n3_fir ? n1_fir : n3_fir ;
assign n3_sec = n1_fir <= n3_fir ? n3_fir : n1_fir ;

assign n2_sec = n2_fir <= n4_fir ? n2_fir : n4_fir ;
assign n4_sec = n2_fir <= n4_fir ? n4_fir : n2_fir ;
	
///////////////// third change  /////////
assign n1_thi = n1_sec <= n4_sec ? n1_sec : n4_sec ;
assign n4_thi = n1_sec <= n4_sec ? n4_sec : n1_sec ;

assign n0_thi = n0_sec <= n2_sec ? n0_sec : n2_sec ;
assign n2_thi = n0_sec <= n2_sec ? n2_sec : n0_sec ;
	
assign n3_thi = n3_sec;

///////////////// Fourth change  //////////	
assign n1_fou = n1_thi <= n2_thi ? n1_thi  : n2_thi ;
assign n2_fou = n1_thi <= n2_thi ? n2_thi  : n1_thi ;
										  
assign n3_fou = n3_thi <= n4_thi ? n3_thi  : n4_thi ;
assign n4_fou = n3_thi <= n4_thi ? n4_thi  : n3_thi ;

assign n0_fou = n0_thi;

///////////////// Fifth change  //////////	
assign n2_fif = n2_fou <= n3_fou ? n2_fou  : n3_fou ;
assign n3_fif = n2_fou <= n3_fou ? n3_fou  : n2_fou ;

assign n0_fif = n0_fou;
assign n1_fif = n1_fou;
assign n4_fif = n4_fou;
///////////////////////////////////////////////////////////


assign n01 = opt[1]  ? n4_fif  :  n0_fif;
assign n11 = opt[1]  ? n3_fif  :  n1_fif;
assign n21 = opt[1]  ? n2_fif  :  n2_fif;                    
assign n31 = opt[1]  ? n1_fif  :  n3_fif; 
assign n41 = opt[1]  ? n0_fif  :  n4_fif;


assign avg2 = (n0_fif+n4_fif) ;
assign avg3 = avg2 >> 1 ;	

assign n0 = opt[0]  ? n01-avg3 : n01 ;
assign n1 = opt[0]  ? n11-avg3 : n11 ;
assign n2 = opt[0]  ? n21-avg3 : n21 ;
assign n3 = opt[0]  ? n31-avg3 : n31 ;
assign n4 = opt[0]  ? n41-avg3 : n41 ;



assign out = n3*3-n0*n4 ;
assign out_1 = out[9]  ? ~out+1 : out ;
assign sum = n0+n1+n2+n3+n4 ; 
assign avg = sum/5;
assign out_n = opt[2]  ? out_1 : (n0+n1*n2+avg*n3)/3;






endmodule
