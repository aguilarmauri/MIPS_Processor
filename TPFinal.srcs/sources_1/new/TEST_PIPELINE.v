`timescale 1ns / 1ps

module TEST_PIPELINE;

	// Inputs
	reg clk;
	reg reset;
	reg step;
	
	// Instantiate the Unit Under Test (UUT)
	Pipeline uut (
		.clk(clk),
		.reset(reset),
        .step(step)
	);

	initial begin
	
	  clk = 0;            // Para que funcione el negado del always
       
	  reset = 1; #200
      reset = 0;        
      #100
      step = 1; #200
      step = 0; #400
              
      step = 1; #200
      step = 0; #200
     
      step = 1; #200
      step = 0; #200
      
      step = 1; #200
      step = 0; #400

      step = 1; #200
      step = 0; #400       
      
      #1;                 // Debe terminar con ;

	end
	
	always #100 clk = ~clk;
      
endmodule
