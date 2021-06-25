//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 2020/11/16 19:31:58
//// Design Name: 
//// Module Name: alu
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module alu(
//input [31:0]a,
//input [31:0]b,
//input [3:0]aluc,
//output reg [31:0]r,
//output reg zero,
//output reg carry,
//output reg negative,
//output reg overflow
//    );
//    reg[32:0]temp;
//    initial
//    begin r=0; carry=0; zero=0; negative=0; overflow=0; end
//    always @(a or b or aluc)
//    begin
//    case(aluc)
//    4'b0000://ADDU
//    begin
//        r=a+b;
//        temp=a+b;//判断进位
//        if(temp[32]==1)
//            carry=1;
//        else
//            carry=0;
//    end
//    4'b0010:
//    begin
//        r=$signed(a)+$signed(b);//ADD
//        if((a[31]==1&&b[31]==1&&r[31]==0)||(a[31]==0&&b[31]==0&&r[31]==1))
//            overflow=1;
//        else
//            overflow=0;
//    end
//    4'b0001://SUBU
//    begin
//        r=a-b;
//        if(a<b)
//            carry=1;
//        else
//            carry=0;
//    end
//    4'b0011:
//    begin
//        r=$signed(a)-$signed(b);//SUB
//        if((a[31]==1&&b[31]==0&&r[31]==0)||(a[31]==0&&b[31]==1&&r[31]==1))
//            overflow=1;
//        else
//            overflow=0;
//    end
//    4'b0100:r=a&b;//AND
//    4'b0101:r=a|b;//OR
//    4'b0110:r=a^b;//XOR
//    4'b0111:r=~(a|b);//NOR
//    4'b1000:r={b[15:0],16'b0};//LUI
//    4'b1001:r={b[15:0],16'b0};//LUI
//    4'b1011:
//    begin
//        r=($signed(a)<$signed(b))?1:0;//SLT
//        if($signed(a)<$signed(b))
//            negative=1;
//        else
//            negative=0;
//    end
//    4'b1010://SLTU
//    begin
//        r=(a<b)?1:0;
//        if(a<b)
//            carry=1;
//        else
//            carry=0;
//    end
//    4'b1100://SRA
//    begin
//        if(a==0)
//            carry=0;
//        else if(a<=32)
//            carry=b[a-1];
//        else
//            carry=b[31];
//        r=$signed(b)>>>a;
//    end
//    4'b1110://SLL/SLR
//    begin
//        if(a==0)
//            carry=0;
//        else if(a<=32)
//            carry=b[32-a];
//        else
//            carry=0;
//        r=b<<a;
//    end
//    4'b1111://SLL/SLR
//    begin
//        if(a==0)
//            carry=0;
//        else if(a<=32)
//            carry=b[32-a];
//        else
//            carry=0;
//        r=b<<a;
//    end
//    4'b1101://SRL
//    begin
//        if(a==0)
//            carry=0;
//        else if(a<=32)
//            carry=b[a-1];
//        else
//            carry=0;
//        r=b>>a;
//    end
//    default:r=0;
//    endcase
//    if(aluc==4'b1011||aluc==4'b1010)
//    begin
//        if(a==b) zero=1;
//        else     zero=0;
//    end
//    else
//    begin
//        if(r==0) zero=1;
//        else     zero=0;
//    end
//    if(aluc!=4'b1011)
//    begin
//        if(r[31]==1) negative=1;
//        else         negative=0;
//    end
//    end
//endmodule

// ALU.v
//module alu(
//        input [31:0] a,        //OP1
//        input [31:0] b,        //OP2
//        input [3:0] aluc,    //controller
//        output [31:0] r,    //result
//        output zero,
//        output carry,
//        output negative,
//        output overflow);
        
//    parameter Addu    =    4'b0000;    //r=a+b unsigned
//    parameter Add    =    4'b0010;    //r=a+b signed
//    parameter Subu    =    4'b0001;    //r=a-b unsigned
//    parameter Sub    =    4'b0011;    //r=a-b signed
//    parameter And    =    4'b0100;    //r=a&b
//    parameter Or    =    4'b0101;    //r=a|b
//    parameter Xor    =    4'b0110;    //r=a^b
//    parameter Nor    =    4'b0111;    //r=~(a|b)
//    parameter Lui1    =    4'b1000;    //r={b[15:0],16'b0}
//    parameter Lui2    =    4'b1001;    //r={b[15:0],16'b0}
//    parameter Slt    =    4'b1011;    //r=(a-b<0)?1:0 signed
//    parameter Sltu    =    4'b1010;    //r=(a-b<0)?1:0 unsigned
//    parameter Sra    =    4'b1100;    //r=b>>>a 
//    parameter Sll    =    4'b1110;    //r=b<<a
//    parameter Srl    =    4'b1101;    //r=b>>a
    
//    parameter bits=31;
//    parameter ENABLE=1,DISABLE=0;
    
//    reg [32:0] result;
//    wire signed [31:0] sa=a,sb=b;
    
//    always@(*)begin
//        case(aluc)
//            Addu: begin
//                result=a+b;
//            end
//            Subu: begin
//                result=a-b;
//            end
//            Add: begin
//                result=sa+sb;
//            end
//            Sub: begin
//                result=sa-sb;
//            end
//            Sra: begin
//                if(a==0) {result[31:0],result[32]}={b,1'b0};
//                else {result[31:0],result[32]}=sb>>>(a-1);
//            end
//            Srl: begin
//                if(a==0) {result[31:0],result[32]}={b,1'b0};
//                else {result[31:0],result[32]}=b>>(a-1);
//            end
//            Sll: begin
//                result=b<<a;
//            end
//            And: begin
//                result=a&b;
//            end
//            Or: begin
//                result=a|b;
//            end
//            Xor: begin
//                result=a^b;
//            end
//            Nor: begin
//                result=~(a|b);
//            end
//            Sltu: begin
//                result=a<b?1:0;
//            end
//            Slt: begin
//                result=sa<sb?1:0;
//            end
//            Lui1,Lui2: result = {b[15:0], 16'b0};
//            default:
//                result=a+b;
//        endcase
//    end
    
//    assign r=result[31:0];
//    assign carry = result[32]; 
//    assign zero=(r==32'b0)?1:0;
//    assign negative=result[31];
//    assign overflow=result[32];
//endmodule
module alu(
input [31:0]a,
input [31:0]b,
input [3:0]aluc,
output reg [31:0]r,
output zero,
output reg carry,
output reg negative,
output reg overflow

    );
    assign zero=(aluc==4'b1011||aluc==4'b1010)?(a==b):(r==0)?1:0;
    reg[32:0]temp;
    initial
    begin r=0; carry=0; negative=0; overflow=0; end
    always @(a or b or aluc)
    begin
    case(aluc)
    4'b0000://ADDU
    begin
        r=a+b;
        temp=a+b;//判断进位
        if(temp[32]==1)
            carry=1;
        else
            carry=0;
    end
    4'b0010:
    begin
        r=$signed(a)+$signed(b);//ADD
        if((a[31]==1&&b[31]==1&&r[31]==0)||(a[31]==0&&b[31]==0&&r[31]==1))
            overflow=1;
        else
            overflow=0;
    end
    4'b0001://SUBU
    begin
        r=a-b;
        if(a<b)
        begin
            carry=1;
            //negative=1;
        end
        else
        begin
            carry=0;
            //negative=0;
            end
    end
    4'b0011:
    begin
        r=$signed(a)-$signed(b);//SUB
        if((a[31]==1&&b[31]==0&&r[31]==0)||(a[31]==0&&b[31]==1&&r[31]==1))
            overflow=1;
        else
            overflow=0;
        if($signed(a)<$signed(b))
                   begin
                       carry=1;
                       //negative=1;
                   end
       else
                   begin
                       carry=0;
                       //negative=0;
                       end     
    end
    4'b0100:r=a&b;//AND
    4'b0101:r=a|b;//OR
    4'b0110:r=a^b;//XOR
    4'b0111:r=~(a|b);//NOR
    4'b1000:r={b[15:0],16'b0};//LUI
    4'b1001:r={b[15:0],16'b0};//LUI
    4'b1011:
    begin
        r=($signed(a)<$signed(b))?1:0;//SLT
        if($signed(a)<$signed(b))
            negative=1;
        else
            negative=0;
    end
    4'b1010://SLTU
    begin
        r=(a<b)?1:0;
        if(a<b)
            carry=1;
        else
            carry=0;
    end
    4'b1100://SRA
    begin
        if(a==0)
            carry=0;
        else if(a<=32)
            carry=b[a-1];
        else
            carry=b[31];
        r=$signed(b)>>>a;
    end
    4'b1110://SLL/SLR
    begin
        if(a==0)
            carry=0;
        else if(a<=32)
            carry=b[32-a];
        else
            carry=0;
        r=b<<a;
    end
    4'b1111://SLL/SLR
    begin
        if(a==0)
            carry=0;
        else if(a<=32)
            carry=b[32-a];
        else
            carry=0;
        r=b<<a;
    end
    4'b1101://SRL
    begin
        if(a==0)
            carry=0;
        else if(a<=32)
            carry=b[a-1];
        else
            carry=0;
        r=b>>a;
    end
    default:r=0;
    endcase
//    if(aluc==4'b1011||aluc==4'b1010)
//    begin
//        if(a==b) zero=1;
//        else     zero=0;
//    end
//    else
//    begin
//        if(r==0) zero=1;
//        else     zero=0;
//    end
    if(aluc!=4'b1011)
    begin
        if(r[31]==1) negative=1;
        else         negative=0;
    end
    end
endmodule